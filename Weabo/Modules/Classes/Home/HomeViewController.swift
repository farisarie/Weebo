//
//  HomeViewController.swift
//  Weabo
//
//  Created by yoga arie on 04/10/22.
//`

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        collectionView.register(UINib(nibName: "NewestHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        collectionView.register(UINib(nibName: "SearchBarReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "searchCell")

        collectionView.dataSource = self
        collectionView.delegate = self
        let notifButton = UIBarButtonItem(image: UIImage(named: "bell")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.done, target: self, action: #selector(self.notificationButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem  = notifButton
    }
    
    @objc func notificationButtonTapped(_ sender: Any) {
        print("Notification button is tapped")
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
            
        case 1:
            return 1
            
        case 2:
            return 1
            
        case 3:
            return 2
            
        case 4:
            return 4
            
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! TopViewCell
        
        return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subCell", for: indexPath) as!
            MidViewCell
            
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "adsCell", for: indexPath) as! AdsViewCell
            
            return cell
            
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCell", for: indexPath) as!
                BottomViewCell
            if indexPath.row == 0 {
                cell.titleLabel.text = "Sedang Trending"
            } else {
                cell.titleLabel.text = "Rekomendasi Untukmu"
            }
        return cell
            
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newestCell", for: indexPath) as!
                NewestViewCell
            cell.imageView.image = UIImage(named: "chainsawman")
            cell.categoryLabel.text = "Kategori"
            cell.comicTitle.text = "Chainsawman"
            cell.accessDateLabel.text = "Diakses pada 9 September 2022"
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
        
        return CGSize(
            width: self.view.frame.width,
            height: 152
        )
            
        case 1:
        return CGSize(width: self.view.frame.width, height: 130)
            
        case 2:
            return CGSize(width: self.view.frame.width, height: 72)
            
            
        case 3:
            return CGSize(width: self.view.frame.width, height: 330)
            
        case 4:
            return CGSize(width: self.view.frame.width, height: 78)
        default:
            return CGSize()
            
        
    }

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
            if indexPath.section == 4 {
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? NewestHeaderReusableView {
                headerView.headerLabel.text = "Komik Terbaru"
                
                return headerView
                } 
            } else if indexPath.section == 0 {
                if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "searchCell", for: indexPath) as? SearchBarReusableView
                {
                    
                    return headerView
            }
        }
        default:
            return UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 4 {
            return CGSize(width: collectionView.frame.width, height: 30)
        } else if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 50)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
    
}
