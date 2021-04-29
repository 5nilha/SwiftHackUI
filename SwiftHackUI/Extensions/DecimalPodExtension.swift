//
//  DecimalPodExtension.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import Foundation

extension Decimal {
    
    var intValue: Int {
        return Int(truncating: self as NSDecimalNumber)
    }
    
    var doubleValue: Double {
        return Double(truncating: self as NSDecimalNumber).roundToPlaces(2)
    }
    
    var stringValue: String {
        return NSDecimalNumber(decimal: self).stringValue
    }
}
