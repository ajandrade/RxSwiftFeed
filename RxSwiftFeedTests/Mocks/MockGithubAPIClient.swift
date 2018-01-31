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
  
  func fetchEvents(for identifier: String) -> Single<Data> {
    let repository = Repository(name: "repo")
    let actor = Actor(name: "actor", avatarUrlString: "")
    let event = Event(repository: repository, actor: actor, action: "action")
    let jsonEncoder = JSONEncoder()
    let jsonData = try! jsonEncoder.encode([event])
    return Single.just(jsonData)
  }
  
}
