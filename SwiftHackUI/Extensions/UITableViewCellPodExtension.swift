//
//  UITableViewCellPodExtension.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit

extension UITableViewCell {
    func disableSelection() {
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.contentView.alpha = 0.2
        self.isUserInteractionEnabled = false
    }
}
