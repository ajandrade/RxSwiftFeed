//
//  Actor.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 29/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import Foundation

struct Actor {
  let login: String
  let avatarUrlString: String
}

extension Actor: Decodable {
  
  // MARK: - KEYS
  
  enum CodingKeys: String, CodingKey {
    case login = "display_login"
    case avatarUrlString = "avatar_url"
  }
  
  // MARK: - INITIALIZER
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    login = try values.decode(String.self, forKey: .login)
    avatarUrlString = try values.decode(String.self, forKey: .avatarUrlString)
  }
  
}

extension Actor: Equatable {
  
  static func == (lhs: Actor, rhs: Actor) -> Bool {
    return lhs.login == rhs.login && lhs.avatarUrlString == rhs.avatarUrlString
  }
  
}

// EXAMPLE:
//"actor": {
//  "id": 18651547,
//  "login": "lanlingdiao",
//  "display_login": "lanlingdiao",
//  "gravatar_id": "",
//  "url": "https://api.github.com/users/lanlingdiao",
//  "avatar_url": "https://avatars.githubusercontent.com/u/18651547?"
//}
