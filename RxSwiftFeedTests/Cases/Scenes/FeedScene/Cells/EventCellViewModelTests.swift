//
//  EventCellViewModelTests.swift
//  RxSwiftFeedTests
//
//  Created by Amadeu Andrade on 31/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import XCTest
@testable import RxSwiftFeed

class EventCellViewModelTests: XCTestCase {
  
  var viewModel: EventCellViewModel!
  
  var repository: Repository!
  var actor: Actor!
  var event: Event!
  
  override func setUp() {
    super.setUp()
    repository = Repository(name: "repo")
    actor = Actor(name: "actor", avatarUrlString: "")
    event = Event(repository: repository, actor: actor, action: "action")
    viewModel = EventCellViewModel(event)
  }
  
  override func tearDown() {
    super.tearDown()
    viewModel = nil
    repository = nil
    actor = nil
    event = nil
  }
  
  func testTitleIsSet() {
    XCTAssertEqual(viewModel.title, actor.name)
  }
  
  func testNameIsSet() {
    let eventDescription = repository.name  + ", " + event.action.replacingOccurrences(of: "Event", with: "").lowercased()
    XCTAssertEqual(viewModel.eventDescription, eventDescription)
  }
 
}
