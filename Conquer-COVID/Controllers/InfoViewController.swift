//
//  InfoViewController.swift
//  Conquer-COVID
//
//  Created by M.y Chen on 12/3/20.
//

import UIKit
import GoogleMaps
import GooglePlaces

class InfoViewController: UIViewController {
    var coordinate = CLLocationCoordinate2D(latitude:0.0,  longitude:0.0)

    @IBOutlet var headLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        coordinate = CurrentLocation.sharedInstance.coordinate
        if coordinate != nil{
            headLabel.text = "\(coordinate) Covid-19 Info"
        }else{
            headLabel.text = "Covid-19 Info"
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
