//
//  FirstViewCell.swift
//  Weabo
//
//  Created by yoga arie on 04/10/22.
//

import UIKit

// MARK: - Code Broken
protocol FirstViewCellDelegate: AnyObject{
    func readButton()
}

    

class FirstViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    weak var delegate: FirstViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func readButtonTapped(_ sender: Any) {
        delegate?.readButton()
    }
    
}
