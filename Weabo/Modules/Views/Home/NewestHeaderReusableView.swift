//
//  NewestHeaderReusableView.swift
//  Weabo
//
//  Created by yoga arie on 18/10/22.
//

import UIKit

protocol NewestHeaderDelegate: AnyObject {
    func seeAllButtonTapped(_ header: NewestHeaderReusableView)
}

class NewestHeaderReusableView: UICollectionReusableView {
    
    weak var delegate: NewestHeaderDelegate?
    @IBOutlet weak var seeAllLabel: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func seeAllButtonTapped(_ sender: Any) {
        delegate?.seeAllButtonTapped(self)
    }
    
    func configureHeader(title: String) {
        self.headerLabel.text = title
    }
    
}
