//
//  CustomCollectionCell.swift
//  CollectionViewSlantedLayout
//
//  Created by Yassir Barchi on 28/02/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

import UIKit

import CollectionViewSlantedLayout

let yOffsetSpeed: CGFloat = 150.0
let xOffsetSpeed: CGFloat = 100.0

class PerkCustomCollectionCell: CollectionViewSlantedCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var PerkNameLabel: UILabel!
    @IBOutlet weak var PerkAddressLabel: UILabel!
    @IBOutlet weak var SideMenuButton: UIButton!

    @IBOutlet weak var PerkDescriptionLabel: UILabel!
    private var gradient = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let backgroundView = backgroundView {
            gradient.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
            gradient.locations = [0.0, 1.0]
            gradient.frame = backgroundView.bounds
            backgroundView.layer.addSublayer(gradient)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let backgroundView = backgroundView {
            gradient.frame = backgroundView.bounds
        }
    }
    
    var image: UIImage = UIImage() {
        didSet {
            imageView.image = image
        }
    }
var name: String?   {
    didSet {
        PerkNameLabel.text = name
        
    }
    
}
    
    var perk: String? {
        didSet{
            PerkDescriptionLabel.text = perk
        }
    }
var address: String? {
    didSet {
        PerkAddressLabel.text = address
    }
}
    
    var imageHeight: CGFloat {
        return (imageView?.image?.size.height) ?? 0.0
    }
    
    var imageWidth: CGFloat {
        return (imageView?.image?.size.width) ?? 0.0
    }

    
    func offset(_ offset: CGPoint) {
        imageView.frame = self.imageView.bounds.offsetBy(dx: offset.x, dy: offset.y)
    }
}
