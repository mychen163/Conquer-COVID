//
//  InfoViewController.swift
//  Conquer-COVID
//
//  Created by M.y Chen on 12/3/20.
//

import UIKit

class InfoViewController: UIViewController {
    var state: String?

    @IBOutlet var headLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        state = CurrentLocation.sharedInstance.current_state
        if let state = state{
            headLabel.text = "\(state) Covid-19 Info"
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
