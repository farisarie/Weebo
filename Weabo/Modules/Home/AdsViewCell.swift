//
//  AdsViewCell.swift
//  Weabo
//
//  Created by yoga arie on 05/10/22.
//

import UIKit

class AdsViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelOne: UILabel!
    
    @IBOutlet weak var adsView: UIView!
    override func awakeFromNib() {
        adsView.layer.cornerRadius = 6
        adsView.layer.masksToBounds = true
    }
}
