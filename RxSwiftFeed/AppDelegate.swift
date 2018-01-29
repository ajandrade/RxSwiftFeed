//
//  AppDelegate.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 27/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    setRootWindow()
    return true
  }
  
  private func setRootWindow() {
    window = UIWindow(frame: UIScreen.main.bounds)
    let navigationController = UINavigationController()
    navigationController.navigationBar.prefersLargeTitles = true
    let navigator = Navigator(navigationController: navigationController)
    let dependencies = buildDependencies()
    let rootCoordinator = RootCoordinator(window: window!, navigator: navigator, dependencies: dependencies)
    rootCoordinator.start()
  }
  
  private func buildDependencies() -> DependencyContainer {
    let githubProvider = GithubAPIClient()
    let dependencies = DependencyContainer(githubProvider: githubProvider)
    return dependencies
  }

}
