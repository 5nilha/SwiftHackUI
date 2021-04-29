//
//  Colors.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit

public class Colors {
    
    public static var primary = UIColor(hex: 0x2D71B6)
    public static var primaryMenuLight = UIColor(hex: 0x0073c8)
    public static var primaryshadow = UIColor(hex: 0x0073c8).withAlphaComponent(0.4)
    
    
    public static var lightGray1 = UIColor(hex: 0xEBEBEB)
    
    public static var gray1 = UIColor(hex: 0xf2f2f2)
    public static var gray2 = UIColor(hex: 0xcccccc)
    public static var gray3 = UIColor(hex: 0x999999)
    public static var gray4 = UIColor(hex: 0x666666)
    public static var gray5 = Colors.gray(0.2)
    public static var gray6 = UIColor(hex: 0x333333)
    public static var gray7 = UIColor(hex: 0xD8D8D8)
    public static var gray8 = UIColor(hex: 0x767676)
    
    public static var red = UIColor(hex: 0xd00000)
    public static var green = UIColor(hex: 0x4d9a1d)
    public static var green2 = UIColor(hex: 0x12801C)
    public static var blue = UIColor(hex: 0x0466ca)
    public static var orange = UIColor(hex: 0xf0b00b)
    public static var blue1 = UIColor(hex: 0x0466CA)
    public static var blue2 = UIColor(hex: 0x2D71B6)


    public static var menuGray = UIColor(hex: 0xf2f2f2)
    public static var menuBlue = UIColor(hex: 0x0073c8)

    public static func gray(_ amount:CGFloat) -> UIColor {
        return UIColor(white: amount, alpha: 1)
    }
    
    public static func black(_ alpha: CGFloat = 1) -> UIColor {
        return UIColor(white: 0.0, alpha: alpha)
    }
    
    public static func white(_ alpha: CGFloat = 1) -> UIColor {
        return UIColor(white: 1.0, alpha: alpha)
    }
    
    public static var tableCellSeparator: UIColor {
        return gray(0.85)
    }
    
    public static func blackfontColor() -> UIColor {
        return UIColor(red:0.2, green:0.2, blue:0.2, alpha:1)
    }
    
    public static func bluefontColor() -> UIColor {
        return UIColor(red:0.02, green:0.4, blue:0.79, alpha:1)
    }
    
}
