//
//  BottomViewCell.swift
//  Weabo
//
//  Created by yoga arie on 05/10/22.
//

import UIKit

class BottomViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    override func awakeFromNib() {
        let nibCell = UINib(nibName: "ThirdViewCell", bundle: nil)
        self.bottomCollectionView.register(nibCell, forCellWithReuseIdentifier: "ThirdCell")
        self.bottomCollectionView.dataSource = self
        self.bottomCollectionView.delegate = self
    }
    
}

extension BottomViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdCell", for: indexPath) as! ThirdViewCell
        cell.comicImage.image = UIImage(named: "denji")
        cell.titleLabel.text = "Lorem ipsum dolor sit"
        cell.categoryLabel.text = "Category"
        return cell
    }
}

extension BottomViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 150, height: 284)
   }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
