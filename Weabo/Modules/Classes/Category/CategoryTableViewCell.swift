//
//  CategoryTableViewCell.swift
//  Weabo
//
//  Created by yoga arie on 08/11/22.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryComic: UILabel!
    @IBOutlet weak var titleComic: UILabel!
    @IBOutlet weak var totalLikesComic: UILabel!
    @IBOutlet weak var descComic: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0))
    }
    
}
