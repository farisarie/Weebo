//
//  HomeViewController.swift
//  Weabo
//
//  Created by yoga arie on 04/10/22.
//`

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    weak var searchController : UISearchController!
    var comic: [Comic]?
    var allComic: [Datum]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        listAllComic()
    }
    
    func setup() {

        collectionView.register(UINib(nibName: "NewestHeaderReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        collectionView.register(UINib(nibName: "SearchBarReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "searchCell")
        collectionView.register(UINib(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "listCell")
        collectionView.dataSource = self
        collectionView.delegate = self
  
        let notifButton = UIBarButtonItem(image: UIImage(named: "bell")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.done, target: self, action: #selector(self.notificationButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem  = notifButton
        
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
    
    func listAllComic(){
        ComicProvider.shared.listComic { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.allComic = data
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
    @objc func notificationButtonTapped(_ sender: Any) {
        presentCategoryPage()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return comic == nil ? 1 : 0
            
        case 1:
            return comic == nil ? 1 : 0
            
        case 2:
            return comic == nil ? 1 : 0
            
        case 3:
            return comic == nil ? 1 : 0
            
        case 4:
            return comic == nil ? allComic?.count ?? 0 : 0
            
        case 5:
            return comic?.count ?? 0
            
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
            cell.seeAllButtonOutlet.addTarget(self, action: #selector(self.notificationButtonTapped(_:)), for: .touchUpInside)
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "adsCell", for: indexPath) as! AdsViewCell
            cell.comicThumbnail.image = UIImage(named: "chainsawman")
            return cell
            
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomCell", for: indexPath) as!
                BottomViewCell
            cell.delegate = self
            cell.titleLabel.text = "Sedang Trending"
            
        return cell
            
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newestCell", for: indexPath) as!
                NewestViewCell
            let all = allComic?[indexPath.row]
            cell.imageView.kf.setImage(with: URL(string: all?.thumbnailURL ?? ""))
            cell.categoryLabel.text = all?.typeComic
            cell.comicTitle.text = all?.title
            cell.accessDateLabel.text = "Shigeo Kageyama atau lebih akrab disebut adalah seorang anak kelas 2 SMP yang mendam-bakan kehidupan yang normal namun..."
            return cell
            
        case 5:
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
            return CGSize(width: self.view.frame.width, height: 115)
            
            
        case 3:
            return CGSize(width: self.view.frame.width, height: 330)
            
        case 4:
            return CGSize(width: self.view.frame.width, height: 108)
            
        case 5:
            return CGSize(width: self.view.frame.width, height: 108)
        default:
            return CGSize()
            
        
    }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: comic == nil ? 8 : 0, left: 24, bottom: comic == nil ? 8 : 0, right: 24)
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
                headerView.headerLabel.text = "Komik Terbaru"
                headerView.headerLabel.isHidden = comic == nil ? false : true
                return headerView
                } 
        
            
        
        default:
            return UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 4 {
            return comic == nil ? CGSize(width: collectionView.frame.width, height: 30) : CGSize(width: 0, height: 0)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
    
}


extension HomeViewController: BottomViewCellDelegate {
    func seeAllButtonTapped(_ cell: BottomViewCell) {
        presentTrendingViewController()
    }
    
    func navigateToDetail(_ cell: BottomViewCell, _ popular: Comic) {
        presentDetailViewController(popular)
    }
    
}

extension HomeViewController: UISearchBarDelegate {
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        comic = nil
        collectionView.reloadData()
    }
}
