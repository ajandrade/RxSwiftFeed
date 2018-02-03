//
//  EventCellTests.swift
//  RxSwiftFeedTests
//
//  Created by Amadeu Andrade on 31/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import XCTest
@testable import RxSwiftFeed

class EventCellTests: XCTestCase {
  
  var cell: EventCell!
  var viewModel: EventCellViewModel!
  
  override func setUp() {
    super.setUp()
    let bundle = Bundle(for: EventCell.self)
    cell = bundle.loadNibNamed(EventCell.identifier, owner: nil)!.first as! EventCell
    
    let repository = Repository(name: "repo")
    let actor = Actor(name: "actor", avatarUrlString: "")
    let event = Event(repository: repository, actor: actor, action: "action")
    viewModel = EventCellViewModel(event)
    cell.configure(with: viewModel)
  }
  
  override func tearDown() {
    super.tearDown()
    cell = nil
  }
  
  func testUILabelTitleIsConnected() {
    XCTAssertNotNil(cell.titleLabel)
  }
  
  func testUILabelDescriptionIsConnected() {
    XCTAssertNotNil(cell.descriptionLabel)
  }
  
  func testUIImageViewAvatarIsConnected() {
    XCTAssertNotNil(cell.avatarImageView)
  }

  func testTitleIsSet() {
    XCTAssertEqual(cell.titleLabel.text, viewModel.title)
  }
  
  func testDescriptionIsSet() {
    XCTAssertEqual(cell.descriptionLabel.text, viewModel.eventDescription)
  }
  
}
