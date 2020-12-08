//
//  InfoViewController.swift
//  Conquer-COVID
//
//  Created by M.y Chen on 12/3/20.
//

import UIKit
import GoogleMaps
import GooglePlaces
import SwiftyJSON

class InfoViewController: UIViewController {
    var state: String?
    var coordinate = CLLocationCoordinate2D(latitude:0.0,  longitude:0.0)
    var county: String?

    @IBOutlet var headLabel: UILabel!
    @IBOutlet var countyLabel: UILabel!
    @IBOutlet var confirmedCasesLabel: UILabel!
    @IBOutlet var deathsLabel: UILabel!
    @IBOutlet var recoveredLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        coordinate = CurrentLocation.sharedInstance.coordinate
        state = CurrentLocation.sharedInstance.current_state
        print(CurrentLocation.sharedInstance.coordinate.latitude)
        if state != nil{
            headLabel.text = "\(state ?? "") Covid-19 Info"
        }else{
            headLabel.text = "Covid-19 Info"
        }
        print(state ?? "")
        print(coordinate.latitude,coordinate.longitude)
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    getCounty()

    }
    
    func getCounty() {
        let url = URL(string: "https://geo.fcc.gov/api/census/area?lat=\(CurrentLocation.sharedInstance.coordinate.latitude)&lon=\(CurrentLocation.sharedInstance.coordinate.longitude)&format=json")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let results = dataDictionary["results"] as! [[String:Any]]
                self.countyLabel.text = (results[0]["county_name"] as! String) + " County"
                self.county = (results[0]["county_name"] as! String)
                self.getCountyInfo()
            }
        }
        task.resume()
        return
    }
    
    func getCountyInfo() {
       // var countyName = self.county?.replacingOccurrences(of: " ", with: "%20")
        print(self.county ?? "" )
        var urlString = "https://corona.lmao.ninja/v2/jhucsse/counties/\(self.county ?? "")"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? urlString
        print(urlString)
        guard  let url = URL(string: urlString) else{
            print("URL error")
            return
        }
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
        
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
               // print(dataDictionary)
                // TODO: Get the array of movies
            
                if  let  results = dataDictionary?[0]["stats"] as? [String:Any] {
                    // print(results)
                    let confirmedCase = results["confirmed"] as! Int
                    self.confirmedCasesLabel.text = "Confirmed: \(confirmedCase)"
                    self.confirmedCasesLabel.textColor = .systemRed
                    let recovered = results["recovered"] as! Int
                    self.recoveredLabel.text = "Recovered: \(recovered)"
                    self.recoveredLabel.textColor = .systemGreen
                    let deaths = results["deaths"] as! Int
                    self.deathsLabel.text = "Deaths: \(deaths)"
                }
                
                
//                self.confirmedCasesLabel.text = results["confirmed"]
//                self.deathsLabel.text = results["deaths"] as? String
//                self.recoveredLabel.text = results["recovered"] as? String
            }
        }
        
        task.resume()
    }
}
