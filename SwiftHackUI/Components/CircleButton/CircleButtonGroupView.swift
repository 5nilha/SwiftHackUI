//
//  CircleButtonGroupView.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import Foundation

import UIKit

public struct CircleButtonItem {
    let title: String
}

public final class CircleButtonGroupView: UIView {
    
    private lazy var stackView = UIStackView()
    private lazy var container = UIView()
    private lazy var imageIcon = UIImageView()
    private lazy var hStack = UIStackView()
    
    public weak var delegate: CircleButtonDelegate? {
        didSet {
            if let delegate = delegate,
               let btnViews = circleButtons {
                for btn in btnViews {
                    btn.delegate = delegate
                }
            }
        }
    }
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commontInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commontInit()
    }
    
    private func commontInit() {
        backgroundColor = .clear
        setupView()
    }
    
    private func setupView() {
        addAndConstrainContainer()
        addImageConstraint()
        addAndConstrainStacks()
        mockButtons()
    }
    
    public var circleButtons: [CircleButton]? {
        return stackView.arrangedSubviews as? [CircleButton]
    }
    
    private func addAndConstrainContainer() {
        container.backgroundColor = .clear
        container.translatesAutoresizingMaskIntoConstraints = false
        addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
    }
    
    private func addAndConstrainStacks() {
        hStack.axis = .horizontal
        hStack.alignment = .center
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.alignment = .trailing
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 15
        
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.alignment = .trailing
        
        container.addSubview(hStack)
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            hStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            hStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -36),
            hStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
        ])
        
        hStack.addArrangedSubview(vStack)
        vStack.addArrangedSubview(stackView)
    }
    
    public var items: [CircleButtonItem]? {
        didSet {
            guard let items = self.items else { return }
            setupButtons(items: items)
        }
    }
    
    private func setupButtons(items: [CircleButtonItem]) {
        stackView.removeAllSubViews()
        
        for item in items {
            let circleButton = CircleButton(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 40)))
            circleButton.delegate = delegate
            circleButton.text = item.title
            circleButton.outlined()
            stackView.addArrangedSubview(circleButton)
        }
    }
    
    private func addImageConstraint() {
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageIcon.widthAnchor.constraint(equalToConstant: 30),
            imageIcon.heightAnchor.constraint(equalToConstant: 30),
        ])
        hStack.addArrangedSubview(imageIcon)
    }
    
    public func addIcon(image: UIImage?) {
        guard let image = image else { return }
        self.imageIcon.image = image
    }
    
    private func mockButtons() {
        let buttonItems = [CircleButtonItem(title: "B1"),
                           CircleButtonItem(title: "B2")]
        self.setupButtons(items: buttonItems)
    }
}
