//
//  CalendarView.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit

public protocol CalendarViewDelegate: class {
    func didSelectDate(date: Date)
}

public final class CalendarView: UIView {
    
    public weak var delegate: CalendarViewDelegate?
    
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
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupView()
    }
    
    private func setupView() {
        addAndConstrainPicker()
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
    }
    
    private func addAndConstrainPicker() {
        self.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: self.topAnchor, constant: Dimensions.x10),
            datePicker.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Dimensions.x30),
            datePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Dimensions.x30),
            datePicker.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Dimensions.x10)
        ])
    }
    
    @objc func dateSelected() {
        self.delegate?.didSelectDate(date: datePicker.date)
    }
}
