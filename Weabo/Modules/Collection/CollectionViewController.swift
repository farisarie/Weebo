//
//  CollectionViewController.swift
//  Weabo
//
//  Created by yoga arie on 06/11/22.
//

import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentView!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Collection"
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.register(UINib(nibName: "NewestHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        self.segmentedControl.frame = CGRect(
            x: self.segmentedControl.frame.minX,
            y: self.segmentedControl.frame.minY,
            width: segmentedControl.frame.width,
            height: 60)
        segmentedControl.highlightSelectedSegment()
    }
    
    
    @IBAction func segmentControlDidChange(_ sender: Any) {
        print("test")
        segmentedControl.underlinePosition()
    }
    
}

extension CollectionViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newestCell", for: indexPath) as!
        NewestViewCell
    cell.imageView.image = UIImage(named: "chainsawman")
    cell.categoryLabel.text = "Kategori"
    cell.comicTitle.text = "Chainsawman"
    cell.accessDateLabel.text = "Diakses pada 9 September 2022"
    return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 78)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? NewestHeaderReusableView {
                headerView.headerLabel.text = "10 Komik"
                return headerView
                }
            
        default:
            return UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 30)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
    
}
