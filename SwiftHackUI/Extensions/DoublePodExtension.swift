//
//  DoublePodExtension.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import Foundation

extension Double {
    
    public func format(_ format: String) -> String {
        return String(format: format, self)
    }
    
    public func toDecimalPoint(_ amount: Int) -> String {
        return self.format("%.\(amount)f")
    }
    
    public var string: String {
        return String(self)
    }
    
    public func roundWithDecimal() -> Double {
        return amountString.double ?? 0.0
    }
    
    public var amountString: String {
        return String(format: "%.2f", self)
    }
    
    public var percentage: String {
        return String(format: "%.2f%%", self)
    }
    
    public func roundToPlaces(_ places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

    public var negative: Double {
        return self < 0 ? self : self * -1
    }
    
    public var anyObject: AnyObject {
        return self as AnyObject
    }
    
    public var decimalValue: Decimal? {
        return Decimal(string: amountString)
    }
    
    public var decimal: Decimal {
        return Decimal(self)
    }
}
