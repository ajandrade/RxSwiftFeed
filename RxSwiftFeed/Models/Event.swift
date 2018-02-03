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
  
  // MARK: - FUNCTIONS
  
  static func decodeEvents(_ data: Data) -> [Event] {
    let events = try? JSONDecoder().decode([Event].self, from: data)
    return events ?? []
  }
  
}

extension Event: Encodable {
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(repository, forKey: .repo)
    try container.encode(actor, forKey: .actor)
    try container.encode(action, forKey: .type)
  }
  
}

extension Event: Equatable {
  
  static func == (lhs: Event, rhs: Event) -> Bool {
    return lhs.action == rhs.action && lhs.actor == rhs.actor && lhs.repository == rhs.repository
  }
  
}
