//
//  LocationSearch.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import Foundation

public struct LocationSearch {
    public let addressTitle: String
    public let addressSubtitle: String
    public let geoPoint: LocationGeopoint
    
    public init(addressTitle: String, addressSubtitle: String, geoPoint: LocationGeopoint) {
        self.addressTitle = addressTitle
        self.addressSubtitle = addressSubtitle
        self.geoPoint = geoPoint
    }
}
