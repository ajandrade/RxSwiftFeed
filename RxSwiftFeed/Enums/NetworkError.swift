//
//  NetworkError.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 28/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import Foundation

enum NetworkError: Swift.Error {
  case general
  case withDescription(String)
  case withCode(Int)
  case noConnection
  
  var message: String {
    switch self {
    case .general:
      return "General server error."
    case .withDescription(let description):
      return description
    case .noConnection:
      return "No internet connection."
    case .withCode(let code):
      return "\(code)"
    }
  }
}
