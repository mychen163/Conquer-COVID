//
//  MapViewController.swift
//  Conquer-COVID
//
//  Created by M.y Chen on 11/23/20.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController{

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapCenterPin: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        
    }
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
      let geocoder = GMSGeocoder()
      
      // geocode reverse the coordinates into address
      geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
        guard let address = response?.firstResult(), let lines = address.lines else {
          return
        }
        //print(address.locality!)
        // set the address to the label
        self.addressLabel.text = lines.joined(separator: "\n")
          
        // once the address is set, animate the changes in the label's intrinsic content size
        UIView.animate(withDuration: 0.25) {
          self.view.layoutIfNeeded()
        }
      }
    }


}

// MARK: - CLLocationManagerDelegate
//1
extension MapViewController: CLLocationManagerDelegate {
  //It is called when the user grants or revokes location permissions.
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    // verify the user has granted you permission while the app is in use
    guard status == .authorizedWhenInUse else {
      return
    }
    // update the user's locatio once permissions have been established
    locationManager.startUpdatingLocation()
      
    //a light blue dot for the current location
    mapView.isMyLocationEnabled = true
    //a button centers the map on the user's location when tapped
    mapView.settings.myLocationButton = true
    //enable compassButton
    mapView.settings.compassButton = true
    // enable scrolling
    mapView.settings.scrollGestures = true
    // enabale zooming
    mapView.settings.zoomGestures = true
    mapView.settings.zoomGestures = true
  }
  
    // executes when the location manager receives new location data
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else {
      return
    }
    // update the camera to the center around the user's current location
    mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
      
    locationManager.stopUpdatingLocation()
  }
}

// MARK: - GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
      reverseGeocodeCoordinate(position.target)
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
    }
}

