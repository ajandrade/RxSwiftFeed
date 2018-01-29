//
//  FeedCoordinator.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 27/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import Foundation

class FeedCoordinator {
  
  // MARK: - DEPENDENCIES
  
  private let navigator: NavigatorRepresentable
  private let dependencies: DependencyContainer
  
  // MARK: - INITIALIZER
  
  init(navigator: NavigatorRepresentable, dependencies: DependencyContainer) {
    self.navigator = navigator
    self.dependencies = dependencies
  }
}

extension FeedCoordinator: Coordinator {
  func start() {
    let feedViewController = FeedViewController()
    let feedViewModel = FeedViewModel(dependencies: dependencies)
    feedViewController.viewModel = feedViewModel
    navigator.transition(to: feedViewController, type: .root)
  }
}
