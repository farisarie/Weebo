//
//  EpisodeViewCell.swift
//  Weabo
//
//  Created by yoga arie on 12/11/22.
//

import UIKit

class EpisodeViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var chapterLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailComic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailComic.layer.cornerRadius = 4
        thumbnailComic.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
