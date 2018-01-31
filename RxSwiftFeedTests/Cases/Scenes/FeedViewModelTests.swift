//
//  FeedViewModelTests.swift
//  RxSwiftFeedTests
//
//  Created by Amadeu Andrade on 31/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import XCTest
import RxSwift

@testable import RxSwiftFeed

class FeedViewModelTests: XCTestCase {
  
  var viewModel: FeedViewModel!
  var bag: DisposeBag!

  override func setUp() {
    super.setUp()
    let githubProvider = MockGithubAPIClient()
    let dependencyContainer = DependencyContainer(githubProvider: githubProvider)
    viewModel = FeedViewModel(dependencies: dependencyContainer)
    bag = DisposeBag()
  }
  
  override func tearDown() {
    super.tearDown()
    viewModel = nil
    bag = nil
  }
  
  func testFetchEvents() {
    let someExpectation = expectation(description: "Fetch events succesfully")

    viewModel.fetch()
    
    viewModel.eventViewModels
      .drive(onNext: { eventViewModels in
        XCTAssertGreaterThan(eventViewModels.count, 0)
        someExpectation.fulfill()
    })
    .disposed(by: bag)
    
    wait(for: [someExpectation], timeout: 1)
  }
  
  // TODO: - Added test for empty result
  // TODO: - Added test with error while fetching
  
}
