//
//  GithubAPIClientTests.swift
//  RxSwiftFeedTests
//
//  Created by Amadeu Andrade on 28/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa

@testable import RxSwiftFeed

class GithubAPIClientTests: XCTestCase {
  
  var apiClient: GithubAPIClient!
  var mockSession: MockURLSession!
  var testData: Data!
  var bag: DisposeBag!
  
  override func setUp() {
    super.setUp()
    bag = DisposeBag()
    testData = loadJSONData()
  }
  
  override func tearDown() {
    super.tearDown()
    mockSession = nil
    apiClient = nil
    testData = nil
    bag = nil
  }
  
  func testEndpointIsCorrect() {
    mockSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
    apiClient = GithubAPIClient(session: mockSession)
  
    let identifier = "ReactiveX/RxSwift"
    let urlToMatch = GithubAPI.events(identifier).asURLRequest()

    let request = apiClient.fetchEvents(for: identifier)
    request.subscribe().disposed(by: bag)
    
    XCTAssertEqual(mockSession.request, urlToMatch)
  }
  
  func testNoResponseErrorIsHandled() {
    mockSession = MockURLSession(data: nil, urlResponse: nil, error: nil)
    apiClient = GithubAPIClient(session: mockSession)

    let errorExpectation = expectation(description: "Error")
    let errorToMatch = NetworkError.unknown.localizedDescription
    
    let request = apiClient.fetchEvents(for: "ReactiveX/RxSwift")
    
    request.subscribe(onSuccess: { _ in
      XCTFail()
    }, onError: { error in
      XCTAssertEqual(error.localizedDescription, errorToMatch)
      errorExpectation.fulfill()
    }).disposed(by: bag)

    wait(for: [errorExpectation], timeout: 1)
  }

  func testNoHTTPResponseIsHandled() {
    let urlResponse = URLResponse()
    mockSession = MockURLSession(data: testData, urlResponse: urlResponse, error: nil)
    apiClient = GithubAPIClient(session: mockSession)
    
    let errorExpectation = expectation(description: "Error")
    let errorToMatch = NetworkError.response.localizedDescription
    
    let request = apiClient.fetchEvents(for: "ReactiveX/RxSwift")
    request.subscribe(onSuccess: { _ in
      XCTFail()
    }, onError: { error in
      XCTAssertEqual(error.localizedDescription, errorToMatch)
      errorExpectation.fulfill()
    }).disposed(by: bag)
    
    wait(for: [errorExpectation], timeout: 1)
  }
  
  func testUnsuccessfulStatusCodeIsHandled() {
    let urlResponse = createResponse(for: .failure)
    mockSession = MockURLSession(data: testData, urlResponse: urlResponse, error: nil)
    apiClient = GithubAPIClient(session: mockSession)
    
    let errorExpectation = expectation(description: "Error")
    
    let request = apiClient.fetchEvents(for: "ReactiveX/RxSwift")
    request.subscribe(onSuccess: { _ in
      XCTFail()
    }, onError: { error in
      if let err = error as? NetworkError, case let NetworkError.withCode(code) = err {
        XCTAssertEqual(code, 404)
        errorExpectation.fulfill()
      } else {
        XCTFail()
      }
    })
      .disposed(by: bag)
    
    wait(for: [errorExpectation], timeout: 1)
  }
  
  func testSuccessfulRequest() {
    let urlResponse = createResponse(for: .success)
    mockSession = MockURLSession(data: testData, urlResponse: urlResponse, error: nil)
    apiClient = GithubAPIClient(session: mockSession)
    
    let dataExpectation = expectation(description: "Success!")
    
    let request = apiClient.fetchEvents(for: "ReactiveX/RxSwift")
    request.subscribe(onSuccess: { _ in
      dataExpectation.fulfill()
    }, onError: { _ in
      XCTFail()
    })
    .disposed(by: bag)
    
    wait(for: [dataExpectation], timeout: 1)
  }
  
}

extension GithubAPIClientTests {
  
  enum State { case success, failure }
  
  func loadJSONData() -> Data {
    let bundle = Bundle(for: type(of: self))
    let path = bundle.path(forResource: "Events", ofType: "json")!
    let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    return data
  }
  
  func createResponse(for state: State) -> HTTPURLResponse {
    let request = GithubAPI.events("ReactiveX/RxSwift").asURLRequest()
    let url = request.url!
    let response: HTTPURLResponse
    switch state {
    case .success:
      response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
    case .failure:
      response = HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)!
    }
    return response
  }
  
}
