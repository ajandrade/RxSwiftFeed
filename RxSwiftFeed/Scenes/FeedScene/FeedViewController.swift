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
  
  // MARK: - IBOUTLETS
  
  @IBOutlet private weak var tableView: UITableView! {
    didSet { tableView.refreshControl = UIRefreshControl() }
  }
  
  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "RxSwiftFeed"
    setRefreshControl()
  }
  
  private func setRefreshControl() {
    let refreshControl = tableView.refreshControl
    refreshControl?.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
    refreshControl?.tintColor = UIColor.darkGray
    refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
    refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
  }
  
  @objc func refresh() {
    print("Refresh")
    tableView.refreshControl?.endRefreshing()
  }
  
}
