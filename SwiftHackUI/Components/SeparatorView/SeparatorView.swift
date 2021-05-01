//
//  SeparatorView.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/30/21.
//

import UIKit

public class SeparatorView: UIView {
    
    let lineView = UIView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
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
        self.backgroundColor = Colors.menuGray
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}
