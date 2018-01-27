//
//  MockNavigationController.swift
//  RxSwiftFeedTests
//
//  Created by Amadeu Andrade on 27/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import UIKit

class MockNavigationController: UINavigationController {
  
  var addedViewController: UIViewController?
  var setRoot = false
  var setPush = false
  var setPresent = false
  var dismissed = false
  var poped = false
  
  // Root
  override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
    addedViewController = viewControllers.first
    setRoot = true
    super.setViewControllers(viewControllers, animated: animated)
  }
  
  // Push
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    addedViewController = viewController
    setPush = true
    super.pushViewController(viewController, animated: animated)
  }
  
  // Present
  override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    addedViewController = viewControllerToPresent
    setPresent = true
    super.present(viewControllerToPresent, animated: flag, completion: completion)
  }
  
  // Dismiss
  override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
    dismissed = true
    super.dismiss(animated: flag, completion: completion)
  }
  
  // Pop
  override func popViewController(animated: Bool) -> UIViewController? {
    poped = true
    return super.popViewController(animated: animated)
  }
  
}
