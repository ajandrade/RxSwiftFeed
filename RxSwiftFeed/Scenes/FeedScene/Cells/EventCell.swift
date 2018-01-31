//
//  EventCell.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 30/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
  
  // MARK: - IBOUTLETS
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  // MARK: - UI INITIALIZATION
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: - CONFIGURATION
  
  func configure(with viewModel: EventCellViewModelRepresentable) {
    titleLabel.text = viewModel.title
    descriptionLabel.text = viewModel.eventDescription
  }
  
}
