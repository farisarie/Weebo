//
//  TrendingViewController.swift
//  Weabo
//
//  Created by yoga arie on 18/11/22.
//

import UIKit
import Kingfisher

class TrendingViewController: UIViewController {

    var popular: [Comic]?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sedang Trending"
        setupViews()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "list_cell")
        popularComic()
    }
    
    func setupViews(){
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(self.backButtonTapped(_:)))
        navigationItem.leftBarButtonItem = backButton
    }
    
    func popularComic(){
        ComicProvider.shared.popularComic { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.popular = data
                self?.tableView.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    

}

extension TrendingViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popular?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "list_cell", for: indexPath) as! ListTableViewCell
        let comicApi = popular?[indexPath.row]
        cell.category.text = comicApi?.typeComic
        cell.descLabel.text = "Shigeo Kageyama atau lebih akrab disebut mob adalah seorang anak kelas 2 SMP yang mendam-bakan kehidupan yang normal namun..."
        cell.imgView.kf.setImage(with: URL(string: comicApi?.thumbnailURL ?? ""))
        cell.titleComic.text = comicApi?.title
        return cell
    }
}

extension UIViewController {
    func presentTrendingViewController() {
        let vc = TrendingViewController()
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
