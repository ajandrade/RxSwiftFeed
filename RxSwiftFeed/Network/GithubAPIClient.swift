//
//  GithubAPIClient.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 28/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import RxSwift
import RxCocoa

protocol GithubAPIClientProtocol {
  func fetchEvents(for identifier: String) -> Single<NetworkResult>
}

class GithubAPIClient: GithubAPIClientProtocol {
  
  // MARK: - PROPERTIES
  
  private let session: URLSessionProtocol
  
  // MARK: - INITIALIZER
  
  init(session: URLSessionProtocol = URLSession.shared) {
    self.session = session
  }
  
  // MARK: - FUNCTIONS
  
  func fetchEvents(for identifier: String) -> Single<NetworkResult> {
    let url = GithubAPI.events(identifier).asURLRequest()
    return Single.create(subscribe: { observer in
      let task = self.session.dataTask(with: url, completionHandler: { data, response, error in
        guard let response = response, let data = data else {
          observer(.error(error ?? RxCocoaURLError.unknown))
          return
        }
        guard let httpResponse = response as? HTTPURLResponse else {
          observer(.error(RxCocoaURLError.nonHTTPResponse(response: response)))
          return
        }
        guard (200...299).contains(httpResponse.statusCode) else {
          observer(.success(Result.failure(NetworkError.withCode(httpResponse.statusCode))))
          return
        }
        observer(.success(Result.success(data)))
      })
      
      task.resume()
      
      return Disposables.create(with: task.cancel)
    })
      .debug()
      .retry(2)
    
//    return session
//      .rx
//      .response(request: GithubAPI.events(identifier).asURLRequest())
//      .debug()
//      .retry(3)
//      .filterSuccessfulStatusCodes()
//      .asSingle()
  }
  
}
