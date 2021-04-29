//
//  LabelPodExtension.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit

extension UILabel {
    
    func show(_ text: String) {
        self.isHidden = false
        self.text = text
    }

    func hide() {
        self.isHidden = true
        self.text = ""
    }
    
    func optimalHeight() -> CGFloat {
        let height = self.font.sizeOfString(self.text!, constrainedToWidth: self.width).height
        return height
    }
    
    func strikeThroughText(_ text:String) {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        self.attributedText = attributeString
    }
}
