//
//  ThirdViewCell.swift
//  Weabo
//
//  Created by yoga arie on 05/10/22.
//

import UIKit

class ThirdViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var numberOfLikes: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var comicImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBackground.layer.cornerRadius = 10
        viewBackground.layer.masksToBounds = true
        viewBackground.backgroundColor = UIColor(hex: "F2F2F2")
    }

}
