//
//  CircleView.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/30/21.
//

import UIKit

public class CircleView: UIView {
    
    private var label = UILabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        setupView()
    }
    
    private func setupView() {
        roundView()
        addAndConstrainLabel()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        roundView()
    }
    
    public var text: String? {
        didSet {
            if let text = self.text {
                label.text = text
            }
        }
    }
    
    public var font: UIFont? {
        didSet {
            if let font = self.font {
                label.font = font
            }
        }
    }
    
    public var textColor: UIColor? {
        didSet {
            if let textColor = self.textColor {
                label.textColor = textColor
                borderColor = textColor
            }
        }
    }
    
    private func roundView() {
        if width != height {
            self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: height, height: height)
        }
        self.circle()
    }
    
    private func addAndConstrainLabel() {
        removeAllSubViews()
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.semiBold(18)
        textColor = Colors.primary
        label.textAlignment = .center
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    public func outlined() {
        borderWidth = 2
        textColor = textColor != .white ? textColor ?? Colors.primary : Colors.primary
        borderColor = textColor ?? Colors.primary
        backgroundColor = .white
    }
    
    public func filled(color: UIColor? = nil) {
        borderWidth = 0
        backgroundColor = color ?? Colors.primary
        textColor = backgroundColor ==  Colors.primary ? .white : textColor
    }
    
}
