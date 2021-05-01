//
//  DatePodExtension.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import Foundation

extension Date {
    
    public static func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(Localization.localTimezone.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}

        return localDate
    }
    
    public func nextDay() -> Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
    
    public var seconds: Int {
        return Calendar.current.component(.second, from: self)
    }
    
    public var minutes: Int {
        return Calendar.current.component(.minute, from: self)
    }
    
    public var hour: Int {
        return Calendar.current.component(.hour, from: self)
    }
    
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
    
    public func getFormattedHourAndMinutes() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: self)
    }
    
    public func getFormattedDate(format: String) -> String {
        let formatter = DateFormatter.dateFormat(fromTemplate: format, options: 0, locale: Localization.currentLocale)
        let dateformat = DateFormatter()
        dateformat.dateFormat = formatter
        return dateformat.string(from: self)
    }
    
    public static func getFormattedDate(dateString: String, format: String) -> Date? {
        let formatter = DateFormatter.dateFormat(fromTemplate: format, options: 0, locale: Localization.currentLocale)
        let dateformat = DateFormatter()
        dateformat.dateFormat = formatter
        return dateformat.date(from: dateString)
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
    
    public static func dayTimeSlots(interval: Int = 30) -> [String]? {
        var array: [String] = []
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "hh:mm a"
        let date = Date.localDate()
        guard let nextDay = date.nextDay(),
            let startDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date),
              let endDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: nextDay)
        else { return nil }

        let minInterval = interval // Minutes
        let string = startDate.getFormattedHourAndMinutes()
        array.append(string)
        
        var i = 1
        var dateTime = startDate.addingTimeInterval(TimeInterval(i * minInterval * 60))
        
        while dateTime <= endDate {
            let string = dateTime.getFormattedHourAndMinutes()
            array.append(string)
            
            i += 1
            dateTime = startDate.addingTimeInterval(TimeInterval(i * minInterval * 60))
        }
        return array
    }
}
