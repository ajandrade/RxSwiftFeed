//
//  UITableView.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 30/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import UIKit

extension UITableView {
  
  func register<T: UITableViewCell>(_: T.Type) {
    let nib = UINib(nibName: T.identifier, bundle: nil)
    register(nib, forCellReuseIdentifier: T.identifier)
  }
  
}
