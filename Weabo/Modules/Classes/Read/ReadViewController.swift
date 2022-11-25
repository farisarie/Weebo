//
//  ReadViewController.swift
//  Weabo
//
//  Created by yoga arie on 12/11/22.
//

import UIKit

class ReadViewController: UIViewController {
    var readComic : [ImageURL]?
    var comicUrl: ChapterList!
    var titleComic: Comic!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleComic.title
        loadReadComic()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupColorNavigation()
    }
    
    func setupColorNavigation(){
        view.backgroundColor = UIColor(hex: "16171D")
        navigationController?.navigationBar.barTintColor = UIColor(hex: "16171D")
        navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        tableView.backgroundColor = .clear
    }
    
    func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ReadViewCell", bundle: nil), forCellReuseIdentifier: "read_cell")
    }
    
    func loadReadComic() {
        ComicProvider.shared.readComic(comicUrl.chapterURL) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.readComic = data
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
        
}

extension ReadViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readComic?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "read_cell", for: indexPath) as! ReadViewCell
        let loadImage = readComic?[indexPath.row]
        cell.imgView.kf.setImage(with: URL(string: loadImage?.imageURL ?? ""))
        return cell
    }
    
}

extension ReadViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension UIViewController{
    func presentReadViewController(_ comic: ChapterList, _ title: Comic) {
        let viewController = ReadViewController(nibName: "ReadViewController", bundle: nil)
        viewController.comicUrl = comic
        viewController.titleComic = title
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}
