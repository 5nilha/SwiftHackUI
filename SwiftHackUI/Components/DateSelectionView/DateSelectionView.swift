//
//  DateSelectionView.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit

public protocol DatePickerDelegate: class {
    func didSelectDate(date: Date)
}

public final class DatePickerView: UIStackView, RadioButtonDelegate {
    
    public weak var delegate: DatePickerDelegate?
    private lazy var radioButtonGroup = RadioButtonGroup()
    private lazy var buttonStack = UIStackView()
    
    private enum Dimensions {
        static let x4: CGFloat = 4
        static let x8: CGFloat = 8
        static let x10: CGFloat = 10
        static let x16: CGFloat = 16
        static let x30: CGFloat = 30
    }
    
    public var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .inline
        picker.tintColor = Colors.primary
        picker.minimumDate = Date()
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupView()
    }
    
    private func setupView() {
        axis = .vertical
        spacing = 10
        setupButtons()
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
    }
    
    public var buttonItems: [String]? {
        didSet {
            guard let items = buttonItems else { return }
            addButtonsItem(items: items)
        }
    }
    
    private func mockButtonsItems() {
        addButtonsItem(items: ["TODAY", "SELECT ON CALENDAR"])
    }
    
    private func addButtonsItem(items: [String]) {
        buttonStack.removeAllSubViews()
        radioButtonGroup.items = items.compactMap({ (string) -> RadioButtonDetails? in
            return RadioButtonDetails(line1: string)
        })
        buttonStack.addArrangedSubview(radioButtonGroup)
    }
    
    private func setupButtons() {
        buttonStack.axis = .horizontal
        buttonStack.alignment = .leading
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 15
        self.addArrangedSubview(buttonStack)
        radioButtonGroup.delegate = self
        mockButtonsItems()
    }
    
    public func didSelect(index: Int?) {
        switch index {
        case 0:
            self.delegate?.didSelectDate(date: Date())
        case 1:
            openCalendarView()
        default:
            return
        }
    }
    
    private func openCalendarView(){
        removeAllSubViews()
        addAndConstrainPicker()
    }
    
    private func addAndConstrainPicker() {
        self.addArrangedSubview(datePicker)
    }
    
    @objc func dateSelected() {
        self.delegate?.didSelectDate(date: datePicker.date)
    }
}

