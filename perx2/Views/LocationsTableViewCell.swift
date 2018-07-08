//
//  LocationsTableViewCell.swift
//  perx2
//
//  Created by Montreaux Rodgers on 7/7/18.
//  Copyright © 2018 Montreaux Rodgers. All rights reserved.
//

import UIKit

class LocationsTableViewCell: UITableViewCell {
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var openLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
