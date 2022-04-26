//
//  HomeViewController.swift
//  Siaga Covid
//
//  Created by macbook on 17/03/22.
//

import UIKit

class HomeViewController: UIViewController {
  @IBOutlet weak var nameAppLabel: UILabel!
  @IBOutlet weak var titleIndoLabel: UILabel!
  @IBOutlet weak var subtitleIndoLabel: UILabel!
  @IBOutlet weak var containerTotalKasusView: UIView!
  @IBOutlet weak var amountTotalKasusLabel: UILabel!
  @IBOutlet weak var totalKasusLabel: UILabel!
  @IBOutlet weak var containerPositifView: UIView!
  @IBOutlet weak var amountPositifLabel: UILabel!
  @IBOutlet weak var positifLabel: UILabel!
  @IBOutlet weak var containerSembuhView: UIView!
  @IBOutlet weak var amountSembuhLabel: UILabel!
  @IBOutlet weak var sembuhLabel: UILabel!
  @IBOutlet weak var containerMeninggalView: UIView!
  @IBOutlet weak var amountMeninggalLabel: UILabel!
  @IBOutlet weak var meninggalLabel: UILabel!
  @IBOutlet weak var titleGlobalLabel: UILabel!
  @IBOutlet weak var subtitleGlobalLabel: UILabel!
  @IBOutlet weak var containerTotalGlobalView: UIView!
  @IBOutlet weak var amountTotalGlobalLabel: UILabel!
  @IBOutlet weak var totalGlobalLabel: UILabel!
  @IBOutlet weak var containerPositifGlobalView: UIView!
  @IBOutlet weak var amountPositifGlobalLabel: UILabel!
  @IBOutlet weak var positifGlobalLabel: UILabel!
  @IBOutlet weak var containerMeninggalGlobalView: UIView!
  @IBOutlet weak var amountMeninggalGlobalLabel: UILabel!
  @IBOutlet weak var meninggalGlobalLabel: UILabel!
  @IBOutlet weak var containerTotalMeninggalGlobalView: UIView!
  @IBOutlet weak var amountTotalMeninggalGlobalLabel: UILabel!
  @IBOutlet weak var totalMeninggalGlobalLabel: UILabel!
  @IBOutlet weak var preventionLabel: UILabel!
  @IBOutlet weak var socialDistancingImageView: UIImageView!
  @IBOutlet weak var socialDistancingLabel: UILabel!
  @IBOutlet weak var cleanHandImageView: UIImageView!
  @IBOutlet weak var cleanHandLabel: UILabel!
  @IBOutlet weak var wearMaskImageView: UIImageView!
  @IBOutlet weak var wearMaskLabel: UILabel!
  
  lazy var loadingView: UIActivityIndicatorView = {
    let loadingView = UIActivityIndicatorView()
    loadingView.hidesWhenStopped = true
    loadingView.style = .large
    return loadingView
  }()
  
  private var covidIndoContent: Update?
  private var covidGlobalContent: Global?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupLoadingView()
    loadCovidIndo()
    loadCovidGlobal()
  }
  
  private func loadCovidIndo() {
    RootCovidIndoProvider.shared.loadCovidIndo { response in
      self.loadingView.startAnimating()
      switch response {
      case .success(let data):
        self.covidIndoContent = data
        self.loadingView.stopAnimating()
        if let result = self.covidIndoContent {
          self.subtitleIndoLabel.text = "\(result.penambahan.tanggal.string(format: "MMMM dd, yyyy"))"
          self.amountTotalKasusLabel.text = "\(result.total.jumlahPositif)"
          self.amountPositifLabel.text = "\(result.penambahan.jumlahPositif)"
          self.amountSembuhLabel.text = "\(result.penambahan.jumlahSembuh)"
          self.amountMeninggalLabel.text = "\(result.penambahan.jumlahMeninggal)"
        }
      case .failure(_):
        let alert = UIAlertController(title: "Oops! Something went wrong", message: "Error load covid indo data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
    }
  }
  
  private func loadCovidGlobal() {
    RootCovidGlobalProvider.shared.loadCovidGlobal { response in
      self.loadingView.startAnimating()
      switch response {
      case .success(let data):
        self.covidGlobalContent = data
        self.loadingView.stopAnimating()
        if let result = self.covidGlobalContent {
          self.subtitleGlobalLabel.text = "\(result.date.string(format: "MMMM dd, yyyy"))"
          self.amountTotalGlobalLabel.text = "\(result.totalConfirmed)"
          self.amountPositifGlobalLabel.text = "\(result.newConfirmed)"
          self.amountMeninggalGlobalLabel.text = "\(result.newDeaths)"
          self.amountTotalMeninggalGlobalLabel.text = "\(result.totalDeaths)"
        }
      case .failure(_):
        let alert = UIAlertController(title: "Oops! Something went wrong", message: "Error load covid global data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
    }
  }
  
  private func setupViews() {
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
    
    titleIndoLabel.text = "Statistik COVID-19 di Indonesia"
    titleIndoLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    if #available(iOS 13.0, *) {
      titleIndoLabel.textColor = .label
    } else {
      titleIndoLabel.textColor = .black
    }
    
    subtitleIndoLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    if #available(iOS 13.0, *) {
      subtitleIndoLabel.textColor = .label
    } else {
      subtitleIndoLabel.textColor = .black
    }
    
    containerTotalKasusView.layer.cornerRadius = 15
    containerTotalKasusView.layer.masksToBounds = true
    amountTotalKasusLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    amountTotalKasusLabel.textColor = UIColor(hex: "FFC800")
    totalKasusLabel.text = "Total Kasus"
    totalKasusLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    if #available(iOS 13.0, *) {
      totalKasusLabel.textColor = .label
    } else {
      totalKasusLabel.textColor = .black
    }
    
    containerPositifView.layer.cornerRadius = 15
    containerPositifView.layer.masksToBounds = true
    amountPositifLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    amountPositifLabel.textColor = UIColor(hex: "FFC800")
    positifLabel.text = "Positif"
    positifLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    if #available(iOS 13.0, *) {
      positifLabel.textColor = .label
    } else {
      positifLabel.textColor = .black
    }
    
    containerSembuhView.layer.cornerRadius = 15
    containerSembuhView.layer.masksToBounds = true
    amountSembuhLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    amountSembuhLabel.textColor = UIColor(hex: "009600")
    sembuhLabel.text = "Sembuh"
    sembuhLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    if #available(iOS 13.0, *) {
      sembuhLabel.textColor = .label
    } else {
      sembuhLabel.textColor = .black
    }
    
    containerMeninggalView.layer.cornerRadius = 15
    containerMeninggalView.layer.masksToBounds = true
    amountMeninggalLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    amountMeninggalLabel.textColor = UIColor(hex: "960000")
    meninggalLabel.text = "Meninggal"
    meninggalLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    if #available(iOS 13.0, *) {
      meninggalLabel.textColor = .label
    } else {
      meninggalLabel.textColor = .black
    }
    
    preventionLabel.text = "Pencegahan"
    preventionLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    if #available(iOS 13.0, *) {
      preventionLabel.textColor = .label
    } else {
      preventionLabel.textColor = .black
    }
    
    socialDistancingImageView.image = UIImage(named: "dummyImage1")
    socialDistancingLabel.text = "Avoid close contact"
    socialDistancingLabel.textAlignment = .center
    socialDistancingLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    
    cleanHandImageView.image = UIImage(named: "dummyImage2")
    cleanHandLabel.text = "Clean your hands often"
    cleanHandLabel.textAlignment = .center
    cleanHandLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    
    wearMaskImageView.image = UIImage(named: "dummyImage3")
    wearMaskLabel.text = "Wear a facemask"
    wearMaskLabel.textAlignment = .center
    wearMaskLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    
    titleGlobalLabel.text = "Statistik COVID-19 di Dunia"
    titleGlobalLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    if #available(iOS 13.0, *) {
      titleGlobalLabel.textColor = .label
    } else {
      titleGlobalLabel.textColor = .black
    }
    
    subtitleGlobalLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    if #available(iOS 13.0, *) {
      subtitleGlobalLabel.textColor = .label
    } else {
      subtitleGlobalLabel.textColor = .black
    }
    
    containerTotalGlobalView.layer.cornerRadius = 15
    containerTotalGlobalView.layer.masksToBounds = true
    amountTotalGlobalLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    amountTotalGlobalLabel.textColor = UIColor(hex: "FFC800")
    totalGlobalLabel.text = "Total Kasus"
    totalGlobalLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    if #available(iOS 13.0, *) {
      totalGlobalLabel.textColor = .label
    } else {
      totalGlobalLabel.textColor = .black
    }
    
    containerPositifGlobalView.layer.cornerRadius = 15
    containerPositifGlobalView.layer.masksToBounds = true
    amountPositifGlobalLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    amountPositifGlobalLabel.textColor = UIColor(hex: "FFC800")
    positifGlobalLabel.text = "Positif"
    positifGlobalLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    if #available(iOS 13.0, *) {
      positifGlobalLabel.textColor = .label
    } else {
      positifGlobalLabel.textColor = .black
    }
    
    containerMeninggalGlobalView.layer.cornerRadius = 15
    containerMeninggalGlobalView.layer.masksToBounds = true
    amountMeninggalGlobalLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    amountMeninggalGlobalLabel.textColor = UIColor(hex: "960000")
    meninggalGlobalLabel.text = "Meninggal"
    meninggalGlobalLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    if #available(iOS 13.0, *) {
      meninggalGlobalLabel.textColor = .label
    } else {
      meninggalGlobalLabel.textColor = .black
    }
    
    containerTotalMeninggalGlobalView.layer.cornerRadius = 15
    containerTotalMeninggalGlobalView.layer.masksToBounds = true
    amountTotalMeninggalGlobalLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    amountTotalMeninggalGlobalLabel.textColor = UIColor(hex: "960000")
    totalMeninggalGlobalLabel.text = "Total Meninggal"
    totalMeninggalGlobalLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    if #available(iOS 13.0, *) {
      totalMeninggalGlobalLabel.textColor = .label
    } else {
      totalMeninggalGlobalLabel.textColor = .black
    }
  }
  
  private func setupLoadingView() {
    view.addSubview(loadingView)
    loadingView.translatesAutoresizingMaskIntoConstraints = false
    loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
}
