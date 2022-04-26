//
//  StringExtension.swift
//  Siaga Covid
//
//  Created by yxgg on 20/03/22.
//

import Foundation

enum DateFormat: String {
  case date = "yyyy-MM-dd"
  case dateTime = "yyyy-MM-dd HH:mm:ss"
  case dateTimeISO8601 = "yyyy-MM-dd'T'HH:mm:ss'Z'"
  case dateTimeISO8601Type2 = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
}

extension String {
  func date(format: DateFormat) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format.rawValue
    return dateFormatter.date(from: self)
  }
}
