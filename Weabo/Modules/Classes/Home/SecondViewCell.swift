//
//  SecondViewCell.swift
//  Weabo
//
//  Created by yoga arie on 04/10/22.
//

import UIKit

class SecondViewCell: UICollectionViewCell {
    @IBOutlet weak var descText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 6
        layer.masksToBounds = true
        layer.borderWidth = 0.3
        layer.borderColor = UIColor(hex: "5865F2").cgColor
    }

}
