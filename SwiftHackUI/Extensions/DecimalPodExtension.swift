//
//  DecimalPodExtension.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import Foundation

extension Decimal {
    
    public var intValue: Int {
        return Int(truncating: self as NSDecimalNumber)
    }
    
    public var doubleValue: Double {
        return Double(truncating: self as NSDecimalNumber).roundToPlaces(2)
    }
    
    public var stringValue: String {
        return NSDecimalNumber(decimal: self).stringValue
    }
}
