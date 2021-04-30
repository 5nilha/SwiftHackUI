//
//  LocationGeopoint.swift
//  SwiftHackUI
//
//  Created by Fabio Quintanilha on 4/29/21.
//

import Foundation
import CoreLocation

public struct LocationGeopoint {
    public let latitude: Double
    public let longitude: Double
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public var locationCoordinate: CLLocation {
        let lat: CLLocationDegrees = latitude
        let long: CLLocationDegrees = longitude
        return CLLocation(latitude: lat, longitude: long)
    }
}
