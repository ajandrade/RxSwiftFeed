//
//  GithubRouter.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 27/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import Foundation

enum GithubRouter {
  case repos(String)
}

extension GithubRouter {
  
  static var baseURLString: String {
    let scheme = Configuration.Network.githubSchema.value
    let path = Configuration.Network.githubBasePath.value
    return "\(scheme)://\(path)/"
  }
  
  var method: String {
    switch self {
    case .repos: return HTTPMethod.get.rawValue
    }
  }
  
  public func asURLRequest() -> URLRequest {
    let url: URL = {
      let relativePath: String?
      switch self {
      case .repos(let id): relativePath = id
      }
      // TODO: - Handle force unwrap
      var url = URL(string: GithubRouter.baseURLString)!
      if let path = relativePath {
        url = url.appendingPathComponent(path)
      }
      return url
    }()
    
    let parameters: [String: Any]? = {
      switch self {
      case .repos: return nil
      }
    }()
    
    var request = URLRequest(url: url)
    request.httpMethod = method
    if let parameters = parameters,
      let data = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
      request.httpBody = data
    }
    return request
  }
  
}
