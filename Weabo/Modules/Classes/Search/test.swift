////
////  test.swift
////  Weabo
////
////  Created by yoga arie on 10/11/22.
////
//
//import Foundation
//import UIKit
//
//class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
//
//    lazy var collectionView : UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.backgroundColor = .white
//        cv.dataSource = self
//        cv.delegate = self
//        return cv
//    }()
//
//    var films = [["title" : "one"], ["title" : "two"], ["title" : "three"]]
//    var filteredFilms = [Dictionary<String, String>]()
//
//    let searchBar = UISearchBar()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.view.addSubview(searchBar)
//        searchBar.translatesAutoresizingMaskIntoConstraints = false
//        searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
//        searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
//        searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//
//        self.view.addSubview(collectionView)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//
//        collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
//
//        self.searchBar.delegate = self
//        self.filteredFilms = films
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return filteredFilms.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 100)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText == "" {
//            self.filteredFilms = films
//            self.collectionView.reloadData()
//        } else {
//            self.filteredFilms = films.filter({($0["title"]?.contains(searchText.lowercased()))!})
//            print(self.filteredFilms.count)
//            self.collectionView.reloadData()
//        }
//    }
//
//}
//
//class Cell : UICollectionViewCell {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//
//    func setupViews() {
//        self.backgroundColor = .red
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}


// MARK: - For Header

//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        switch kind {
//        case UICollectionView.elementKindSectionHeader:
//            if indexPath.section == 1 {
//            if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? NewestHeaderReusableView {
//
//                    headerView.headerLabel.text = "Kategori Komik"
//                headerView.seeAllLabel.isHidden = true
//
//                return headerView
//                }
//            } else if indexPath.section == 0 {
//                if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "searchCell", for: indexPath) as? SearchBarReusableView
//                {
//                    headerView.searchBar.delegate = self
//                    return headerView
//            }
//        }
//        default:
//            return UICollectionReusableView()
//        }
//        return UICollectionReusableView()
//    }
