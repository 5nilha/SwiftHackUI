//
//  UITableViewCellPodExtension.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit

extension UITableViewCell {
    public func disableSelection() {
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.contentView.alpha = 0.2
        self.isUserInteractionEnabled = false
    }
    
    public func rotate180() {
        self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
}
