//
//  RepositoryTests.swift
//  RxSwiftFeedTests
//
//  Created by Amadeu Andrade on 29/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import XCTest
@testable import RxSwiftFeed

class RepositoryTests: XCTestCase {
  
  var _name: String!
  
  override func setUp() {
    super.setUp()
    _name = ""
  }
  
  override func tearDown() {
    super.tearDown()
    _name = nil
  }
  
  func testIsDecodable() {
    let testData = loadJSONData()
    let repository = try? JSONDecoder().decode(Repository.self, from: testData)
    XCTAssertNotNil(repository)
  }
  
  func testNameIsSetOnInit() {
    let repository = Repository(name: _name)
    XCTAssertEqual(repository.name, _name)
  }
  
  func testEquality() {
    let repository1 = Repository(name: _name)
    let repository2 = Repository(name: _name)
    XCTAssertEqual(repository1, repository2)
  }
  
}

extension RepositoryTests {
  
  func loadJSONData() -> Data {
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: "Repository", ofType: "json")!
    let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    return data
  }
  
}
