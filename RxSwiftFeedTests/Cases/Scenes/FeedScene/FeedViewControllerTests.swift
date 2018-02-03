//
//  FeedViewControllerTests.swift
//  RxSwiftFeedTests
//
//  Created by Amadeu Andrade on 31/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import XCTest
@testable import RxSwiftFeed

class FeedViewControllerTests: XCTestCase {
  
  var viewController: FeedViewController!
  var viewModel: MockFeedViewModel!
  
  override func setUp() {
    super.setUp()
    viewController = FeedViewController(nibName: FeedViewController.identifier, bundle: nil)
    viewModel = MockFeedViewModel()
    viewController.viewModel = viewModel
    viewController.loadViewIfNeeded()
  }
  
  override func tearDown() {
    super.tearDown()
    viewController = nil
    viewModel = nil
  }
  
  func testUITableViewIsConnected() {
    XCTAssertNotNil(viewController.tableView)
  }
  
  func testRefreshControlIsSet() {
    XCTAssertNotNil(viewController.tableView.refreshControl)
  }
  
  func testEventCellIsRegistered() {
    let tableView = viewController.tableView
    let cell = tableView?.dequeueReusableCell(withIdentifier: EventCell.identifier) as? EventCell
    XCTAssertNotNil(cell)
  }
  
  func testUITableViewDataSourceIsSet() {
    XCTAssertNotNil(viewController.tableView.dataSource)
  }
  
  func testUITableViewDataSourceDataIsSetByViewModel() {
    let numberOfRows = viewController.tableView.numberOfRows(inSection: 0)
    XCTAssertTrue(viewModel.calledEventViewModels)
    XCTAssertEqual(numberOfRows, 1)
  }
  
  func testUITableViewRowHeightIsDefinedHas75() {
    XCTAssertEqual(viewController.tableView.rowHeight, 75)
  }
  
}
