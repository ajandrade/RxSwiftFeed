//
//  FeedViewModel.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 27/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import Foundation

protocol FeedViewModelRepresentable { }

struct FeedViewModel: FeedViewModelRepresentable {

  typealias Dependencies = HasGithubProvider // & ..

  // MARK: - PROPERTIES
  
  private let dependencies: Dependencies
  
  // MARK: - INITIALIZER
  
  init(dependencies: Dependencies) {
    self.dependencies = dependencies
  }
  
}
