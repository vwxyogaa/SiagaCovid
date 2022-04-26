//
//  RootCovidIndoProvider.swift
//  Siaga Covid
//
//  Created by macbook on 18/03/22.
//

import Foundation
import Alamofire

let baseUrlCovidIndo = "https://data.covid19.go.id/public/api/update.json"

class RootCovidIndoProvider {
  static let shared: RootCovidIndoProvider = RootCovidIndoProvider()
  private init() { }
  
  func loadCovidIndo(completion: @escaping (Result<Update, Error>) -> Void) {
    AF.request(
      baseUrlCovidIndo
    ).responseData { dataResponse in
      if let data = dataResponse.data {
        do {
          let response = try JSONDecoder().decode(RootCovidIndoResponse.self, from: data)
          completion(.success(response.update))
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
