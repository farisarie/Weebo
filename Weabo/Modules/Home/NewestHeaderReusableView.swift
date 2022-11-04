//
//  NewestHeaderReusableView.swift
//  Weabo
//
//  Created by yoga arie on 18/10/22.
//

import UIKit

class NewestHeaderReusableView: UICollectionReusableView {

    @IBOutlet weak var seeAllLabel: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func seeAllButtonTapped(_ sender: Any) {
        
    }
    func configureHeader(title: String) {
        self.headerLabel.text = title
    }
    
}
