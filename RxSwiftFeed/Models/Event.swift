//
//  Event.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 29/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import Foundation

struct Event {
  let repository: Repository
  let actor: Actor
  let action: String
}

extension Event: Decodable {
  
  // MARK: - KEYS
  
  enum CodingKeys: String, CodingKey { case actor, repo, type }

  // MARK: - INITIALIZER
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    actor = try values.decode(Actor.self, forKey: .actor)
    repository = try values.decode(Repository.self, forKey: .repo)
    action = try values.decode(String.self, forKey: .type)
  }
  
}

// EXAMPLE:
//{
//  "id": "7161380153",
//  "type": "WatchEvent",
//  "actor": {
//    "id": 18651547,
//    "login": "lanlingdiao",
//    "display_login": "lanlingdiao",
//    "gravatar_id": "",
//    "url": "https://api.github.com/users/lanlingdiao",
//    "avatar_url": "https://avatars.githubusercontent.com/u/18651547?"
//  },
//  "repo": {
//    "id": 33569135,
//    "name": "ReactiveX/RxSwift",
//    "url": "https://api.github.com/repos/ReactiveX/RxSwift"
//  },
//  "payload": {
//    "action": "started"
//  },
//  "public": true,
//  "created_at": "2018-01-28T13:26:31Z",
//  "org": {
//    "id": 6407041,
//    "login": "ReactiveX",
//    "gravatar_id": "",
//    "url": "https://api.github.com/orgs/ReactiveX",
//    "avatar_url": "https://avatars.githubusercontent.com/u/6407041?"
//  }
//}

