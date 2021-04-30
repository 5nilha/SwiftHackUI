//
//  UITableViewPodExtension.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit

extension UITableView {
    
    public func startingFromBottom() {
        self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    public func disableSelection() {
        self.allowsSelection = false
    }
    
}
