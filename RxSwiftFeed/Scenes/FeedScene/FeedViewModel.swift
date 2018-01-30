//
//  FeedViewModel.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 27/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol FeedViewModelRepresentable {
  var eventViewModels: Driver<[EventCellViewModel]> { get }
}

struct FeedViewModel: FeedViewModelRepresentable {
  
  // MARK: - DEPENDENCIES
  
  typealias Dependencies = HasGithubProvider // & ..
  private let dependencies: Dependencies
  
  // MARK: - INTERNAL PROPERTIES
  
  private let bag = DisposeBag()
  private var allEvents = Variable<[Event]>([])
  private var allEventViewModels = Variable<[EventCellViewModel]>([])

  // MARK: - OUTPUT PROPERTIES
  
  var eventViewModels: Driver<[EventCellViewModel]> {
    return allEventViewModels.asDriver()
  }
  
  // MARK: - INITIALIZER
  
  init(dependencies: Dependencies) {
    self.dependencies = dependencies
    fetch()
  }
  
  // MARK: - FUNCTIONS

  func fetch() {
    fetchEvents()
      .map(processEvents)
      .subscribe(onSuccess: { events in
        self.allEvents.value = events
        self.allEventViewModels.value = events.flatMap(EventCellViewModel.init)
      }, onError: { error in
          print(error)
      })
    .disposed(by: bag)
  }
  
  private func fetchEvents() -> Single<Data> {
    return dependencies.githubProvider.fetchEvents(for: "ReactiveX/RxSwift")
  }
  
  private func processEvents(_ data: Data) -> [Event] {
    let events = try? JSONDecoder().decode([Event].self, from: data)
    return events ?? []
  }
  
}
