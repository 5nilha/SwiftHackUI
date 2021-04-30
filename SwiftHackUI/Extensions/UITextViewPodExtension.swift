//
//  UITextViewPodExtension.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit

extension UITextView {
    public func scrollToBottom() {
        if self.text.count > 0 {
            let range = NSMakeRange(self.text.count-1, 1)
            self.scrollRangeToVisible(range)
        }
    }
}
