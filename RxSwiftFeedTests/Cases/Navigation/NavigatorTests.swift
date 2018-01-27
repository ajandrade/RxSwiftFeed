//
//  NavigatorTests.swift
//  RxSwiftFeedTests
//
//  Created by Amadeu Andrade on 27/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import XCTest
@testable import RxSwiftFeed

class NavigatorTests: XCTestCase {
  
  var mockNavController: MockNavigationController!
  var navigator: Navigator!
  
  override func setUp() {
    super.setUp()
    mockNavController = MockNavigationController()
    navigator = Navigator(navigationController: mockNavController)
  }
  
  override func tearDown() {
    super.tearDown()
    mockNavController = nil
    navigator = nil
  }
  
  func testRootIsSet() {
    navigator.transition(to: UIViewController(), type: .root)
    XCTAssertTrue(mockNavController.setRoot)
    XCTAssertFalse(mockNavController.setPresent)
    XCTAssertFalse(mockNavController.setPush)
  }
  
  func testPushIsSet() {
    navigator.transition(to: UIViewController(), type: .push)
    XCTAssertTrue(mockNavController.setPush)
    XCTAssertFalse(mockNavController.setPresent)
    XCTAssertFalse(mockNavController.setRoot)
  }
  
  func testPresentIsSet() {
    navigator.transition(to: UIViewController(), type: .modal)
    XCTAssertTrue(mockNavController.setPresent)
    XCTAssertFalse(mockNavController.setRoot)
    XCTAssertFalse(mockNavController.setPush)
  }
  
  // TODO: - Add dismiss test
  // func testDismiss() { }

}
