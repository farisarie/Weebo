//
//  ComicDetailViewCell.swift
//  Weabo
//
//  Created by yoga arie on 11/11/22.
//

import UIKit

class ComicDetailViewCell: UITableViewCell {

    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupViews(){
        comicImageView.layer.cornerRadius = 8
        comicImageView.layer.masksToBounds = true
    }
}
