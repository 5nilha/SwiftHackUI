//
//  DayGroupView.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/30/21.
//

import UIKit

public final class DaysGroupView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var seletedMonth: Calendar.Month?
    private var dates = Date().daysFromToday(days: 30)
    private var selectedDate: Date?
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public func commonInit() {
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        addAndConstrainCollectionView()
    }
    
    private func addAndConstrainCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let daysCollectionView = UICollectionView(frame: .zero,  collectionViewLayout: layout)
        daysCollectionView.showsHorizontalScrollIndicator = false
        daysCollectionView.backgroundColor = .clear
        daysCollectionView.delegate = self
        daysCollectionView.dataSource = self
        daysCollectionView.register(DayGroupCell.self, forCellWithReuseIdentifier: DayGroupCell.identifier)
        daysCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(daysCollectionView)
        
        NSLayoutConstraint.activate([
            daysCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            daysCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            daysCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            daysCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dates.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayGroupCell.identifier, for: indexPath) as? DayGroupCell else { return UICollectionViewCell()}
        cell.setupView(date: dates[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DayGroupCell else { return }
        cell.selectDateCell()
        selectedDate = dates[indexPath.row]
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DayGroupCell else { return }
        cell.deSelectDateCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
}

public class DayGroupCell: UICollectionViewCell {
    
    public static let identifier = "dayGroupCell"
    private lazy var stackView = UIStackView()
    private let circleView = CircleView()
    private var date: Date?
    
    public func setupView(date: Date) {
        self.date = date
        contentView.backgroundColor = .clear
        addAndConstrainStackView()
        addAndContraingWeekLabel()
        addAndConstrainCircleView()
    }
    
    private func addAndConstrainStackView() {
        self.contentView.removeAllSubViews()
        stackView.removeAllSubViews()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 20
        self.contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
        ])
    }
    
    private func addAndContraingWeekLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.regular(13)
        label.textColor = Colors.gray8
        label.text = date?.weekDay
        label.textAlignment = .center
        stackView.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 50),
            label.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    private func addAndConstrainCircleView() {
        let view = UIView()
        guard let date = self.date else { return }
        circleView.translatesAutoresizingMaskIntoConstraints = false
        date.day == Date().day ? circleView.filled() : circleView.outlined()
        circleView.text = "\(date.day)"
        stackView.addArrangedSubview(view)
        view.addSubview(circleView)
        
        NSLayoutConstraint.activate([
            circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circleView.heightAnchor.constraint(equalToConstant: 40),
            circleView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    public func selectDateCell() {
        self.circleView.filled()
    }
    
    public func deSelectDateCell() {
        self.circleView.outlined()
    }
}
