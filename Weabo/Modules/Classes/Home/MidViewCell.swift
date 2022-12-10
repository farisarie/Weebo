//
//  MidViewCell.swift
//  Weabo
//
//  Created by yoga arie on 05/10/22.
//

import UIKit

// MARK: - Code Broken
protocol MidViewCellDelegate: AnyObject {
    func navigateToCategory(_ cell: MidViewCell, _ index: Int)
}

class MidViewCell: UICollectionViewCell {
    @IBOutlet weak var seeAllButtonOutlet: UIButton!
    @IBOutlet weak var midCollectionView: UICollectionView!
    weak var delegate: MidViewCellDelegate?
    
    let screenWidth = UIScreen.main.bounds.width
    let lowestScreenWidth: CGFloat = 375.0
    
    let categoryHome: [Category] = [
        Category(categoryImage: "action", name: "Manga"),
        Category(categoryImage: "comedy", name: "Manhwa")
    ]
    
    
    
    override func awakeFromNib() {
        let nibCell = UINib(nibName: "SecondViewCell", bundle: nil)
        self.midCollectionView.register(nibCell, forCellWithReuseIdentifier: "SecondCell")
        self.midCollectionView.dataSource = self
        self.midCollectionView.delegate = self
    }
    
    @IBAction func seeAllButtonTapped(_ sender: Any) {
     
    }
    
}

extension MidViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryHome.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCell", for: indexPath) as! SecondViewCell
        let cellCategory = categoryHome[indexPath.item]
        cell.descText.text = cellCategory.name
        return cell
    }
}

extension MidViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 178, height: 51)
   }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

}

extension MidViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        midCollectionView.reloadData()
        delegate?.navigateToCategory(self, indexPath.row)
    }
}
