//
//  DateExtension.swift
//  Siaga Covid
//
//  Created by yxgg on 20/03/22.
//

import Foundation

extension Date {
  func string(format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }
}
