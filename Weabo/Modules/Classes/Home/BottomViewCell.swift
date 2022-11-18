//
//  BottomViewCell.swift
//  Weabo
//
//  Created by yoga arie on 05/10/22.
//

import UIKit
import Kingfisher

protocol BottomViewCellDelegate: AnyObject {
    func navigateToDetail(_ cell: BottomViewCell, _ popular: Comic)
    func seeAllButtonTapped(_ cell: BottomViewCell)
}



class BottomViewCell: UICollectionViewCell {
    var popular: [Comic]?
    weak var delegate: BottomViewCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        let nibCell = UINib(nibName: "ThirdViewCell", bundle: nil)
        popularComic()
        self.bottomCollectionView.register(nibCell, forCellWithReuseIdentifier: "ThirdCell")
        self.bottomCollectionView.dataSource = self
        self.bottomCollectionView.delegate = self
       popularComic()
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
    
    @IBAction func seeAllButtonTapped(_ sender: Any) {
        delegate?.seeAllButtonTapped(self)
    }
}

extension BottomViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return popular?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdCell", for: indexPath) as! ThirdViewCell
        let comicApi = popular?[indexPath.row]
        cell.titleLabel.text = comicApi?.title
        cell.categoryLabel.text = comicApi?.typeComic
        cell.comicImage.kf.setImage(with: URL(string: comicApi?.thumbnailURL ?? ""))
            return cell
            
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

extension BottomViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let popular = popular?[indexPath.row] {
                  bottomCollectionView.reloadData()
                  delegate?.navigateToDetail(self, popular)
        }
    
    }
}
