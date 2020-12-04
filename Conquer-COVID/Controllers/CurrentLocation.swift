//
//  CurrentLocation.swift
//  Conquer-COVID
//
//  Created by M.y Chen on 12/3/20.
//

import Foundation
import GoogleMaps
import GooglePlaces

class CurrentLocation {
    static let sharedInstance = CurrentLocation()
    
    var coordinate = CLLocationCoordinate2D(latitude:0.0,  longitude:0.0)
}
