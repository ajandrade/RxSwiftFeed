//
//  Actor.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 29/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import Foundation

struct Actor {
  let name: String
  let avatarUrlString: String
}

extension Actor: Decodable {
  
  // MARK: - KEYS
  
  enum CodingKeys: String, CodingKey {
    case name = "display_login"
    case avatarUrlString = "avatar_url"
  }
  
  // MARK: - INITIALIZER
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    name = try values.decode(String.self, forKey: .name)
    avatarUrlString = try values.decode(String.self, forKey: .avatarUrlString)
  }
  
}

extension Actor: Encodable {
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    try container.encode(avatarUrlString, forKey: .avatarUrlString)
  }
  
}

extension Actor: Equatable {
  
  static func == (lhs: Actor, rhs: Actor) -> Bool {
    return lhs.name == rhs.name && lhs.avatarUrlString == rhs.avatarUrlString
  }
  
}
