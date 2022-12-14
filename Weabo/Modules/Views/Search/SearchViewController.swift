//
//  SearchViewController.swift
//  Weabo
//
//  Created by yoga arie on 18/10/22.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {

    weak var searchController : UISearchController!
    
    let screenWidth = UIScreen.main.bounds.width
    let lowestScreenWidth: CGFloat = 375.0
    var comic: [Comic]?
    
    let category: [Category] = [
        Category(categoryImage: "romantics", name: "Romantic"),
        Category(categoryImage: "fantasies", name: "Fantasy"),
        Category(categoryImage: "dramas", name: "Drama"),
        Category(categoryImage: "comedies", name: "Comedy"),
        Category(categoryImage: "actions", name: "Action"),
    ]
    
    var rank: [Category] = [
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func configure() {
        
        collectionView.register(UINib(nibName: "SearchBarReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "searchCell")
        collectionView.register(UINib(nibName: "SearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "searchCell")
        collectionView.register(UINib(nibName: "NewestHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        collectionView.register(UINib(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "listCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .black
        searchController.searchBar.barStyle = .black
        searchController.searchBar.textField?.textColor = .yellow
        navigationItem.searchController = searchController
        
        self.searchController = searchController
        searchController.searchBar.delegate = self
        
        
    }
    
    func loadSearch(_ term: String) {
        ComicProvider.shared.searchComic(term) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.comic = data
                self!.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension SearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return comic == nil ? rank.count : 0
        case 1:
            return comic == nil ? category.count : 0
        case 2:
            return comic?.count ?? 0
            
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
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as! ListCollectionViewCell
            let list = comic?[indexPath.row]
            cell.thumbnailImage.kf.setImage(with: URL(string: list?.thumbnailURL ?? ""))
            cell.typeComic.text = list?.typeComic
            cell.descComic.text = list?.chapter
            cell.titleComic.text = list?.title
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
            
        case 0:
            return CGSize(width: screenWidth > lowestScreenWidth ? 172 : 160, height: 72)
        case 1:
            return CGSize(width: screenWidth > lowestScreenWidth ? 172 : 160, height: 72)
        case 2:
            return CGSize(width: self.view.frame.width, height: 108)
        default:
            break
        }
        
        return CGSize(width: 0, height: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: comic == nil ? 15 : 0, left: 15, bottom: comic == nil ? 20 : 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return comic == nil ? CGSize(width: collectionView.frame.width, height: 20) : CGSize(width: 0, height: 0)
        } else if section == 0{
            return CGSize(width: collectionView.frame.width, height: 50)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:

            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? NewestHeaderReusableView {
                
                headerView.headerLabel.text = "Kategori Komik"
                headerView.headerLabel.isHidden = comic == nil ? false : true
                headerView.seeAllLabel.isHidden = true
                
                
                return headerView
                }

        default:
            return UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
    
    

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadSearch(searchBar.text ?? "")

    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let string = NSString(string: searchBar.text ?? "").replacingCharacters(in: range, with: text)
        if string.count >= 3{
            loadSearch(string)
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let comics = comic?[indexPath.row] {
            presentDetailViewController(comics)
            
        }
    }
}


