//
//  TestingCentersList.swift
//  Conquer-COVID
//
//  Created by M.y Chen on 12/1/20.
//

import UIKit
import AlamofireImage
import SwiftyJSON

class TestingCentersList: UITableViewController {
    
    var testingCentersList: [GooglePlace]?
    var googleApiKey = "AIzaSyBl3AW7yrDq7yCRATsP9-aAreOTQ9fxE68"
    var current_placeId = ""
    var photo_reference: String?
    var open_now : Bool?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
       // print(testingCentersList?.count ?? 0)
    }
    
    @IBAction func viewDetails(_ sender: UIButton) {
        let buttonPostion = sender.convert(sender.bounds.origin, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: buttonPostion){
            let rowIndex = indexPath.row
            if let list = testingCentersList {
                current_placeId = list[rowIndex].place_id
                open_now = list[rowIndex].open_now
                photo_reference = list[rowIndex].photoReference
            }
        }
        
        self.performSegue(withIdentifier: "viewDetailsSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "viewDetailsSegue" {
            if let destVC = segue.destination as? TestingCenterDetailsViewController {
                destVC.place_id = current_placeId
                destVC.open_now = open_now
                destVC.photo_reference = photo_reference
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return testingCentersList?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testingCenterCell", for: indexPath) as! TestingCenterCell
        
        if let list = testingCentersList {
            cell.nameLabel.text = list[indexPath.row].name
            let url = URL(string: list[indexPath.row].iconUrl)
            cell.iconImage.af.setImage(withURL: url!)
            cell.iconImage.layer.masksToBounds = true
            cell.iconImage.layer.cornerRadius = cell.iconImage.bounds.width/2
            cell.rating.text = String(list[indexPath.row].rating)
            cell.rating.textColor = .orange
            cell.address.text = list[indexPath.row].address
            if list[indexPath.row].open_now {
                cell.openNow.text = "Open now"
                cell.openNow.textColor = .systemGreen
            }else{
                cell.openNow.text = "Closed"
                cell.openNow.textColor = .red
            }
        }
        
        return cell
    }
    
}
