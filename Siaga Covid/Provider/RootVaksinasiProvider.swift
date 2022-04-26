//
//  RootVaksinasiProvider.swift
//  Siaga Covid
//
//  Created by yxgg on 21/03/22.
//

import Foundation
import Alamofire

let baseUrlVaksinasi = "https://kipi.covid19.go.id/api/get-faskes-vaksinasi"

class RootVaksinasiProvider {
  static let shared: RootVaksinasiProvider = RootVaksinasiProvider()
  private init() { }
  
  func loadVaksinasi(query: String, completion: @escaping (Result<[DataVaksin], Error>) -> Void) {
    AF.request(
      baseUrlVaksinasi,
      method: .get,
      parameters: [
        "city": query
      ]
    ).responseData { dataResponse in
      if let data = dataResponse.data {
        do {
          let response = try JSONDecoder().decode(RootVaksinasiResponse.self, from: data)
          completion(.success(response.data))
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
