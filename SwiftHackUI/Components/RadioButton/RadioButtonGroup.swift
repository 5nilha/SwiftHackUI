//
//  RadioButtonGroup.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit

public protocol RadioButtonDelegate: class {
    func didSelect(index: Int?)
}

// SellCheckboxDetails
public struct RadioButtonDetails {
    public var id: String?
    public private (set) var line1: String?
    public private (set) var line2: String?
    
    public init(id: String? = nil, line1: String?, line2: String? = nil){
        self.id = id
        self.line1 = line1
        self.line2 = line2
    }
}

private final class RadioButton: UIView {
    
    private (set) var isSelected: Bool = false
    
    private var outterCircle: UIView {
        let circleView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 18, height: 18)), color: .clear)
        circleView.borderWidth = 1
        circleView.backgroundColor = Colors.menuGray.withAlphaComponent(2)
        circleView.borderColor = Colors.gray6
        circleView.circle()
        return circleView
    }
    
    private var innerCircle: UIView {
        let circleView = UIView(frame: CGRect(origin: CGPoint(x: (outterCircle.width / 2) - (10 / 2), y:  (outterCircle.height / 2) - (10 / 2)), size: CGSize(width: 10, height: 10)), color: Colors.primary)
        circleView.circle()
        return circleView
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
        setUnselectedView()
    }
    
    private func setSelectedView() {
        self.removeAllSubViews()
        outterCircle.borderColor = Colors.primary
        self.addSubview(outterCircle)
        self.addSubview(innerCircle)
    }
    
    private func setUnselectedView() {
        self.removeAllSubViews()
        outterCircle.borderColor = Colors.primary
        self.addSubview(outterCircle)
    }
    
    func toggleItem() {
        self.isSelected = !isSelected
        isSelected ? setSelectedView() : setUnselectedView()
    }
    
    func unselectItem() {
        self.isSelected = false
        setUnselectedView()
    }
}

public final class RadioButtonView: UIView {

    public weak var radioButtonGroupDelegate: RadioButtonGroupDelegate?
    public weak var delegate: RadioButtonDelegate?
    private (set) var hasBottomLine: Bool = false
    private (set) var itemIndex: Int?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    public func commonInit() {
        self.setupView()
        self.addTapGesture()
    }
    
    public enum RadioButtonColors {
        static let lineColor = Colors.gray7.withAlphaComponent(0.4)
        static let headlineColor = Colors.gray6
        static let subheadlineColor = Colors.gray3
        static let subheadlineSuccessColor = Colors.green2
        static let subheadlineFailedColor = Colors.red
    }
    
    public enum Dimensions {
        static let containerHeight: CGFloat = 50
        static let lineHeight: CGFloat = 1
        static let radioButtonSize = CGSize(width: 18, height: 18)
        static let headlineFont = UIFont.semiBold(14)
        static let subHeadlineFont = UIFont.regular(14)
        static let x4: CGFloat = 4
        static let x8: CGFloat = 8
        static let x10: CGFloat = 10
        static let x14: CGFloat = 14
        static let x16: CGFloat = 16
    }
    
    //###################################################
    //MARK -> Radio Button
    //###################################################
    
    // CheckBox Detail
    public var details: RadioButtonDetails? {
        didSet {
            setupDetails()
        }
    }
    
    // View Setup
    private func setupDetails() {
        headlineLabel.text = details?.line1
        subheadlineLabel.text = details?.line2

        //Add only the label populated. The component can have one label, two labels or no label.
        if headlineLabel.text != nil {
            textStack.addArrangedSubview(headlineLabel)
        }

        if subheadlineLabel.text != nil {
            textStack.addArrangedSubview(subheadlineLabel)
        }
    }
    
    //###################################################
    //MARK -> Radio Button
    //###################################################
    
    private lazy var radioButton = RadioButton()
    
    public func setupRadioButton() {
        self.radioButton.translatesAutoresizingMaskIntoConstraints = false
        self.hStack.addArrangedSubview(radioButton)
        self.hStack.addArrangedSubview(textStack)
        self.topStack.addArrangedSubview(hStack)
        
        self.radioButton.heightAnchor.constraint(equalToConstant: Dimensions.radioButtonSize.height).isActive = true
        self.radioButton.widthAnchor.constraint(equalToConstant:  Dimensions.radioButtonSize.width).isActive = true
    }
    
    //###################################################
    //MARK -> Labels
    //###################################################
    
    public lazy var headlineLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.width, height: 20))
    public lazy var subheadlineLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.width, height: 20))
    
    public func setupLabels() {
        self.headlineLabel.font = RadioButtonView.Dimensions.headlineFont
        self.headlineLabel.textColor = RadioButtonView.RadioButtonColors.headlineColor
        self.headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.subheadlineLabel.font = RadioButtonView.Dimensions.headlineFont
        self.subheadlineLabel.textColor = RadioButtonView.RadioButtonColors.subheadlineColor
        self.subheadlineLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func setHeadline(text: String? = nil, color: UIColor? = nil, font: UIFont? = nil) {
        headlineLabel.text = text != nil ? text : headlineLabel.text
        headlineLabel.font = font ?? Dimensions.headlineFont
        headlineLabel.textColor = color ?? RadioButtonColors.headlineColor
    }
    
    public func setSubheadline(text: String? = nil, color: UIColor? = nil, font: UIFont? = nil) {
        self.subheadlineLabel.text = text != nil ? text : subheadlineLabel.text
        self.subheadlineLabel.font = font ?? Dimensions.subHeadlineFont
        self.subheadlineLabel.textColor = color ?? RadioButtonColors.subheadlineColor
    }
    
    //###################################################
    //MARK -> Views
    //###################################################
    private let containerView = UIView()
    
    public var topStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    public var hStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.distribution = .fill
        stack.axis = .horizontal
        stack.spacing = RadioButtonView.Dimensions.x8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    public var textStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.spacing = RadioButtonView.Dimensions.x4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // View Top and Bottom Lines
    lazy private var topLine = UIView()
    lazy private var bottomLine = UIView()
    
    //###################################################
    //MARK -> Views Setup
    //###################################################
    
    private func setupView() {
        addSubview(containerView)
        self.setupRadioButton()
        self.containerView.addSubview(topStack)
        self.applyStyle()
        self.applyConstraints()
    }
    
    private func applyStyle() {
        self.setHeadline()
        self.setSubheadline()
        self.topLine.backgroundColor = RadioButtonColors.lineColor
        self.bottomLine.backgroundColor = RadioButtonColors.lineColor
    }
    
    
    //###################################################
    //MARK -> Views Constraints
    //###################################################
    
    // View Constraints
    private func applyConstraints() {
        addAndConstrainContainerView()
        addAndConstrainTopLine()
        addAndConstrainStack()
    }
    
    private func addAndConstrainContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func addAndConstrainStack() {
        NSLayoutConstraint.activate([
            topStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Dimensions.x8),
            topStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Dimensions.x8),
            topStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Dimensions.x8),
            topStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Dimensions.x8),
        ])
    }
    
    private func addAndConstrainTopLine() {
        removeTopLine()
        topLine.enableAutoLayout()
        containerView.addSubview(topLine)

        NSLayoutConstraint.activate([
            topLine.topAnchor.constraint(equalTo: containerView.topAnchor),
            topLine.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            topLine.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            topLine.heightAnchor.constraint(equalToConstant: Dimensions.lineHeight)
        ])
    }
    
    private func removeTopLine() {
        topLine.removeFromSuperview()
    }
    
    public func addAndConstrainBottomLine() {
        removeBottomLine()
        bottomLine.enableAutoLayout()
        addSubview(bottomLine)
        hasBottomLine = true

        NSLayoutConstraint.activate([
            bottomLine.heightAnchor.constraint(equalToConstant: Dimensions.lineHeight),
            bottomLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    public func removeBottomLine() {
        bottomLine.removeFromSuperview()
    }
    
    public func setIndex(index: Int) {
        self.itemIndex = index
    }
    
    public func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleClickedView))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleClickedView() {
        toggleRadioButton()
    }
    
    public func toggleRadioButton() {
        radioButtonGroupDelegate?.unselectItemsNotAt(index: itemIndex)
        if !radioButton.isSelected {
            radioButton.toggleItem()
            self.delegate?.didSelect(index: itemIndex)
        }
    }
    
    public func unselectRadioButton() {
        radioButton.unselectItem()
    }
}

public protocol RadioButtonGroupDelegate: class {
    func unselectItemsNotAt(index: Int?)
}

public final class RadioButtonGroup: UIStackView, RadioButtonGroupDelegate {

    private var tableView: UITableView?
    private (set) var radioButtonItems = [RadioButtonView]()
    private (set) var radioHeight: CGFloat = 50.0

    public weak var delegate: RadioButtonDelegate? {
        didSet {
            if let delegate = delegate,
               let btnViews = arrangedSubviews as? [RadioButtonView] {
                for btn in btnViews {
                    btn.delegate = delegate
                }
            }
        }
    }
    
    public convenience init(radioHeight: CGFloat = 50.0) {
        self.init(frame: .zero)
        self.radioHeight = radioHeight
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public required init(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    public func commonInit() {
        self.axis = .vertical
        self.distribution = .fillEqually
        self.alignment = .fill
        setupRadioViews(items: mockupItems)
    }
    
    public var items: [RadioButtonDetails]? {
        didSet {
            guard let items = self.items else { return }
            self.setupRadioViews(items: items)
        }
    }
    
    // Mockup items for view initialization
    private var mockupItems = [
        RadioButtonDetails(id: "0", line1: "Mock headline 0", line2: "Mock subheadline 0"),
        RadioButtonDetails(id: "1", line1: "Mock headline 1", line2: "Mock subheadline 1"),
        RadioButtonDetails(id: "2", line1: "Mock headline 2", line2: "Mock subheadline 2")
    ]
    
    public func setupRadioViews(items: [RadioButtonDetails]) {
        radioButtonItems.removeAll()
        removeAllSubViews()
        for (i, item) in items.enumerated() {
            let radioButtonView = RadioButtonView()
            radioButtonView.details = item
            radioButtonView.delegate = delegate
            radioButtonView.radioButtonGroupDelegate = self
            radioButtonView.setIndex(index: i)
            
            if item.id == nil {
                radioButtonView.details?.id = "\(i)"
            }
            
            radioButtonView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                radioButtonView.heightAnchor.constraint(equalToConstant: radioHeight)
            ])
            
            if i >= items.count - 1 {
                radioButtonView.addAndConstrainBottomLine() //Adding bottom line after the last item
            }
            radioButtonItems.append(radioButtonView)
            addArrangedSubview(radioButtonView)
        }
    }
    
    public func unselectItemsNotAt(index: Int?) {
        for (i, item) in radioButtonItems.enumerated() {
            if i != index {
                item.unselectRadioButton()
            }
        }
    }
    
    public func toggleItem(index: Int) {
        let radioButtonView = selectRadioButtonView(index: index)
        radioButtonView?.toggleRadioButton()
    }
    
    public func selectRadioButtonView(index: Int) -> RadioButtonView? {
        return index < radioButtonItems.count ? radioButtonItems[index] : nil
    }
}
