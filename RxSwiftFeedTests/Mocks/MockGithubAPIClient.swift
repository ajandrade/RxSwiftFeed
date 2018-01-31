//
//  MockGithubAPIClient.swift
//  RxSwiftFeedTests
//
//  Created by Amadeu Andrade on 31/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

@testable import RxSwiftFeed

class MockGithubAPIClient: GithubAPIClientProtocol {
  
  private let type: DataType
  
  enum DataType { case success, failure, empty }
  
  init(type: DataType) {
    self.type = type
  }
  
  func fetchEvents(for identifier: String) -> Single<Data> {
    let repository = Repository(name: "repo")
    let actor = Actor(name: "actor", avatarUrlString: "")
    let event = Event(repository: repository, actor: actor, action: "action")
    let jsonEncoder = JSONEncoder()
    let jsonData: Data
    switch type {
    case .success:
      jsonData = try! jsonEncoder.encode([event])
    case .empty:
      jsonData = try! jsonEncoder.encode(event)
    case .failure:
      let err = NetworkError.unknown
      return Single.error(err)
    }
    return Single.just(jsonData)
  }
  
}
