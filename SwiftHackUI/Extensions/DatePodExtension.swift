//
//  DatePodExtension.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import Foundation

extension Date {
    
    public var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    public var weekDay: String {
        var calendar = Calendar.current
        calendar.locale = Localization.currentLocale
        let weekIndex = calendar.component(.weekday, from: self)
        let shortWeekSymbols = calendar.shortWeekdaySymbols
        let index = (shortWeekSymbols.count > weekIndex - 1) ? weekIndex - 1 : weekIndex
        let weekName = shortWeekSymbols[index]
        return weekName
    }
    
    public var nextMonth: Date? {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)
    }
    
    public var previousMonth: Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
    
    public func getFormattedDate(format: String) -> String {
        let formatter = DateFormatter.dateFormat(fromTemplate: format, options: 0, locale: Localization.currentLocale)
        let dateformat = DateFormatter()
        dateformat.dateFormat = formatter
        return dateformat.string(from: self)
    }
    
    public var userFriendlyString: String {
        return self.getFormattedDate(format: "MMMM dd, YYY").capitalized
    }
    
    public func daysFromToday(days: Int) -> [Date] {
        var dates = [Date]()
        for day in 0...days {
            if let date = Calendar.current.date(byAdding: .day, value: day, to: self) {
                dates.append(date)
            }
        }
        return dates
    }
}
