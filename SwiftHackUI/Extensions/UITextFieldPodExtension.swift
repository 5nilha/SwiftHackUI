//
//  UITextFieldPodExtension.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit

extension UITextField {
    
    public func hideAssistantBar() {
        self.inputAssistantItem.leadingBarButtonGroups = [];
        self.inputAssistantItem.trailingBarButtonGroups = [];
    }
}

