//
//  DetailViewController.swift
//  Weabo
//
//  Created by yoga arie on 11/11/22.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var comic: Comic!
    var allComic: Datum!
    var detailComic: [ChapterList]?
    var detailDescribe: DetailClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetailComic()
        setupViews()
        detailData()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ComicDetailViewCell", bundle: nil), forCellReuseIdentifier: "cell_detail")
        tableView.register(UINib(nibName: "EpisodeViewCell", bundle: nil), forCellReuseIdentifier: "episodeCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavColor()
    }
    
    func detailData(){
        if comic != nil {
            title = comic.title
        } else if allComic != nil {
            title = allComic.title
        }
    }
    
    func setupNavColor(){
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func setupViews(){
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(self.backButtonTapped(_:)))
        navigationItem.leftBarButtonItem = backButton
    }
    
    func loadDetailComic() {
        if comic != nil {
            ComicProvider.shared.detailDescribe(comic.comicURL) { [weak self] (result) in
                switch result {
                case .success(let data):
                    self?.detailDescribe = data
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            ComicProvider.shared.detailChapterList(comic.comicURL) { [weak self] (result) in
                switch result {
                case .success(let data):
                    self?.detailComic = data
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else if allComic != nil {
            
            ComicProvider.shared.detailDescribe(allComic.comicURL) { [weak self] (result) in
                switch result {
                case .success(let data):
                    self?.detailDescribe = data
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            ComicProvider.shared.detailChapterList(allComic.comicURL) { [weak self] (result) in
                switch result {
                case .success(let data):
                    self?.detailComic = data
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    
}

extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return detailComic?.count ?? 0
            
        default:
            break
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell_detail", for: indexPath) as! ComicDetailViewCell
            if comic != nil {
                cell.comicImageView.kf.setImage(with: URL(string: comic.thumbnailURL))
            } else if allComic != nil {
                cell.comicImageView.kf.setImage(with: URL(string: allComic.thumbnailURL))
            }
            cell.titleLabel.text = detailDescribe?.title
            cell.descLabel.text = detailDescribe?.dataDescription
            cell.ratingLabel.text = detailDescribe?.rating
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as!
            EpisodeViewCell
            
            let episode = detailComic?[indexPath.row]
            let chapter = episode?.chapterNum.removeCharacters(from: CharacterSet.decimalDigits.inverted)
            if comic != nil {
                cell.thumbnailComic.kf.setImage(with: URL(string: comic.thumbnailURL))
                cell.titleLabel.text = comic.title
            } else if allComic != nil {
                cell.thumbnailComic.kf.setImage(with: URL(string: allComic.thumbnailURL))
                cell.titleLabel.text = allComic.title
            }
          
          
            
            cell.chapterLabel.text = "#\(chapter ?? "")"
            cell.dateLabel.text = episode?.chapterDate
            return cell
            
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            tableView.deselectRow(at: indexPath, animated: true)
            
        case 1:
            if let detailComics = detailComic?[indexPath.row] {
                let eps = detailComics.chapterURL.removeCharacters(from: CharacterSet.decimalDigits.inverted)
                if comic != nil {
                    presentReadViewController(detailComics.chapterURL, " Eps. " + eps, comic.title, comic.thumbnailURL)
                } else if allComic != nil {
                    presentReadViewController(detailComics.chapterURL, " Eps. " + eps, allComic.title, allComic.thumbnailURL)
                }
            
            }
        default:
            break
        }
       
    }
}


extension UIViewController{
    func presentDetailViewController(_ comic: Comic? = nil, _ url: Datum? = nil) {
        let viewController = DetailViewController(nibName: "DetailViewController", bundle: nil)
        viewController.comic = comic
        viewController.allComic = url
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension String {

    func removeCharacters(from forbiddenChars: CharacterSet) -> String {
        let passed = self.unicodeScalars.filter { !forbiddenChars.contains($0) }
        return String(String.UnicodeScalarView(passed))
    }

    func removeCharacters(from: String) -> String {
        return removeCharacters(from: CharacterSet(charactersIn: from))
    }
}
