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
    var detailComic: [ChapterList]?
    var detailDescribe: DetailClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetailComic()
        title = comic.title
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ComicDetailViewCell", bundle: nil), forCellReuseIdentifier: "cell_detail")
        tableView.register(UINib(nibName: "EpisodeViewCell", bundle: nil), forCellReuseIdentifier: "episodeCell")
    }
    func loadDetailComic() {
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
            cell.comicImageView.kf.setImage(with: URL(string: comic.thumbnailURL))
            cell.titleLabel.text = detailDescribe?.title
            cell.descLabel.text = detailDescribe?.dataDescription
            cell.ratingLabel.text = detailDescribe?.rating
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as!
            EpisodeViewCell
            
            let episode = detailComic?[indexPath.row]
            let chapter = episode?.chapterNum.removeCharacters(from: CharacterSet.decimalDigits.inverted)
            
            cell.thumbnailComic.kf.setImage(with: URL(string: comic.thumbnailURL))
            cell.titleLabel.text = comic.title
            
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
        if let detailComics = detailComic?[indexPath.row] {
            presentReadViewController(detailComics, comic)
            
        }
    }
}


extension UIViewController{
    func presentDetailViewController(_ comic: Comic) {
        let viewController = DetailViewController(nibName: "DetailViewController", bundle: nil)
        viewController.comic = comic
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
