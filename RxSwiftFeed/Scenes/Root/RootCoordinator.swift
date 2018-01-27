//
//  RootCoordinator.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 27/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import UIKit

class RootCoordinator {
  
  // MARK: - DEPENDENCIES
  
  private let window: UIWindow
  private let navigator: NavigatorRepresentable
  
  // MARK: - INITIALIZER
  
  init(window: UIWindow, navigator: NavigatorRepresentable) {
    self.window = window
    self.navigator = navigator
    self.window.rootViewController = navigator.navigationController
    self.window.makeKeyAndVisible()
  }
  
}

extension RootCoordinator: Coordinator {
  
  func start() {
    let feedCoordinator = FeedCoordinator(navigator: navigator)
    feedCoordinator.start()
  }
  
}
