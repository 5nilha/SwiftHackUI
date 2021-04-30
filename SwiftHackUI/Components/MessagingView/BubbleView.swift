//
//  BubbleView.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit

public final class BubbleView: UIStackView {
    
    private var bubbleView: UIView?
    private var label: UILabel?
    
    public var text: String? {
        get {
            return label?.text
        } set {
            label?.text = newValue
        }
    }
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(alignment: UIStackView.Alignment = .leading, font: UIFont = UIFont.regular(15)) {
        bubbleView = UIView()
        label = UILabel()
        setFont(font: font)
        setAlignment(alignment: alignment)
        setupView()
        setBubbleColor(color: Colors.lightGray1)
    }
    
    public func setFont(font: UIFont, color: UIColor = Colors.gray6) {
        label?.text = "Text"
        label?.font = font
        label?.textColor = color
    }
    
    public func setBubbleColor(color: UIColor) {
        bubbleView?.backgroundColor = color
    }
    
    public func setAlignment(alignment: UIStackView.Alignment) {
        self.alignment = alignment
    }
    
    private func setupView() {
        axis = .vertical
        distribution = .fill
        addAndConstrainBubbleView()
        addAndConstrainLabel()
        bubbleView?.cornerRadius = 8
    }
    
    private func addAndConstrainBubbleView() {
        bubbleView?.translatesAutoresizingMaskIntoConstraints = false
        if let bubbleView = self.bubbleView {
            addArrangedSubview(bubbleView)
        }
    }
    
    private func addAndConstrainLabel() {
        label?.translatesAutoresizingMaskIntoConstraints = false
        label?.numberOfLines = 0
        
        if let bubbleView = self.bubbleView,
           let label = label {
            bubbleView.addSubview(label)
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 8),
                label.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 10),
                label.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -10),
                label.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -8)
            ])
        }
    }
}

