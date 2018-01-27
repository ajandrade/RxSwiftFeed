//
//  Navigator.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 27/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import UIKit

protocol NavigatorRepresentable {
  var navigationController: UINavigationController { get }
  func transition(to viewController: UIViewController, type: NavigationTransitionType)
  func dismiss()
}

class Navigator: NavigatorRepresentable {
  
  // MARK: - PROPERTIES
  
  let navigationController: UINavigationController
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.navigationController.navigationBar.prefersLargeTitles = true
  }
  
  // MARK: - FUNCTIONS
  
  func transition(to viewController: UIViewController, type: NavigationTransitionType) {
    switch type {
    case .root:
      navigationController.viewControllers = [viewController]
    case .modal:
      navigationController.present(viewController, animated: true, completion: nil)
    case .push:
      navigationController.pushViewController(viewController, animated: true)
    }
  }
  
  func dismiss() {
    if navigationController.presentingViewController != nil {
      navigationController.dismiss(animated: true, completion: nil)
    } else {
      navigationController.popViewController(animated: true)
    }
  }
  
}
