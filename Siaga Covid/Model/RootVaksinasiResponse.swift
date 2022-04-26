//
//  RootVaksinasi.swift
//  Siaga Covid
//
//  Created by yxgg on 21/03/22.
//

import Foundation

struct RootVaksinasiResponse: Decodable {
  let data: [DataVaksin]
  
  enum CodingKeys: String, CodingKey {
    case data
  }
}

struct DataVaksin: Decodable {
  let id: Int
  let nama: String
  let kota: String
  let provinsi: String
  let alamat: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case nama
    case kota
    case provinsi
    case alamat
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
    nama = try values.decodeIfPresent(String.self, forKey: .nama) ?? ""
    kota = try values.decodeIfPresent(String.self, forKey: .kota) ?? ""
    provinsi = try values.decodeIfPresent(String.self, forKey: .provinsi) ?? ""
    alamat = try values.decodeIfPresent(String.self, forKey: .alamat) ?? ""
  }
}
