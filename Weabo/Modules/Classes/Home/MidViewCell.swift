//
//  MidViewCell.swift
//  Weabo
//
//  Created by yoga arie on 05/10/22.
//

import UIKit

class MidViewCell: UICollectionViewCell {
    @IBOutlet weak var midCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        let nibCell = UINib(nibName: "SecondViewCell", bundle: nil)
        self.midCollectionView.register(nibCell, forCellWithReuseIdentifier: "SecondCell")
        self.midCollectionView.dataSource = self
        self.midCollectionView.delegate = self
    }
}

extension MidViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCell", for: indexPath) as! SecondViewCell
        cell.imageView.image = UIImage(named: "empty")
        cell.descText.text = "Lorem"
        return cell
    }
}

extension MidViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 55, height: 90)
   }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 19
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 19
    }

}
