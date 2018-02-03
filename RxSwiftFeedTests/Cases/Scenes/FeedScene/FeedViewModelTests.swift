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
    bag = DisposeBag()
  }
  
  override func tearDown() {
    super.tearDown()
    viewModel = nil
    bag = nil
  }
  
  func testFetchEvents() {
    let githubProvider = MockGithubAPIClient(type: .success)
    let dependencyContainer = DependencyContainer(githubProvider: githubProvider)
    viewModel = FeedViewModel(dependencies: dependencyContainer)
    
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
  
  func testFetchEventsWithEmptyResponse() {
    let githubProvider = MockGithubAPIClient(type: .empty)
    let dependencyContainer = DependencyContainer(githubProvider: githubProvider)
    viewModel = FeedViewModel(dependencies: dependencyContainer)
    
    let someExpectation = expectation(description: "Parse failed!")
    
    viewModel.fetch()
    
    viewModel.eventViewModels
      .drive(onNext: { eventViewModels in
        XCTAssertEqual(eventViewModels.count, 0)
        someExpectation.fulfill()
      })
      .disposed(by: bag)
    
    wait(for: [someExpectation], timeout: 1)
  }
  
  func testFetchEventsWithError() {
    let githubProvider = MockGithubAPIClient(type: .failure)
    let dependencyContainer = DependencyContainer(githubProvider: githubProvider)
    viewModel = FeedViewModel(dependencies: dependencyContainer)
    
    let errorExpectation = expectation(description: "Error")
    
    viewModel.fetch()
    
    viewModel.eventViewModels
      .asObservable()
      .subscribe(onNext: { events in
        if events.isEmpty {
          errorExpectation.fulfill()
        } else {
          XCTFail()
        }
      })
      .disposed(by: bag)
    
    wait(for: [errorExpectation], timeout: 1)
  }
  
}
