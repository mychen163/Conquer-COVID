//
//  TestingCentersList.swift
//  MapTest
//
//  Created by M.y Chen on 12/1/20.
//

import UIKit
import AlamofireImage
import SwiftyJSON

class TestingCentersList: UITableViewController {
    var testingCentersList: [GooglePlace]?
    var detailResultsList:[GooglePlace]?
    var googleApiKey = "AIzaSyBl3AW7yrDq7yCRATsP9-aAreOTQ9fxE68"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        print(testingCentersList?.count ?? 0)
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
            cell.rating.textColor = .blue
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
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    //find the detailed information about every testing center
//       func fetchPlaceDetails(place_id:String,completion:@escaping(()->Void)){
//           var urlString = "https://maps.googleapis.com/maps/api/place/details/json?place_id=\(place_id)&key=\(googleApiKey)"
//           urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? urlString
//
//           guard let url = URL(string: urlString) else{
//               return
//           }
//        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: { (data,response,error) -> Void in
//            if let json = try? JSON( data: data!, options: .mutableContainers),let result = json["result"].arrayObject as? [[String: Any]] {
//                DispatchQueue.main.async {
//                results.forEach { result in
//                    let place = GooglePlace(dictionary: result)
//                        //print("There")
//                        self.placesArray.append(place)
//                        self.markerPlace(place:place)
//                    }
//                    completion()
//                }
//
//            }
//        }).resume()
//  }
}

