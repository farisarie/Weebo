//
//  BottomViewCell.swift
//  Weabo
//
//  Created by yoga arie on 05/10/22.
//

import UIKit
import Kingfisher

class BottomViewCell: UICollectionViewCell {
    var comic: [Datum]?
    var popular: [Comic]?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    override func awakeFromNib() {
        let nibCell = UINib(nibName: "ThirdViewCell", bundle: nil)
        self.bottomCollectionView.register(nibCell, forCellWithReuseIdentifier: "ThirdCell")
        self.bottomCollectionView.dataSource = self
        self.bottomCollectionView.delegate = self
        loadAllComic()
    }
    
    func popularComic(){
        ComicProvider.shared.popularComic { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.popular = data
                self?.bottomCollectionView.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadAllComic(){
        ComicProvider.shared.listComic { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.comic = data
                self?.bottomCollectionView.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension BottomViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return comic?.count ?? 2
        case 1:
            return popular?.count ?? 2
        default:
           return 5
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdCell", for: indexPath) as! ThirdViewCell
        switch indexPath.section {
        case 0:
          
            let comicApi = comic?[indexPath.item]
            cell.titleLabel.text = comicApi?.title
            cell.categoryLabel.text = "Category"
            cell.comicImage.kf.setImage(with: URL(string: comicApi?.thumbnailURL ?? ""))
            return cell
            
        case 1:
            let comicsApi = popular?[indexPath.item]
            cell.titleLabel.text = comicsApi?.title
            cell.categoryLabel.text = comicsApi?.typeComic
            cell.comicImage.kf.setImage(with: URL(string: comicsApi?.thumbnailURL ?? ""))
            return cell
            
        default:
            return UICollectionViewCell()
        }
       return  UICollectionViewCell()
        
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
