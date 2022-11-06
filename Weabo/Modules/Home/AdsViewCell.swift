//
//  AdsViewCell.swift
//  Weabo
//
//  Created by yoga arie on 05/10/22.
//

import UIKit

class AdsViewCell: UICollectionViewCell {
    
    @IBOutlet weak var continouReadButton: UIButton!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelOne: UILabel!
    
    @IBOutlet weak var adsView: UIView!
    override func awakeFromNib() {
        continouReadButton.layer.cornerRadius = 6
        continouReadButton.layer.masksToBounds = true
        labelOne.textColor = UIColor(hex: "#5865F2")
        labelTwo.textColor = UIColor(hex: "#5865F2")
        adsView.layer.cornerRadius = 6
        adsView.layer.masksToBounds = true
        adsView.backgroundColor = UIColor(hex: "#949CF7")
    }
}
