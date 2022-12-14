//
//  ReadViewCell.swift
//  ComicKid
//
//  Created by yoga arie on 11/11/22.
//

import UIKit

class ReadViewCell: UITableViewCell {


    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
