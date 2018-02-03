//
//  EventTests.swift
//  RxSwiftFeedTests
//
//  Created by Amadeu Andrade on 29/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import XCTest
@testable import RxSwiftFeed

class EventTests: XCTestCase {
  
  var repository: Repository!
  var actor: Actor!
  var action: String!
    
  override func setUp() {
    super.setUp()
    repository = Repository(name: "")
    actor = Actor(name: "", avatarUrlString: "")
    action = ""
  }
  
  override func tearDown() {
    super.tearDown()
    repository = nil
    actor = nil
    action = ""
  }
  
  func testIsDecodable() {
    let testData = loadJSONData()
    let event = try? JSONDecoder().decode(Event.self, from: testData)
    XCTAssertNotNil(event)
  }
  
  func testIsCodable() {
    let event = Event(repository: repository, actor: actor, action: action)
    let encodedData = try? JSONEncoder().encode(event)
    XCTAssertNotNil(encodedData)
  }
  
  func testDecodeEventsReturnsEmptyIfDecodesFail() {
    let testData = loadJSONData()
    let events = Event.decodeEvents(testData)
    XCTAssertNotNil(events)
    XCTAssertEqual(events.count, 0)
  }
  
  func testDecodeEvents() {
    let testData = loadJSONData(multipleEvents: true)
    let events = Event.decodeEvents(testData)
    XCTAssertNotNil(events)
    XCTAssertGreaterThan(events.count, 0)
  }

  
  func testRepositoryIsSetOnInit() {
    let event = Event(repository: repository, actor: actor, action: action)
    XCTAssertEqual(event.repository, repository)
  }
  
  func testActorIsSetOnInit() {
    let event = Event(repository: repository, actor: actor, action: action)
    XCTAssertEqual(event.actor, actor)
  }
  
  func testActionIsSetOnInit() {
    let event = Event(repository: repository, actor: actor, action: action)
    XCTAssertEqual(event.action, action)
  }
  
  func testEquality() {
    let event1 = Event(repository: repository, actor: actor, action: action)
    let event2 = Event(repository: repository, actor: actor, action: action)
    XCTAssertEqual(event1, event2)
  }
  
}

extension EventTests {
  
  func loadJSONData(multipleEvents: Bool = false) -> Data {
    let bundle = Bundle(for: type(of: self))
    let path: String
    if multipleEvents {
      path = bundle.path(forResource: "Events", ofType: "json")!
    } else {
      path = bundle.path(forResource: "Event", ofType: "json")!
    }
    let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    return data
  }
  
}

