//
//  Configuration.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 27/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import Foundation

enum Configuration {
  
  enum Network {
    case githubSchema
    case githubBasePath
    
    // TODO: - Find a better way to remove duplicated code
    var value: String {
      switch self {
      case .githubSchema:
        guard let schema = Bundle.main.object(forInfoDictionaryKey: "GITHUB_API_SCHEME") as? String else {
          fatalError("Configuration file: 'GITHUB_API_SCHEME')")
        }
        return schema
      case .githubBasePath:
        guard let path = Bundle.main.object(forInfoDictionaryKey: "GITHUB_BASE_PATH") as? String else {
          fatalError("Configuration file: 'GITHUB_BASE_PATH')")
        }
        return path
      }
    }
  }
}
