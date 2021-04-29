//
//  DatePodExtension.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import Foundation

extension Date {
    
    var nextMonth: Date? {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)
    }
    
    var previousMonth: Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
    
    func getFormattedDate(format: String) -> String {
        let formatter = DateFormatter.dateFormat(fromTemplate: format, options: 0, locale: Localization.currentLocale)
        let dateformat = DateFormatter()
        dateformat.dateFormat = formatter
        return dateformat.string(from: self)
    }
    
    var userFriendlyString: String {
        return self.getFormattedDate(format: "MMMM dd, YYY").capitalized
    }
}
