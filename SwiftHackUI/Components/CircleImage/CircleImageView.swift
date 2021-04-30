//
//  CircleImageView.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit

public final class CircleImageView: UIImageView {
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

    public override var image: UIImage? {
        get {
            return super.image
        } set {
            super.image = newValue
            if newValue != nil {
                borderWidth = 2
                borderColor = Colors.primaryshadow
            } else {
                borderColor = .clear
                borderWidth = 0
            }
        }
    }
    
    private func commonInit() {
        roundView()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        roundView()
    }
    
    private func roundView() {
        if width != height {
            self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: height, height: height)
        }
        self.circle()
    }
    
    public func removeImage() {
        self.image = nil
    }
    
    public func clear() {
        removeImage()
    }
}
