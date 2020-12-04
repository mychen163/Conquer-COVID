//
//  MapViewController.swift
//  MapTest
//
//  Created by M.y Chen on 11/25/20.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON

class MapViewController: UIViewController {
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    
    @IBOutlet weak var searchNearby: UIButton!
    @IBOutlet var detailsButton: UIBarButtonItem!
    @IBOutlet weak var mapView: GMSMapView!
    
    let googleApiKey = "AIzaSyBl3AW7yrDq7yCRATsP9-aAreOTQ9fxE68"
    var placesArray:[GooglePlace] = []
    let searchRadius: Double = 5000
    let locationManager = CLLocationManager()
    var current_state = ""
    
    @IBAction func nearbySearch(_ sender: Any) {
        self.fetchNearbyPlaces(coordinate: self.mapView.camera.target, radius: self.searchRadius) {
            if self.placesArray.count != 0 {
                self.navigationItem.rightBarButtonItem = self.detailsButton
            }else{
                self.navigationItem.rightBarButtonItem = nil
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchNearby.layer.cornerRadius = 10.0
        self.view.addSubview(searchNearby)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        mapView.delegate = self
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        // Put the search bar in the navigation bar.
        searchController?.searchBar.sizeToFit()
        navigationItem.titleView = searchController?.searchBar
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        
        // Prevent the navigation bar from being hidden when searching.
        searchController?.hidesNavigationBarDuringPresentation = false
        self.navigationItem.rightBarButtonItem = nil
        
    }
    
    private func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D, radius: Double, completion: @escaping(() -> Void)) {
        mapView.clear()
        placesArray.removeAll()
        var urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&radius=\(searchRadius)&keyword=COVID+Testing&key=\(googleApiKey)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? urlString
        guard let url = URL(string: urlString) else{
            return
        }
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: { (data,response,error) -> Void in
            if let json = try? JSON( data: data!, options: .mutableContainers),let results = json["results"].arrayObject as? [[String: Any]] {
                
                DispatchQueue.main.async {
                    results.forEach { result in
                        let place = GooglePlace(dictionary: result)
                        //print("There")
                        self.placesArray.append(place)
                        self.markerPlace(place:place)
                    }
                    //print(results.count)
                    completion()
                }
                
            }
        }).resume()
    }
    
    
    private func markerPlace(place:GooglePlace){
        
        let marker = GMSMarker()
        //print(places.count)
        marker.position = place.coordinate
        marker.title = place.name
        if place.open_now {
            marker.snippet = "Open now"
        }else{
            marker.snippet = "Closed"
        }
        marker.icon = UIImage(named: "hospital")
        marker.map = self.mapView
    }
    
    
    
    // reverse the coordinates into address for Info view
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D, marker:GMSMarker ){
        
        let geocoder = GMSGeocoder()
        // geocode reverse the coordinates into address
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
           // print(address.locality!)
            print(address.administrativeArea ?? "")
            let vc = CurrentLocation.sharedInstance
            vc.current_state = address.administrativeArea ?? "Error"
            
            marker.snippet = lines.joined(separator: "\n")
            // once the address is set, animate the changes in the label's intrinsic content size
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? TestingCentersList {
            //print("prepare")
            dest.testingCentersList = placesArray
           // print(placesArray.count)
        }
    }
}


extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3
        guard status == .authorizedWhenInUse else {
            print("error")
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 12, bearing: 0, viewingAngle: 0)
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude:location.coordinate.latitude , longitude: location.coordinate.longitude)
        marker.title = "Current Postion"
        marker.icon = UIImage(named: "icon_current")
        reverseGeocodeCoordinate(marker.position, marker: marker)
        marker.map = mapView
        locationManager.stopUpdatingLocation()
        //        self.fetchNearbyPlaces(coordinate: location.coordinate, radius: searchRadius){
        //        }
        
    }
}
// MARK: - GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        //reverseGeocodeCoordinate(position.target)
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
    }
}

extension MapViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        
        // Do something with the selected place.
        self.mapView.clear()
        mapView.camera = GMSCameraPosition(target: place.coordinate, zoom: 12, bearing: 0, viewingAngle: 0)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude:place.coordinate.latitude , longitude: place.coordinate.longitude)
        marker.title = "Search Postion"
        reverseGeocodeCoordinate(marker.position, marker: marker)
        marker.map = mapView
        self.navigationItem.rightBarButtonItem = nil
        reverseGeocodeCoordinate(marker.position, marker: marker)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
}


