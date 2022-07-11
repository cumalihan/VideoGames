//
//  Date+Ext.swift
//  VideoGames
//
//  Created by Cumali Han Ünlü on 11.07.2022.
//

import Foundation

extension Date{
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
