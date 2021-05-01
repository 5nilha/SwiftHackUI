//
//  MarkLineView.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/30/21.
//

import UIKit

public class MarkLineView: UIStackView {
    private let markView = UIView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public convenience init() {
        self.init(frame: .zero)
        commonInit()
    }
    
    private func commonInit() {
        setupView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        alignment = .center
        distribution = .fill
        
        markView.backgroundColor = Colors.primary
        markView.translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(markView)
        
        let lineView = SeparatorView()
        lineView.backgroundColor = Colors.primary
        addArrangedSubview(lineView)
        
        NSLayoutConstraint.activate([
            markView.heightAnchor.constraint(equalToConstant: markViewHeight),
            markView.widthAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    public var markViewHeight: CGFloat = 10.0 {
        didSet {
            NSLayoutConstraint.activate([
                markView.heightAnchor.constraint(equalToConstant: markViewHeight)
            ])
        }
    }
}
