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
  
  func fetchEvents(for identifier: String) -> Single<NetworkResult> {
    return URLSession
      .shared
      .rx
      .response(request: GithubAPI.events(identifier).asURLRequest())
      .debug()
      .retry(3)
      .filterSuccessfulStatusCodes()
      .asSingle()
  }
  
}
