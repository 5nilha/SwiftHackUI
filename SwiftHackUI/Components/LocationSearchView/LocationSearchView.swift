//
//  LocationSearchView.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import UIKit
import MapKit

public protocol LocationSearchViewDelegate: class {
    func didSelectLocation(location: LocationSearch)
}

public final class LocationSearchView: UIStackView {
    private let view = UIView()
    private var isResultsOnTop = false
    public weak var delegate: LocationSearchViewDelegate?
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var searchTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter location"
        textfield.borderStyle = .roundedRect
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    // Create a search completer object
    public var searchCompleter = MKLocalSearchCompleter()

    // These are the results that are returned from the searchCompleter & what we are displaying
    // on the searchResultsTable
    public var searchResults = [MKLocalSearchCompletion]()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 0
        self.backgroundColor = Colors.menuGray
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchTextField.delegate = self
        tableView.backgroundColor = Colors.menuGray
        searchCompleter.delegate = self
        setupView()
    }
    
    private func setupView() {
        self.removeAllSubViews()
        if isResultsOnTop {
            addAndConstrainSearchTextField()
            addAndConstrainTableView()
        } else {
            addAndConstrainTableView()
            addAndConstrainSearchTextField()
        }
    }
    
    private func addAndConstrainSearchTextField() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchTextField)
        self.addArrangedSubview(view)
        
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: self.width),
            searchTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8),
            searchTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
            searchTextField.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -8),
        ])
    }
    
    private func addAndConstrainTableView() {
        self.addArrangedSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalToConstant: self.width)
        ])
    }
    
    public func setPlaceholder(placeholder: String) {
        searchTextField.placeholder = placeholder
    }
    
    private func getLocationData(_ addressResult: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: addressResult)

        let search = MKLocalSearch(request: searchRequest)
        search.start { [weak self] (response, error) in

            guard let locationItem = response?.mapItems[0],
                  let name = locationItem.name
            else {
                return
            }
            
            let coordinate = locationItem.placemark.coordinate
            let lat = coordinate.latitude
            let lon = coordinate.longitude
                
            let location = LocationSearch(addressTitle: name, addressSubtitle: addressResult.subtitle, geoPoint: LocationGeopoint(latitude: lat, longitude: lon))
                
            self?.delegate?.didSelectLocation(location: location)
        }
    }
    
    public func setResultsOnTop() {
        isResultsOnTop = true
    }
}

extension LocationSearchView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            searchCompleter.queryFragment = "\(text)\(string)"
        }
        return true
    }

}


extension LocationSearchView: MKLocalSearchCompleterDelegate {
    
    // This method declares gets called whenever the searchCompleter has new search results
    // If you wanted to do any filter of the locations that are displayed on the the table view
    // this would be the place to do it.
    public func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // Setting our searchResults variable to the results that the searchCompleter returned
        searchResults = completer.results

        tableView.reloadData()
        self.invalidateIntrinsicContentSize()
    }

    // This method is called when there was an error with the searchCompleter
    public func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        tableView.reloadData()
        self.invalidateIntrinsicContentSize()
    }
}

extension LocationSearchView: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        cell.contentView.backgroundColor = Colors.menuGray
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let result = searchResults[indexPath.row]
        getLocationData(result)
    }
    
    public override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: searchResults.count <= 3 ?  CGFloat(searchResults.count * 55): 165.0)
    }
}
