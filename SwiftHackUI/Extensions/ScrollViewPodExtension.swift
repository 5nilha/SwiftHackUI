//
//  ScrollViewPodExtension.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit

extension UIScrollView {
    public func scrollsToBottom(animated: Bool, bottomHeight: CGFloat = 0) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - (bounds.size.height - (bottomHeight)))
        setContentOffset(bottomOffset, animated: animated)
    }
    
    public func scrollsToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: 0)
        setContentOffset(topOffset, animated: animated)
    }
}
