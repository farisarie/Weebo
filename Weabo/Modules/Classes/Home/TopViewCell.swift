//
//  TopViewCell.swift
//  Weabo
//
//  Created by yoga arie on 04/10/22.
//

import UIKit

class TopViewCell: UICollectionViewCell {
    
    @IBOutlet weak var topCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        let nibCell = UINib(nibName: "FirstViewCell", bundle: nil)
        self.topCollectionView.register(nibCell, forCellWithReuseIdentifier: "FirstCell")
        self.topCollectionView.dataSource = self
        self.topCollectionView.delegate = self
    }
    
    
}

extension TopViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCell", for: indexPath) as! FirstViewCell
        cell.imgView.image = UIImage(named: "denjis")
        return cell
    }
}

extension TopViewCell: UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 313, height: 152)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}

