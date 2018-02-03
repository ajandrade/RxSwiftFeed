//
//  EventCell.swift
//  RxSwiftFeed
//
//  Created by Amadeu Andrade on 30/01/2018.
//  Copyright © 2018 Amadeu Andrade. All rights reserved.
//

import UIKit
import Kingfisher

class EventCell: UITableViewCell {
  
  // MARK: - IBOUTLETS
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var avatarImageView: UIImageView!
  
  // MARK: - UI INITIALIZATION
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.text = ""
    descriptionLabel.text = ""
    avatarImageView.kf.cancelDownloadTask()
    avatarImageView.image = nil
  }
  
  // MARK: - CONFIGURATION
  
  func configure(with viewModel: EventCellViewModelRepresentable) {
    titleLabel.text = viewModel.title
    descriptionLabel.text = viewModel.eventDescription
    let processor = RoundCornerImageProcessor(cornerRadius: 50)
    avatarImageView.kf.setImage(with: viewModel.avatarUrl, placeholder: nil, options: [.processor(processor)])
  }
  
}
