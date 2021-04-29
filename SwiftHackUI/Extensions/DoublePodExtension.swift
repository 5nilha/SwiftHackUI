//
//  DoublePodExtension.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import Foundation

extension Double {
    
    func format(_ format: String) -> String {
        return String(format: format, self)
    }
    
    func toDecimalPoint(_ amount: Int) -> String {
        return self.format("%.\(amount)f")
    }
    
    var string: String {
        return String(self)
    }
    
    func roundWithDecimal() -> Double {
        return amountString.double ?? 0.0
    }
    
    var amountString: String {
        return String(format: "%.2f", self)
    }
    
    var percentage: String {
        return String(format: "%.2f%%", self)
    }
    
    func roundToPlaces(_ places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

    var negative: Double {
        return self < 0 ? self : self * -1
    }
    
    var anyObject: AnyObject {
        return self as AnyObject
    }
    
    var decimalValue: Decimal? {
        return Decimal(string: amountString)
    }
    
    var decimal: Decimal {
        return Decimal(self)
    }
}
