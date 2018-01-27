//
//  RootCoordinatorTests.swift
//  RxSwiftFeedTests
//
//  Created by Amadeu Andrade on 27/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import XCTest
@testable import RxSwiftFeed

class RootCoordinatorTests: XCTestCase {
  
  var coordinator: RootCoordinator!
  var mockNavController: MockNavigationController!
  var navigator: NavigatorRepresentable!

  override func setUp() {
    super.setUp()
    mockNavController = MockNavigationController()
    navigator = Navigator(navigationController: mockNavController)
    coordinator = RootCoordinator(window: UIWindow(), navigator: navigator)
    coordinator.start()
  }
  
  override func tearDown() {
    super.tearDown()
    mockNavController = nil
    navigator = nil
    coordinator = nil
  }
  
  func testFeedCoordinatorIsSet() {
    XCTAssertTrue(mockNavController.addedViewController is FeedViewController)
  }
  
}
