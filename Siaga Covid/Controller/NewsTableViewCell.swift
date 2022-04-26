//
//  NewsTableViewCell.swift
//  Siaga Covid
//
//  Created by yxgg on 20/03/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var sourceNameLabel: UILabel!
  @IBOutlet weak var thumbImageView: UIImageView!
  @IBOutlet weak var topConstraint: NSLayoutConstraint!
  @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var loadingView: UIActivityIndicatorView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
