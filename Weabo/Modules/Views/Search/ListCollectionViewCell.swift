//
//  ListCollectionViewCell.swift
//  Weabo
//
//  Created by yoga arie on 08/11/22.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var descComic: UILabel!
    @IBOutlet weak var titleComic: UILabel!
    @IBOutlet weak var typeComic: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
