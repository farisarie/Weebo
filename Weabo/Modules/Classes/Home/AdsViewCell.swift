//
//  AdsViewCell.swift
//  Weabo
//
//  Created by yoga arie on 05/10/22.
//

import UIKit

protocol AdsViewCellDelegate: NSObjectProtocol {
    func readButtonTapped(_ cell: AdsViewCell)
}

class AdsViewCell: UICollectionViewCell {
    weak var delegate: AdsViewCellDelegate?
    @IBOutlet weak var continouReadButton: UIButton!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var comicThumbnail: UIImageView!
    @IBOutlet weak var adsView: UIView!
    override func awakeFromNib() {
        continouReadButton.layer.cornerRadius = 6
        continouReadButton.layer.masksToBounds = true
        labelOne.textColor = UIColor(hex: "#4F5660")
        labelTwo.textColor = UIColor(hex: "#292B2F")
        adsView.layer.cornerRadius = 6
        adsView.layer.masksToBounds = true
        adsView.backgroundColor = UIColor(hex: "#949CF7")
    }
    
    @IBAction func continueReadButtonTapped(_ sender: Any) {
        delegate?.readButtonTapped(self)
    }
}
