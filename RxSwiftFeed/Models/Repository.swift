//
//  Repository.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 29/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import Foundation

struct Repository: Codable {
  let name: String
}

extension Repository: Equatable {
  
  static func == (lhs: Repository, rhs: Repository) -> Bool {
    return lhs.name == rhs.name
  }
  
}
