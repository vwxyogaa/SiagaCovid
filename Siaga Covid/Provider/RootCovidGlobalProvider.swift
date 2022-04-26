//
//  RootCovidGlobalProvider.swift
//  Siaga Covid
//
//  Created by yxgg on 20/03/22.
//

import Foundation
import Alamofire

let baseUrlCovidGlobal = "https://api.covid19api.com/summary"

class RootCovidGlobalProvider {
  static let shared: RootCovidGlobalProvider = RootCovidGlobalProvider()
  private init() { }
  
  func loadCovidGlobal(completion: @escaping (Result<Global, Error>) -> Void) {
    AF.request(
      baseUrlCovidGlobal
    ).responseData { dataResponse in
      if let data = dataResponse.data {
        do {
          let response = try JSONDecoder().decode(RootCovidGlobalResponse.self, from: data)
          completion(.success(response.global))
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
