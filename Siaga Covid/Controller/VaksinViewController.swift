//
//  VaksinViewController.swift
//  Siaga Covid
//
//  Created by macbook on 17/03/22.
//

import UIKit

class VaksinViewController: UIViewController {
  @IBOutlet weak var nameAppLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var searchBar: UITextField!
  @IBOutlet weak var containerNasional: UIView!
  @IBOutlet weak var titleCovidLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  
  var listVaksinasi: [DataVaksin] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    searchBar.delegate = self
    setup()
  }
  
  private func searchVaksinasi() {
    searchBar.resignFirstResponder()
    guard let text = searchBar.text, !text.isEmpty else {
      return
    }
    let query = text
    listVaksinasi.removeAll()
    
    RootVaksinasiProvider.shared.loadVaksinasi(query: query) { response in
      switch response {
      case .success(let vaksin):
        self.listVaksinasi = vaksin
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      case .failure(_):
        let alert = UIAlertController(title: "Oops! Something went wrong", message: "Cannot find your city", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
    }
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
    
    titleLabel.text = """
            Belum Vaksin?
            Cari Tempat Vaksin Terdekat
            """
    titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    if #available(iOS 13.0, *) {
      titleLabel.textColor = .label
    } else {
      titleLabel.textColor = .black
    }
    searchBar.layer.cornerRadius = 18
    searchBar.layer.masksToBounds = true
    
    containerNasional.layer.cornerRadius = 18
    containerNasional.layer.masksToBounds = true
    
    titleCovidLabel.text = "Layanan Nasional COVID-19"
    titleCovidLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    if #available(iOS 13.0, *) {
      titleCovidLabel.textColor = .label
    } else {
      titleCovidLabel.textColor = .black
    }
    
    phoneLabel.text = "119"
    phoneLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    if #available(iOS 13.0, *) {
      phoneLabel.textColor = .label
    } else {
      phoneLabel.textColor = .black
    }
  }
}

// MARK: extension UITableViewDataSource
extension VaksinViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listVaksinasi.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "searchKotaCell", for: indexPath) as! SearchKotaTableViewCell
    
    cell.containerView.layer.cornerRadius = 10
    cell.containerView.layer.masksToBounds = true
    let vaksin = listVaksinasi[indexPath.row]
    cell.titleLabel.text = vaksin.nama
    cell.titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    cell.titleLabel.textColor = .black
    cell.cityLabel.text = [vaksin.kota, vaksin.provinsi].joined(separator: " • ")
    cell.cityLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    cell.cityLabel.textColor = UIColor(hex: "8e8e8e")
    cell.addressLabel.text = vaksin.alamat
    cell.addressLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    cell.addressLabel.textColor = .black
    
    cell.topConstraint.constant = indexPath.row == 0 ? 8 : 8
    cell.bottomConstraint.constant = indexPath.row == listVaksinasi.count - 1 ? 8 : 8
    
    return cell
  }
}

// MARK: extension UITextFieldDelegate
extension VaksinViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    searchVaksinasi()
    return true
  }
}
