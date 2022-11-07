//
//  SearchCollectionViewCell.swift
//  Weabo
//
//  Created by yoga arie on 19/10/22.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var searchLabelText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.backgroundColor = UIColor(hex: "#E0E0E0")
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
    }

}
