//
//  RootNewsResponse.swift
//  Siaga Covid
//
//  Created by yxgg on 20/03/22.
//

import Foundation

struct RootNewsResponse: Decodable {
  let articles: [Articles]
  
  enum CodingKeys: String, CodingKey {
    case articles
  }
}

struct Articles: Decodable {
  let title: String
  let source: Source
  let urlToImage: String
  let url: String
  
  enum CodingKeys: String, CodingKey {
    case title
    case source
    case urlToImage
    case url
  }
}

struct Source: Decodable {
  let name: String
  
  enum CodingKeys: String, CodingKey {
    case name
  }
}
