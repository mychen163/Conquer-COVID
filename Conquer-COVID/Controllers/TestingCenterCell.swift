//
//  TestingCenterCell.swift
//  Conquer-COVID
//
//  Created by M.y Chen on 12/1/20.
//

import UIKit


class TestingCenterCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var rating: UILabel!
    @IBOutlet var openNow: UILabel!
    @IBOutlet var detailsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
