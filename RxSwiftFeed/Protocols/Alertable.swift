//
//  Alertable.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 03/02/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import UIKit

protocol Alertable { }

extension Alertable where Self: UIViewController {
  
  func showAlert(with message: String) {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
    alert.addAction(closeAction)
    self.present(alert, animated: true, completion: nil)
  }
  
}
