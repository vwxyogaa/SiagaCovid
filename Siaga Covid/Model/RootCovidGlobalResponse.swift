//
//  RootCovidGlobalResponse.swift
//  Siaga Covid
//
//  Created by yxgg on 20/03/22.
//

import Foundation

struct RootCovidGlobalResponse: Decodable {
  let global: Global
  
  enum CodingKeys: String, CodingKey {
    case global = "Global"
  }
}

struct Global: Decodable {
  let newConfirmed: Int
  let totalConfirmed: Int
  let newDeaths: Int
  let totalDeaths: Int
  let date: Date
  
  enum CodingKeys: String, CodingKey {
    case newConfirmed = "NewConfirmed"
    case totalConfirmed = "TotalConfirmed"
    case newDeaths = "NewDeaths"
    case totalDeaths = "TotalDeaths"
    case date = "Date"
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    newConfirmed = try values.decodeIfPresent(Int.self, forKey: .newConfirmed) ?? 0
    totalConfirmed = try values.decodeIfPresent(Int.self, forKey: .totalConfirmed) ?? 0
    newDeaths = try values.decodeIfPresent(Int.self, forKey: .newDeaths) ?? 0
    totalDeaths = try values.decodeIfPresent(Int.self, forKey: .totalDeaths) ?? 0
    let dateString = try values.decodeIfPresent(String.self, forKey: .date) ?? ""
    date = dateString.date(format: .dateTimeISO8601Type2) ?? Date(timeIntervalSince1970: 0)
  }
}
