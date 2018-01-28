//
//  MockURLSession.swift
//  RxSwiftFeedTests
//
//  Created by Amadeu Andrade on 28/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import RxSwift
@testable import RxSwiftFeed

class MockURLSession: URLSessionProtocol {
  
  var request: URLRequest?
  private let dataTask: MockURLSessionDataTask
  
  init(data: Data?, urlResponse: URLResponse?, error: Error?) {
    dataTask = MockURLSessionDataTask(data: data, urlResponse: urlResponse, error: error)
  }

  func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    self.request = request
    dataTask.completionHandler = completionHandler
    return dataTask
  }
  
}
