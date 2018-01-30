//
//  NetworkError.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 28/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import Foundation

enum NetworkError: Swift.Error {
  case unknown
  case response
  case withCode(Int)
  case noConnection
  
  var message: String {
    switch self {
    case .unknown:
      return "General server error."
    case .response:
      return "Response is not NSHTTPURLResponse"
    case .noConnection:
      return "No internet connection."
    case .withCode(let code):
      return "\(code)"
    }
  }
}
