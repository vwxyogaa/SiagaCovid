//
//  RootNewsProvider.swift
//  Siaga Covid
//
//  Created by yxgg on 20/03/22.
//

import Foundation
import Alamofire

let baseUrlNews = "https://newsapi.org/v2/everything"

private var apiKey: String {
  get {
    guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
      fatalError("Couldn't find file 'Info.plist'.")
    }
    let plist = NSDictionary(contentsOfFile: filePath)
    guard let value = plist?.object(forKey: "API_KEY") as? String else {
      fatalError("Couldn't find key 'API_KEY' in 'Info.plist'.")
    }
    return value
  }
}


class RootNewsProvider {
  static let shared: RootNewsProvider = RootNewsProvider()
  private init() { }
  
  func loadNews(completion: @escaping (Result<[Articles], Error>) -> Void) {
    AF.request(
      baseUrlNews,
      method: .get,
      parameters: [
        "q": "covid",
        "sortBy": "popularity",
        "apiKey": apiKey
      ]
    ).responseData { dataResponse in
      if let data = dataResponse.data {
        do {
          let response = try JSONDecoder().decode(RootNewsResponse.self, from: data)
          completion(.success(response.articles))
        } catch {
          completion(.failure(error))
        }
      } else {
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Oops! Something went wrong"])
        completion(.failure(error))
      }
    }
  }
}
