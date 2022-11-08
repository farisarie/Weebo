//
//  SearchViewController.swift
//  Weabo
//
//  Created by yoga arie on 18/10/22.
//

import UIKit

class SearchViewController: UIViewController {

    let screenWidth = UIScreen.main.bounds.width
    let lowestScreenWidth: CGFloat = 375.0
    
    let category: [Category] = [
        Category(categoryImage: "romantics", name: "Romantic"),
        Category(categoryImage: "fantasies", name: "Fantasy"),
        Category(categoryImage: "dramas", name: "Drama"),
        Category(categoryImage: "comedies", name: "Comedy"),
        Category(categoryImage: "actions", name: "Action"),
    ]
    
    let rank: [Category] = [
        Category(categoryImage: "rank", name: "Peringkat Teratas"),
        Category(categoryImage: "blank", name: "Sedang Trending")
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        configure()
    }
    
    func configure() {
        
        collectionView.register(UINib(nibName: "SearchBarReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "searchCell")
        collectionView.register(UINib(nibName: "SearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "searchCell")
        collectionView.register(UINib(nibName: "NewestHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        var config = UICollectionLayoutListConfiguration(appearance: .sidebar)
        config.headerMode = .supplementary
    }

}

extension SearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return rank.count
        case 1:
            return category.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCollectionViewCell
            let rankCell = rank[indexPath.row]
            cell.searchLabelText.text = rankCell.name
            cell.searchImageView.image = UIImage(named: rankCell.categoryImage)
        return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCollectionViewCell
            let categoriCell = category[indexPath.row]
            cell.searchLabelText.text = categoriCell.name
            cell.searchImageView.image = UIImage(named: categoriCell.categoryImage)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth > lowestScreenWidth ? 172 : 160, height: 72)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 20, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if indexPath.section == 1 {
            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? NewestHeaderReusableView {
            
                    headerView.headerLabel.text = "Kategori Komik"
                headerView.seeAllLabel.isHidden = true
        
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
        if section == 1 {
            return CGSize(width: collectionView.frame.width, height: 20)
        } else if section == 0{
            return CGSize(width: collectionView.frame.width, height: 50)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
}
