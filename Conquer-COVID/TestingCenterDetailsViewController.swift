//
//  TestingCenterDetailsViewController.swift
//  Conquer-COVID
//
//  Created by M.y Chen on 12/2/20.
//

import UIKit
import GoogleMaps
import GooglePlaces
import AlamofireImage

typealias PhotoCompletion = (UIImage?) -> Void

class TestingCenterDetailsViewController: UIViewController {
    var place_id: String?
    var open_now: Bool?
    var photo_reference: String?
    var placesClient:GMSPlacesClient!
    let googleApiKey = "AIzaSyBl3AW7yrDq7yCRATsP9-aAreOTQ9fxE68"
    
    private var photoCache: [String: UIImage] = [:]
    
    @IBOutlet var photo: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var website: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var openNow: UILabel!
    @IBOutlet var openHours: UILabel!
     
    private var session: URLSession {
      return URLSession.shared
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the photo of the place
        if let reference = photo_reference {
            fetchPhotoFromReference(reference: reference){image in
                self.photo.image = image
            }
        }

        placesClient = GMSPlacesClient.shared()
        // Specify the place data types to return.
        let fields: GMSPlaceField = [.name, .formattedAddress, .website, .phoneNumber, .openingHours]

        placesClient.fetchPlace(fromPlaceID: place_id ?? "", placeFields: fields, sessionToken: nil, callback: {
          (place, error) -> Void in
          if let error = error {
            print("An error occurred: \(error.localizedDescription)")
            return
          }

          if let place = place {
            self.name.text = place.name
            self.address.text = place.formattedAddress
            self.website.text = place.website?.absoluteString
            self.phone.text = place.phoneNumber
            let openingHours = place.openingHours
            if let weekdayText = openingHours?.weekdayText?.joined(separator: "\n"){
                self.openHours.text = weekdayText
              
            }
            if self.open_now != nil {
                if self.open_now! {
                    self.openNow.text = "Open now"
                    self.openNow.textColor = .systemGreen
                }else{
                self.openNow.text = "Closed"
                self.openNow.textColor = .red
             }
            }
          
          }
        })
        
    }
  
    func fetchPhotoFromReference(reference: String, completion: @escaping PhotoCompletion) ->Void {
        if let photo = photoCache[reference]{
            completion(photo)
        }else{
            let urlString = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=230&photoreference=\(reference)&key=\(googleApiKey)"
            guard let url = URL(string: urlString) else {
              completion(nil)
              return
            }
        session.downloadTask(with: url) { url, response, error in
          var downloadedPhoto: UIImage? = nil
          defer {
            DispatchQueue.main.async {
              completion(downloadedPhoto)
            }
          }
          guard let url = url else {
            return
          }
          guard let imageData = try? Data(contentsOf: url) else {
            return
          }
          downloadedPhoto = UIImage(data: imageData)
            self.photoCache[reference] = downloadedPhoto
        }
          .resume()
      }
        
    }
    
}
