//
//  ListTableViewCell.swift
//  Weabo
//
//  Created by yoga arie on 18/11/22.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleComic: UILabel!
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

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }
    
}
