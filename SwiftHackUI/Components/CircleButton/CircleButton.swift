//
//  CircleButton.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit

protocol CircleButtonDelegate: class {
    func buttonClicked(title: String?)
}

public final class CircleButton: UIButton {
    
    public weak var delegate: CircleButtonDelegate?
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        self.setTitleColor(Colors.primary, for: .normal)
        setBorder()
        self.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundView()
    }
    
    private func roundView() {
        if width != height {
            self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: height, height: height)
        }
        self.circle()
    }
    
    public func setBorder(width: CGFloat = 2, Color: UIColor = Colors.primary) {
        self.borderWidth = 2
        self.borderColor = Colors.primary
    }
    
    override var backgroundColor: UIColor? {
        get {
            return super.backgroundColor
        }
        set {
            if newValue == Colors.primary {
                self.setTitleColor(.white, for: .normal)
            } else if newValue == UIColor.white {
                self.setTitleColor(Colors.primary, for: .normal)
            }
            super.backgroundColor = newValue
        }
    }
    
    public var text: String? {
        get {
            return self.title(for: .normal)
        } set {
            self.setTitle(newValue, for: .normal)
        }
    }
    
    public var image: UIImage? {
        get {
            return self.image(for: .normal)
        } set {
            self.setImage(newValue, for: .normal)
        }
    }
    
    public func filled() {
        backgroundColor = Colors.primary
    }
    
    public func outlined() {
        backgroundColor = .white
    }
    
    @objc private func buttonClicked() {
        delegate?.buttonClicked(title: self.text)
    }
}
