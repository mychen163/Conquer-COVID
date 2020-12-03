//
//  GooglePlace.swift
//  MapTest
//
//  Created by M.y Chen on 11/25/20.
//

import UIKit
import Foundation
import CoreLocation
import SwiftyJSON

class GooglePlace {
  let name: String
  let address: String
  let coordinate: CLLocationCoordinate2D
  var photoReference: String?
  var photo: UIImage?
  var open_now: Bool
  var iconUrl:String
  var rating:Double
  var place_id: String
    
  init(dictionary: [String: Any])
  {
    let json = JSON(dictionary)
    name = json["name"].stringValue
    address = json["vicinity"].stringValue
    open_now = json["opening_hours"]["open_now"].boolValue
    iconUrl = json["icon"].stringValue
    rating = json["rating"].doubleValue
    place_id = json["place_id"].stringValue
    
    let lat = json["geometry"]["location"]["lat"].doubleValue as CLLocationDegrees
    let lng = json["geometry"]["location"]["lng"].doubleValue as CLLocationDegrees
    coordinate = CLLocationCoordinate2DMake(lat, lng)
    photoReference = json["photos"][0]["photo_reference"].string
    }
}
