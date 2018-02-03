//
//  FeedViewController.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 27/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FeedViewController: UIViewController {
  
  // MARK: - DEPENDENCIES
  
  var viewModel: FeedViewModelRepresentable!
  
  // MARK: - PRIVATE PROPERTIES
  
  private let bag = DisposeBag()
  
  // MARK: - IBOUTLETS
  
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.register(EventCell.self)
      tableView.refreshControl = UIRefreshControl()
      tableView.rowHeight = 75
    }
  }
  
  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "RxSwiftFeed"
    setRefreshControl()
    
    bindDataSource()
  }
  
  func bindDataSource() {
    viewModel
      .eventViewModels
      .drive(tableView.rx.items(cellIdentifier: EventCell.identifier, cellType: EventCell.self)) { _, viewModel, cell in
        cell.configure(with: viewModel)
      }
      .disposed(by: bag)
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
