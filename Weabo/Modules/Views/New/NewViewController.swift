//
//  NewViewController.swift
//  Weabo
//
//  Created by yoga arie on 29/11/22.
//

import UIKit

class NewViewController: UIViewController {

    var new: [Datum]?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Komik Terbaru"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "list_cell")
        loadData()
    }
    
    func loadData(){
        ComicProvider.shared.listComic { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.new = data
                self?.tableView.reloadData()
                
            case .failure(let error):
                break
            }
        }
    }
    
    
}

// MARK: - UITableViewDataSource
extension NewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return new?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "list_cell", for: indexPath) as! ListTableViewCell
        let comicApi = new?[indexPath.row]
        cell.category.text = comicApi?.typeComic
        cell.descLabel.text = "Shigeo Kageyama atau lebih akrab disebut mob adalah seorang anak kelas 2 SMP yang mendam-bakan kehidupan yang normal namun..."
        cell.imgView.kf.setImage(with: URL(string: comicApi?.thumbnailURL ?? ""))
        cell.titleComic.text = comicApi?.title
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let data = new?[indexPath.row] {
            presentDetailViewController(nil, data)
        }
    }
}

extension UIViewController {
    func pushNewVC(){
        let vc = NewViewController()
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
