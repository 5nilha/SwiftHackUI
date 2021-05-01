//
//  CircleImageView.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit

public final class CircleImageView: UIView {
    
    private var imageView: UIImageView?
    private var imageBorderColor: UIColor = .clear
    private var imageBorderWidth: CGFloat = 2
    private var backViewType: BackViewType = .none
    
    private enum BackViewType {
        case circle
        case round(CGFloat)
        case none
    }
    
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
    
    private func commonInit() {
        self.imageView?.circle()
        addAndConstrainImageView()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.circle()
        
        switch backViewType {
        case .circle:
            circle()
        case .round(let value):
            self.cornerRadius = value
        default:
            self.cornerRadius = 0
        }
    }
    
    public var image: UIImage? {
        get {
            return imageView?.image
        } set {
            if imageView == nil {
                imageView = UIImageView()
            }
            imageView?.image = newValue
            imageView?.borderWidth = imageBorderWidth
            imageView?.borderColor = imageBorderColor
            addAndConstrainImageView()
        }
    }
    
    private func addAndConstrainImageView() {
        removeAllSubViews()
        guard let imageView = self.imageView else { return }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.isHidden = false
        let imageHeight = height - (height * 0.10)
        
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: imageHeight),
            imageView.heightAnchor.constraint(equalToConstant: imageHeight),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func addRoundBackView(color: UIColor) {
        backViewType = .round(6)
        backgroundColor = color
    }
    
    public func addCircleBackView(color: UIColor) {
        backViewType = .circle
        backgroundColor = color.withAlphaComponent(0.4)
    }
    
    private func removeBackView(color: UIColor) {
        backViewType = .round(6)
        backgroundColor = .clear
    }
    
    public func addBorder(width: CGFloat, color: UIColor) {
        imageBorderColor = color
        imageBorderWidth = width
        imageView?.borderWidth = imageBorderWidth
        imageView?.borderColor = imageBorderColor
    }
    
    public func removeImage() {
        self.imageView?.image = nil
        self.imageView = nil
        self.isHidden = true
    }
    
    public func clear() {
        removeImage()
    }
}

