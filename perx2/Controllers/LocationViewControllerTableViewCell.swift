//
//  ViewControllerTableViewCell.swift
//  CustomTableView
//
//  Created by Belal Khan on 30/07/17.
//  Copyright © 2017 Belal Khan. All rights reserved.
//

import UIKit

class LocationViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelTeam: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
