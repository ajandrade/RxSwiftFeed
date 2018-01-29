//
//  FeedCoordinatorTests.swift
//  RxSwiftFeedTests
//
//  Created by Amadeu Andrade on 27/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import XCTest
@testable import RxSwiftFeed

class FeedCoordinatorTests: XCTestCase {
  
  var coordinator: FeedCoordinator!
  var mockNavController: MockNavigationController!
  var navigator: NavigatorRepresentable!
  
  override func setUp() {
    super.setUp()
    mockNavController = MockNavigationController()
    navigator = Navigator(navigationController: mockNavController)
    let dependencies = DependencyContainer(githubProvider: GithubAPIClient())
    coordinator = FeedCoordinator(navigator: navigator, dependencies: dependencies)
    coordinator.start()
  }
  
  override func tearDown() {
    super.tearDown()
    mockNavController = nil
    navigator = nil
    coordinator = nil
  }
  
  // MARK: - INITIALIZATION TESTS

  func testViewControllerIsSetOnStart() {
    XCTAssertTrue(mockNavController.addedViewController is FeedViewController)
  }
  
  func testViewModelIsSetOnStart() {
    let feedVC = mockNavController.addedViewController as! FeedViewController
    let feedVM = feedVC.viewModel
    XCTAssertNotNil(feedVM)
    XCTAssertTrue(feedVM is FeedViewModel)
  }

}
