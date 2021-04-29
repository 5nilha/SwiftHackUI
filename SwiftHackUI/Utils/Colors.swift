//
//  Colors.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit

struct Colors {
    
    static var primary = UIColor(hex: 0x2D71B6)
    static var primaryMenuLight = UIColor(hex: 0x0073c8)
    static var primaryshadow = UIColor(hex: 0x0073c8).withAlphaComponent(0.4)
    
    
    static var lightGray1 = UIColor(hex: 0xEBEBEB)
    
    static var gray1 = UIColor(hex: 0xf2f2f2)
    static var gray2 = UIColor(hex: 0xcccccc)
    static var gray3 = UIColor(hex: 0x999999)
    static var gray4 = UIColor(hex: 0x666666)
    static var gray5 = Colors.gray(0.2)
    static var gray6 = UIColor(hex: 0x333333)
    static var gray7 = UIColor(hex: 0xD8D8D8)
    static var gray8 = UIColor(hex: 0x767676)
    
    static var red = UIColor(hex: 0xd00000)
    static var green = UIColor(hex: 0x4d9a1d)
    static var green2 = UIColor(hex: 0x12801C)
    static var blue = UIColor(hex: 0x0466ca)
    static var orange = UIColor(hex: 0xf0b00b)
    static var blue1 = UIColor(hex: 0x0466CA)
    static var blue2 = UIColor(hex: 0x2D71B6)


    static var menuGray = UIColor(hex: 0xf2f2f2)
    static var menuBlue = UIColor(hex: 0x0073c8)

    static func gray(_ amount:CGFloat) -> UIColor {
        return UIColor(white: amount, alpha: 1)
    }
    
    static func black(_ alpha: CGFloat = 1) -> UIColor {
        return UIColor(white: 0.0, alpha: alpha)
    }
    
    static func white(_ alpha: CGFloat = 1) -> UIColor {
        return UIColor(white: 1.0, alpha: alpha)
    }
    
    static var tableCellSeparator: UIColor {
        return gray(0.85)
    }
    
    static func blackfontColor() -> UIColor {
        return UIColor(red:0.2, green:0.2, blue:0.2, alpha:1)
    }
    
    static func bluefontColor() -> UIColor {
        return UIColor(red:0.02, green:0.4, blue:0.79, alpha:1)
    }
    
}
