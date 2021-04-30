//
//  UIFontPodExtension.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit

extension UIFont {
    public func sizeOfString (_ string: String, constrainedToWidth width: CGFloat) -> CGSize {
        return (string as NSString).boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                                                         options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                         attributes: [NSAttributedString.Key.font: self],
                                                         context: nil).size
    }
    
    public func sizeOfString (_ string: String) -> CGSize {
        return (string as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                                                         options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                         attributes: [NSAttributedString.Key.font: self],
                                                         context: nil).size
    }
    
    public class func light(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .light)
    }
    
    public class func thin(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .thin)
    }
    
    public class func bold(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    public class func regular(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    public class func medium(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }

    public class func semiBold(_ size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .semibold)
    }

}
