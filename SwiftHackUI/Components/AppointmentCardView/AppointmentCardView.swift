//
//  AppointmentCardView.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 5/1/21.
//

import UIKit

public final class AppointmentCardView: UIView {
    
    private var imageView: CircleImageView = CircleImageView(frame: CGRect(origin: .zero, size: CGSize(width: 20, height: 20)))
    private var mainStack: UIStackView = UIStackView()
    private var descriptionStack: UIStackView = UIStackView()
    private var titleLabel:  UILabel = UILabel()
    private var subtitleLabel: UILabel?
    
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
    }
    
    private func commonInit() {
        setupView()
    }
    
    public var color: UIColor = Colors.primaryshadow {
        didSet {
            setColorToComponents()
        }
    }
    
    public var imageColor: UIColor? {
        didSet {
            imageView.tintColor =  imageColor
        }
    }
    
    public var imageBackViewColor: UIColor = UIColor.white.withAlphaComponent(0.4) {
        didSet {
            imageView.backgroundColor =  imageBackViewColor
        }
    }
    
    public var titleColor: UIColor? {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    public var subtitleColor: UIColor? {
        didSet {
            subtitleLabel?.textColor = subtitleColor
        }
    }
    
    private func setupView() {
        backgroundColor = color.withAlphaComponent(0.3)
        cornerRadius = 8
        addAndConstrainMainStack()
        addAndConstrainImageView()
        addAndConstrainDescriptionStack()
    }
    
    private func setColorToComponents() {
        backgroundColor = color.withAlphaComponent(0.3)
        imageView.tintColor = imageColor ?? color
        imageView.backgroundColor =  imageBackViewColor
        titleLabel.textColor = titleColor ?? color
        subtitleLabel?.textColor = subtitleColor ?? color
    }
    
    private func addAndConstrainMainStack() {
        addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.axis = .horizontal
        mainStack.alignment = .center
        mainStack.distribution = .fill
        mainStack.spacing = 10
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    private func addAndConstrainImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "clock.fill", withConfiguration: boldConfig)
        imageView.image = image
        imageView.tintColor = color
        imageView.addCircleBackView(color:  color)
        mainStack.addArrangedSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    private func addAndConstrainDescriptionStack() {
        descriptionStack.axis = .vertical
        descriptionStack.alignment = .fill
        descriptionStack.distribution =  .fill
        descriptionStack.spacing = 10
        mainStack.addArrangedSubview(descriptionStack)
        addDescriptionLabels()
    }
    
    private func addDescriptionLabels() {
        descriptionStack.removeAllSubViews()
        addAndConstrainDescriptionTitle()
        addAndConstrainDescriptionSubtitle()
    }
    
    private func addAndConstrainDescriptionTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.semiBold(15)
        titleLabel.textAlignment = .left
        titleLabel.textColor = titleColor ?? color
        titleLabel.numberOfLines = 1
        descriptionStack.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func addAndConstrainDescriptionSubtitle() {
        guard let subtitleLabel = self.subtitleLabel else { return }
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.regular(13)
        subtitleLabel.textAlignment = .left
        subtitleLabel.textColor = subtitleColor ?? color
        subtitleLabel.numberOfLines = 0
        
        descriptionStack.addArrangedSubview(subtitleLabel)
    }
    
    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var subTitle: String? {
        didSet {
            subtitleLabel = UILabel()
            subtitleLabel?.text = subTitle
            addDescriptionLabels()
        }
    }
}
