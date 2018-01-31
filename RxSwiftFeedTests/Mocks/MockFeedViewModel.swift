//
//  MockFeedViewModel.swift
//  RxSwiftFeedTests
//
//  Created by Amadeu Andrade on 31/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

@testable import RxSwiftFeed

class MockFeedViewModel: FeedViewModelRepresentable {
  
  var calledEventViewModels = false
  
  var eventViewModels: Driver<[EventCellViewModel]> {
    calledEventViewModels = true
    let repository = Repository(name: "repo")
    let actor = Actor(name: "actor", avatarUrlString: "")
    let event = Event(repository: repository, actor: actor, action: "action")
    let cellViewModel = EventCellViewModel(event)
    return BehaviorRelay(value: [cellViewModel]).asDriver()
  }
  
}
