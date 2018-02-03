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
  // Input
  var needsUpdate: PublishSubject<Void> { get }
  // Output
  var eventViewModels: Driver<[EventCellViewModel]> { get }
  var didFinishGettingEvents: Driver<Bool> { get }
  var didFinishWithError: Driver<Error?> { get }
  
  func fetch()
}

struct FeedViewModel: FeedViewModelRepresentable {
  
  // MARK: - DEPENDENCIES
  
  typealias Dependencies = HasGithubProvider // & ..
  private let dependencies: Dependencies
  
  // MARK: - INTERNAL PROPERTIES
  
  private let bag = DisposeBag()
  
  private var allEventViewModels = BehaviorRelay(value: [EventCellViewModel]())
  private var errorContainer = BehaviorRelay<Error?>(value: nil)
  private var activityTrackerContainer = BehaviorRelay(value: false)
  
  // MARK: - INPUT PROPERTIES
  
  let needsUpdate = PublishSubject<Void>()

  // MARK: - OUTPUT PROPERTIES
  
  var eventViewModels: Driver<[EventCellViewModel]> {
    return allEventViewModels.asDriver()
  }
  
  var didFinishGettingEvents: Driver<Bool> {
    return activityTrackerContainer.asDriver()
  }
  
  var didFinishWithError: Driver<Error?> {
    return errorContainer.asDriver()
  }
  
  // MARK: - INITIALIZER
  
  init(dependencies: Dependencies) {
    self.dependencies = dependencies
    setNeedsUpdate()
  }
  
  // MARK: - FUNCTIONS

  func fetch() {
    fetchEvents()
      .map(Event.decodeEvents)
      .map { $0.flatMap(EventCellViewModel.init) }
      .debug()
      .subscribe(onSuccess: { cellViewModels in
        self.allEventViewModels.accept(cellViewModels)
        self.activityTrackerContainer.accept(true)
      }, onError: { error in
        self.errorContainer.accept(error)
      })
      .disposed(by: bag)
  }
  
  // MARK: - PRIVATE FUNCTIONS
  
  private func fetchEvents() -> Single<Data> {
    return dependencies.githubProvider.fetchEvents(for: "ReactiveX/RxSwift")
  }
  
  private func setNeedsUpdate() {
    needsUpdate
      .subscribe(onNext: { _ in self.fetch() })
      .disposed(by: bag)
  }
  
}
