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
  
  // Root
  override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
    addedViewController = viewControllers.first
    super.setViewControllers(viewControllers, animated: animated)
  }
  
  // Push
  override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    addedViewController = viewController
    super.pushViewController(viewController, animated: animated)
  }
  
  // Present
  override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    addedViewController = viewControllerToPresent
    super.present(viewControllerToPresent, animated: flag, completion: completion)
  }
  
}
