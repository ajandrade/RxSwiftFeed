//
//  EventCellViewModel.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 30/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import Foundation

protocol EventCellViewModelRepresentable {
  var title: String { get }
  var eventDescription: String { get }
}

struct EventCellViewModel: EventCellViewModelRepresentable {
  
  // MARK: - PROPERTIES
  
  let title: String
  let eventDescription: String
  
  // MARK: - INITIALIZER
  
  init(_ event: Event) {
    title = event.actor.name
    eventDescription = event.repository.name + ", " + event.action.replacingOccurrences(of: "Event", with: "").lowercased()
  }
  
}
