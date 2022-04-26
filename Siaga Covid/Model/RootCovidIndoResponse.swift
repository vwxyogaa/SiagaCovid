//
//  RootCovidIndoResponse.swift
//  Siaga Covid
//
//  Created by macbook on 18/03/22.
//

import Foundation

struct RootCovidIndoResponse: Decodable {
  let update: Update
  
  enum CodingKeys: String, CodingKey {
    case update
  }
}

struct Update: Decodable {
  let penambahan: Penambahan
  let total: Total
  
  enum CodingKeys: String, CodingKey {
    case penambahan
    case total
  }
}

struct Penambahan: Decodable {
  let jumlahPositif: Int
  let jumlahMeninggal: Int
  let jumlahSembuh: Int
  let tanggal: Date
  
  enum CodingKeys: String, CodingKey {
    case jumlahPositif = "jumlah_positif"
    case jumlahMeninggal = "jumlah_meninggal"
    case jumlahSembuh = "jumlah_sembuh"
    case tanggal
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    jumlahPositif = try values.decodeIfPresent(Int.self, forKey: .jumlahPositif) ?? 0
    jumlahMeninggal = try values.decodeIfPresent(Int.self, forKey: .jumlahMeninggal) ?? 0
    jumlahSembuh = try values.decodeIfPresent(Int.self, forKey: .jumlahSembuh) ?? 0
    let tanggalString = try values.decodeIfPresent(String.self, forKey: .tanggal) ?? ""
    tanggal = tanggalString.date(format: .date) ?? Date(timeIntervalSince1970: 0)
  }
}

struct Total: Decodable {
  let jumlahPositif: Int
  
  enum CodingKeys: String, CodingKey {
    case jumlahPositif = "jumlah_positif"
  }
}
