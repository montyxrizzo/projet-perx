//
//  CompanyTableViewCell.swift
//  perx2
//
//  Created by Montreaux Rodgers on 7/2/18.
//  Copyright © 2018 Montreaux Rodgers. All rights reserved.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {
    @IBOutlet weak var companyImageView: UIImageView!

    @IBOutlet weak var labelName: UILabel!
    
//    @IBOutlet weak var labelCategory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
