//
//  CalendarPodExtension.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/30/21.
//

import Foundation

extension Calendar {
    
    public static var months: [Month] {
        var calendar = Calendar.current
        calendar.locale = Localization.currentLocale
        return calendar.monthSymbols.enumerated().map { (index, month) -> Month in
            return Month(name: month.capitalized, numericMonth: index + 1)
        }
    }
    
    public struct Month {
        public private (set) var description: String = ""
        public let numericMonth: Int
        public let name: String
        
        public init(name: String, numericMonth: Int) {
            self.name = name
            self.numericMonth = numericMonth
            self.description = setDescriptiveMonth(name: name, numericMonth: numericMonth)
        }
        
        private func setDescriptiveMonth(name: String, numericMonth: Int) -> String {
            let numMonth = numericMonth < 10 ? "0\(numericMonth)" : "\(numericMonth)"
            return "\(numMonth)-\(name)"
        }
    }
    
}
