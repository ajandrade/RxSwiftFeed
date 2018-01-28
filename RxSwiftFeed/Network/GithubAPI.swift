//
//  GithubAPI.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 27/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import Foundation

protocol API {
  static var baseURLString: String { get }
  var method: String { get }
  var path: String { get }
  var parameters: [String: Any]? { get }
  func asURLRequest() -> URLRequest
}

enum GithubAPI {
  case events(String)
}

extension GithubAPI: API {
  
  static var baseURLString: String {
    let scheme = Configuration.Network.githubSchema.value
    let path = Configuration.Network.githubBasePath.value
    return "\(scheme)://\(path)/"
  }
  
  var method: String {
    switch self {
    case .events:
      return HTTPMethod.get.rawValue
    }
  }
  
  var path: String {
    switch self {
    case .events(let identifier):
      return "repos/\(identifier)/events"
    }
  }
  
  var parameters: [String: Any]? {
    switch self {
    default:
      return nil
    }
  }
  
  func asURLRequest() -> URLRequest {
    guard var url = URL(string: GithubAPI.baseURLString) else { fatalError("URL is not valid.") }
    url = url.appendingPathComponent(self.path)
    var request = URLRequest(url: url)
    request.httpMethod = method
    if let parameters = self.parameters,
      let data = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
      request.httpBody = data
    }
    return request
  }
  
}
