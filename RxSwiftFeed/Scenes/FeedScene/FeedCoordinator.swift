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
  
  fileprivate let navigator: NavigatorRepresentable
  
  // MARK: - INITIALIZER
  
  init(navigator: NavigatorRepresentable) {
    self.navigator = navigator
  }
}

extension FeedCoordinator: Coordinator {
  func start() {
    let feedViewController = FeedViewController()
    let feedViewModel = FeedViewModel()
    feedViewController.viewModel = feedViewModel
    navigator.transition(to: feedViewController, type: .root)
  }
}
