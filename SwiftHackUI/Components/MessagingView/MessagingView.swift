//
//  MessagingView.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit

public final class MessagingView: UIStackView {
    
    public enum Messagetype {
        case incoming(ProfileSetting)
        case outcoming(ProfileSetting)
        
        public enum ProfileSetting {
            case withProfileImage
            case noProfileImage
        }
    }
    
    public private (set) var messageType: Messagetype?
    private var bubbleView: BubbleView?
    private var hStack: UIStackView?
    private var imageView: CircleImageView?
    public var index: Int?
    
    public var text: String? {
        get {
            return bubbleView?.text
        } set {
            bubbleView?.text = newValue
        }
    }
    
    public convenience init(type: Messagetype, color: UIColor = Colors.lightGray1) {
        self.init(frame: .zero)
        setMessageType(type)
        setBubbleColor(color: color)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(font: UIFont = UIFont.regular(15)) {
        bubbleView = BubbleView()
        setFont(font: font)
        setMessageType(.outcoming(.withProfileImage))
        setBubbleColor(color: Colors.lightGray1)
    }
    
    public func setFont(font: UIFont = UIFont.regular(15), color: UIColor = Colors.gray6) {
        bubbleView?.setFont(font: font, color: color)
    }
    
    public func setBubbleColor(color: UIColor) {
        bubbleView?.setBubbleColor(color: color)
    }
    
    public func setMessageType(_ type: MessagingView.Messagetype) {
        self.messageType = type
        
        switch type {
        case .incoming:
            setupView(bubbleAlignment: .trailing)
        case .outcoming:
            setupView(bubbleAlignment: .leading)
        }
    }
    
    private func setBubbleAlignment(alignment: UIStackView.Alignment) {
        setupView(bubbleAlignment: alignment)
    }
    
    private func setupView(bubbleAlignment: UIStackView.Alignment) {
        self.hStack = UIStackView()
        hStack?.axis = .horizontal
        hStack?.alignment = .bottom
        hStack?.distribution = .fill
        hStack?.spacing = 10
        
        axis = .vertical
        alignment = bubbleAlignment
        distribution = .fill
        spacing = 0
        
        bubbleView?.setAlignment(alignment: alignment)
        bubbleView?.cornerRadius = 8
        addViews()
    }
    
    private func addViews() {
        self.removeAllSubViews()
        if bubbleView?.alignment == .trailing {
            addAndConstrainBubbleView()
            addAndConstrainCircleView()
        } else {
            addAndConstrainCircleView()
            addAndConstrainBubbleView()
        }
        if let hStack = self.hStack {
            addArrangedSubview(hStack)
        }
    }
    
    private func addAndConstrainBubbleView() {
        bubbleView?.translatesAutoresizingMaskIntoConstraints = false
        if let bubbleView = self.bubbleView,
           let hStack = self.hStack {
            hStack.addArrangedSubview(bubbleView)
        }
    }
    
    private func addAndConstrainCircleView() {
        guard let messageType = messageType else { return }
        
        switch messageType {
        case .incoming(let setting), .outcoming(let setting):
            if setting == .withProfileImage {
                setProfileImage()
            }
        }
    }
    
    public func hideImage() {
        imageView?.clear()
        imageView?.borderColor = .clear
    }
    
    private func setProfileImage(image: UIImage? = UIImage(named: "test_profile_img.jpg")) {
        imageView = CircleImageView()
        guard let hStack = self.hStack,
              let imageView = imageView,
              let image = image
        else { return }

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sizeToFit()
        imageView.image = image
        hStack.addArrangedSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 25),
            imageView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    public func addProfileImage(image: UIImage?, color: UIColor = Colors.gray7) {
        guard let type = messageType
        else { return }
        
        switch type {
        case .incoming:
            self.setMessageType(.incoming(.withProfileImage))
        case .outcoming:
            self.setMessageType(.outcoming(.withProfileImage))
        }
        imageView?.image = image
        imageView?.borderColor = color
    }
}
