//
//  FeedViewController.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 27/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
  
  // MARK: - DEPENDENCIES
  
  var viewModel: FeedViewModelRepresentable!
  
  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "RxSwiftFeed"
  }
  
}
