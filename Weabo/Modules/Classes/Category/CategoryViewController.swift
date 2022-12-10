//
//  CategoryViewController.swift
//  Weabo
//
//  Created by yoga arie on 07/11/22.
//

import UIKit
import Kingfisher

class CategoryViewController: UIViewController {

    var new: [Comic]?
    var manga: [Comic]?
    var manhwa: [Comic]?
    @IBOutlet weak var segmentedControl: UISegmentView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Category"
        self.segmentedControl.frame = CGRect(
            x: self.segmentedControl.frame.minX,
            y: self.segmentedControl.frame.minY,
            width: segmentedControl.frame.width,
            height: 60)
        segmentedControl.highlightSelectedSegment()
    

        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "category_comic")
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
       
    }
    
    @IBAction func segmentSelected(_ sender: Any) {
        let index = segmentedControl.selectedSegmentIndex
        if index == 1 {
            self.mangaMap()
        } else {
            self.manhwaMap()
        }
    }
    
    func loadData(){
        ComicProvider.shared.popularComic { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.new = data
                self?.tableView.reloadData()
                self?.mangaMap()
                self?.manhwaMap()
            case .failure(let error):
                break
            }
        }
    }
    
    func mangaMap(){
        manga = new?.filter { $0.typeComic == "Manga" }
        tableView.reloadData()
    }
    
    func manhwaMap(){
        manhwa = new?.filter { $0.typeComic == "Manhwa" || $0.typeComic == "Manhua" }
        tableView.reloadData()
    }
    
    @IBAction func scrollViewDidChange(_ sender: Any) {
        segmentedControl.underlinePosition()
    }

}

extension CategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedIndex = self.segmentedControl.selectedSegmentIndex
           switch selectedIndex
           {
           case 0:
               return manga?.count ?? 0
           case 1:
               return manhwa?.count ?? 0
   
           default:
               return 0
           }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectedIndex = self.segmentedControl.selectedSegmentIndex
        switch selectedIndex {
            case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "category_comic", for: indexPath) as! CategoryTableViewCell
            
            let allComic = manga?[indexPath.row]
            cell.titleComic.text = allComic?.title
            cell.descComic.text = "Bercerita seputar kehidupan tokoh utamanya, Naruto Uzumaki, seorang ninja yang hiper..."
            cell.imgView.kf.setImage(with: URL(string: allComic?.thumbnailURL ?? ""))
            cell.categoryComic.text = allComic?.typeComic
            cell.totalLikesComic.text = allComic?.rating
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "category_comic", for: indexPath) as! CategoryTableViewCell
            
            let allComic = manhwa?[indexPath.row]
            cell.titleComic.text = allComic?.title
            cell.descComic.text = "Bercerita seputar kehidupan tokoh utamanya, Naruto Uzumaki, seorang ninja yang hiper..."
            cell.imgView.kf.setImage(with: URL(string: allComic?.thumbnailURL ?? ""))
            cell.categoryComic.text = allComic?.typeComic
            cell.totalLikesComic.text = allComic?.rating
            
            return cell
            
        default:
                return UITableViewCell()
        }
    }
    
    
}

extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 113
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = UIColor(hex: "#292B2F")
         let selectedIndex = self.segmentedControl.selectedSegmentIndex
        switch selectedIndex {
        case 0 :
            if let allComic = manga {
                label.text = "\(allComic.count) Komik"
            }
        case 1 :
            if let allComic = manhwa {
                label.text = "\(allComic.count) Komik"
            }
        default:
            break
        }
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "chevi")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        button.setTitle("Berdasarkan Favorit", for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.tintColor = UIColor(hex: "828282")
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        return view
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       
    return 30
    }
}

extension UIViewController{
    func presentCategoryPage() {
        let viewController = CategoryViewController(nibName: "CategoryViewController", bundle: nil)
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}


