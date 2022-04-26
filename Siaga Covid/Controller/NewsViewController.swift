//
//  NewsViewController.swift
//  Siaga Covid
//
//  Created by macbook on 17/03/22.
//

import UIKit
import Kingfisher
import SafariServices

class NewsViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var nameAppLabel: UILabel!
  
  lazy var loadingView: UIActivityIndicatorView = {
    let loadingView = UIActivityIndicatorView()
    loadingView.hidesWhenStopped = true
    loadingView.style = .large
    return loadingView
  }()
  
  var newsContent: [Articles] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    setup()
    setupLoadingView()
    loadNews()
  }
  
  private func loadNews() {
    self.loadingView.startAnimating()
    RootNewsProvider.shared.loadNews { response in
      switch response {
      case .success(let news):
        self.newsContent = news
        self.loadingView.stopAnimating()
        self.tableView.reloadData()
      case .failure(_):
        let alert = UIAlertController(title: "Oops! Something went wrong", message: "Error load news data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
    }
  }
  
  private func setupLoadingView() {
    view.addSubview(loadingView)
    loadingView.translatesAutoresizingMaskIntoConstraints = false
    loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  private func setup() {
    let attText = NSMutableAttributedString(string: "Siaga", attributes: [
      .font : UIFont.systemFont(ofSize: 24, weight: .bold),
      .foregroundColor : UIColor.systemBlue
    ])
    if #available(iOS 13.0, *) {
      attText.append(NSAttributedString(string: "Covid", attributes: [
        .font : UIFont.systemFont(ofSize: 24, weight: .bold),
        .foregroundColor : UIColor.label
      ]))
    } else {
      attText.append(NSAttributedString(string: "Covid", attributes: [
        .font : UIFont.systemFont(ofSize: 24, weight: .bold),
        .foregroundColor : UIColor.black
      ]))
    }
    nameAppLabel.attributedText = attText
  }
}

extension NewsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return newsContent.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
    
    cell.containerView.layer.cornerRadius = 12
    cell.containerView.layer.masksToBounds = true
    let news = newsContent[indexPath.row]
    cell.titleLabel.text = news.title
    cell.titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    cell.sourceNameLabel.text = news.source.name
    cell.sourceNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    cell.sourceNameLabel.textColor = UIColor(hex: "8e8e8e")
    cell.thumbImageView.contentMode = .scaleAspectFill
    cell.thumbImageView.layer.cornerRadius = 12
    cell.thumbImageView.layer.masksToBounds = true
    let imageUrl = news.urlToImage
    cell.loadingView.startAnimating()
    cell.thumbImageView.kf.setImage(with: URL(string: imageUrl)) { _ in
      cell.loadingView.stopAnimating()
    }
    
    cell.topConstraint.constant = indexPath.row == 0 ? 0 : 8
    cell.bottomConstraint.constant = indexPath.row == newsContent.count - 1 ? 8 : 8
    
    return cell
  }
}

extension NewsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let news = newsContent[indexPath.row]
    if let url = URL(string: news.url) {
      let viewController = SFSafariViewController(url: url)
      present(viewController, animated: true, completion: nil)
    }
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
    let label = UILabel()
    label.frame = CGRect.init(x: 20, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
    label.text = "Berita Seputar COVID-19"
    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    if #available(iOS 13.0, *) {
      label.textColor = .label
    } else {
      label.textColor = .black
    }
    
    headerView.addSubview(label)
    return headerView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return nil
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return CGFloat.leastNormalMagnitude
  }
}
