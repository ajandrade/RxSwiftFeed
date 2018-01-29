//
//  ActorTests.swift
//  RxSwiftFeedTests
//
//  Created by Amadeu Andrade on 29/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import XCTest
@testable import RxSwiftFeed

class ActorTests: XCTestCase {
  
  var login: String!
  var avatarUrlString: String!
  
  override func setUp() {
    super.setUp()
    login = ""
    avatarUrlString = ""
  }
  
  override func tearDown() {
    super.tearDown()
    login = nil
    avatarUrlString = nil
  }
  
  func testIsDecodable() {
    let testData = loadJSONData()
    let actor = try? JSONDecoder().decode(Actor.self, from: testData)
    XCTAssertNotNil(actor)
  }
  
  func testLoginIsSetOnInit() {
    let actor = Actor(login: login, avatarUrlString: avatarUrlString)
    XCTAssertEqual(actor.login, login)
  }
  
  func testAvatarUrlIsSetOnInit() {
    let actor = Actor(login: login, avatarUrlString: avatarUrlString)
    XCTAssertEqual(actor.avatarUrlString, avatarUrlString)
  }
  
  func testEquality() {
    let actor1 = Actor(login: login, avatarUrlString: avatarUrlString)
    let actor2 = Actor(login: login, avatarUrlString: avatarUrlString)
    XCTAssertEqual(actor1, actor2)
  }
    
}

extension ActorTests {
  
  func loadJSONData() -> Data {
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: "Actor", ofType: "json")!
    let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    return data
  }
  
}
