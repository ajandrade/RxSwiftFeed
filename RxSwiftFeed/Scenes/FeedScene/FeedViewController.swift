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
    bindViewModel()
  }
  
  func bindDataSource() {
    viewModel.fetch()
    
    viewModel.eventViewModels
      .drive(tableView.rx.items(cellIdentifier: EventCell.identifier, cellType: EventCell.self)) { _, viewModel, cell in
        cell.configure(with: viewModel)
      }
      .disposed(by: bag)
  }
  
  func bindViewModel() {
    viewModel.didFinishGettingEvents
      .filter { $0 }
      .drive(onNext: { [weak self] _ in
        self?.tableView.refreshControl?.endRefreshing()
      })
      .disposed(by: bag)
    
    viewModel.didFinishWithError
      .filter { $0 != nil }
      .drive(onNext: { [weak self] error in
        self?.tableView.refreshControl?.endRefreshing()
        self?.showAlert(with: error!.localizedDescription)
      })
      .disposed(by: bag)
  }
  
  private func setRefreshControl() {
    let refreshControl = tableView.refreshControl
    refreshControl?.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
    refreshControl?.tintColor = UIColor.darkGray
    refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
    
    refreshControl?.rx
      .controlEvent(.valueChanged)
      .bind(to: viewModel.needsUpdate)
      .disposed(by: bag)
  }
  
}
