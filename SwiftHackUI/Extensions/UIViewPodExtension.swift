//
//  UIViewPodExtension.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit

extension UIView {

    public convenience init(frame: CGRect, color: UIColor?) {
        self.init(frame: frame)
        self.backgroundColor = color
    }

    public convenience init(color: UIColor?) {
        self.init(frame: CGRect.zero)
        self.backgroundColor = color
    }

    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }

    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }

    public var posX: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame = CGRect(x: newValue, y: frame.origin.y, width: frame.size.width, height: frame.size.height)
        }
    }

    public var posY: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame = CGRect(x: frame.origin.x, y: newValue, width: frame.size.width, height: frame.size.height)
        }
    }

    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newValue, height: frame.size.height)
        }
    }

    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: newValue)
        }
    }

    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    public var borderColor: UIColor? {
        get {
            return UIColor(cgColor:(layer.borderColor!))
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    public func circle() {
        self.cornerRadius = self.height / 2
    }

    public func addSeparator(_ ypos: CGFloat, color: UIColor) -> CALayer {
        let separator = CALayer()
        separator.frame = CGRect(x: 0, y: ypos, width: self.width, height: 1)
        separator.backgroundColor = color.cgColor
        self.layer.addSublayer(separator)
        return separator
    }

    @objc func animateShow(_ duration: Double = 0.2, completion: (()->())? = nil) {
        if isHidden == true {
            isHidden = false
            alpha = 0
        }
        if alpha == 1 {
            completion?()
            return
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
            }, completion: { (done) in
                completion?()
        })
    }

    public func animateHide(_ duration: Double = 0.2, completion:(()->())? = nil) {
        if alpha == 0 || isHidden == true {
            completion?()
            return
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }, completion: { (done) in
            self.isHidden = true
            completion?()
        })
    }

    public func removeAllGestures() {
        if let gestureRecognizers = gestureRecognizers {
            for g in gestureRecognizers {
                removeGestureRecognizer(g)
            }
        }
    }

    public func fillWithView(_ subView: UIView, topPadding: CGFloat = 0.0, bottomPadding: CGFloat = 0.0, leadingPadding: CGFloat = 0.0, trailingPadding: CGFloat = 0.0) {

        // exit out if re-adding subview to superview
        guard !self.subviews.contains(subView) else { return }

        subView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subView)

        let topConstraint = NSLayoutConstraint(item: subView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0 + topPadding)
        let bottomConstraint = NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0 + bottomPadding)

        let leadingConstraint = NSLayoutConstraint(item: subView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0 + leadingPadding)
        let trailingConstraint = NSLayoutConstraint(item: subView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0 + trailingPadding)

        self.addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
    }


    /**
        This is a helper function that makes setting AutoLayout programmatically easy and concise
     - parameter top: Optional Top anchor
     - parameter left: Optional Left anchor
     - parameter bottom: Optional Bottom anchor
     - parameter right: Optional Right anchor
     - parameter paddingTop: Padding from Top anchor, make 0 if not needed
     - parameter paddingLeft: Padding from Left anchor, make 0 if not needed
     - parameter paddingBottom: Padding from Bottom anchor, make 0 if not needed
     - parameter paddingRight: Padding from Right anchor, make 0 if not needed
     - parameter width: Width, make it 0 if not needed
     - parameter height: Height, make it 0 if not needed
     */

    public func anchor(top: NSLayoutYAxisAnchor?,
                left: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                right: NSLayoutXAxisAnchor?,
                paddingTop: CGFloat,
                paddingLeft: CGFloat,
                paddingBottom: CGFloat,
                paddingRight: CGFloat,
                width: CGFloat,
                height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }


    /**
     This is a helper function that makes setting AutoLayout programmatically easy and concise. You can use anchor(width: 100) or anchor(heigth: 100) as well.
     - parameter width: Optional Width
     - parameter height: Optional Height
     */

    public func anchor(width: CGFloat = 0, height: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    public func enableAutoLayout(enabled: Bool = true) {
        translatesAutoresizingMaskIntoConstraints = !enabled
    }
    
    public func removeAllSubViews() {
        self.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    public func addToTopWindow() {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.addSubview(self)
    }
    
    public func removeFromTopWindow() {
        self.removeFromSuperview()
    }
}
