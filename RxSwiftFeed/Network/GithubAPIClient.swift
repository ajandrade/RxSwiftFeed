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
  
  private let session: URLSession
  
  // MARK: - INITIALIZER
  
  init(session: URLSession = URLSession.shared) {
    self.session = session
  }
  
  // MARK: - FUNCTIONS
  
  func fetchEvents(for identifier: String) -> Single<NetworkResult> {
    return session
      .rx
      .response(request: GithubAPI.events(identifier).asURLRequest())
      .debug()
      .retry(3)
      .filterSuccessfulStatusCodes()
      .asSingle()
  }
  
}
