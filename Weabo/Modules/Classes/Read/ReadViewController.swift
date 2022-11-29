//
//  ReadViewController.swift
//  Weabo
//
//  Created by yoga arie on 12/11/22.
//

import UIKit
import RealmSwift

class ReadViewController: UIViewController {
    var readComic : [ImageURL]?
    var comicUrl: String!
    var titleComic: String!
    var movePage: Read!
    var realmTitle: String!
    var chapterComic: String!
    var imgView: String!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        containerViewRound()
          nextPageComic()
          loadReadComic()
          setupTable()
          setupTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupColorNavigation()
        save()
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
    
    func nextPageComic(){
        ComicProvider.shared.movePage(comicUrl) { [weak self] (result) in
            switch result{
            case .success(let data):
                self?.movePage = data
                self?.tableView.reloadData()
                
            case .failure(let error):
                break
            }
        }
    }
    
    func save(){
          print(Realm.Configuration.defaultConfiguration.fileURL)
        
          let task = RecentComic()
          task.title = realmTitle
          task.Url = comicUrl
          task.chapter = chapterComic
          task.imgUrl = imgView ?? ""
        
          
          let realm = try! Realm()
          try! realm.write {
              realm.add(task)
          }
      }
    
    func containerViewRound(){
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        containerView.backgroundColor = UIColor(hex: "16171D")
    }
    
    func setupTitle(){
        title = titleComic
        titleComic = ""
        navigationController?.navigationBar.prefersLargeTitles = true
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(self.backButtonTapped(_:)))
        navigationItem.leftBarButtonItem = backButton
    }
    
    func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ReadViewCell", bundle: nil), forCellReuseIdentifier: "read_cell")
    }
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        let chapter = movePage.prevURL.removeCharacters(from: CharacterSet.decimalDigits.inverted)
        let titleComic = titleComic + " Eps." + chapter
        if movePage.prevURL.isEmpty {
            print("test test")
        } else {
            
            presentReadViewController(movePage.prevURL, titleComic, realmTitle, imgView) }
    }
    
    @IBAction func nextPageButtonTapped(_ sender: Any) {
        let chapter = movePage.nextURL.removeCharacters(from: CharacterSet.decimalDigits.inverted)
        let titleComic = titleComic + " Eps." + chapter
        if movePage.nextURL.isEmpty {
            print("test test ")
        } else {
            presentReadViewController(movePage.nextURL, titleComic, realmTitle, imgView) }
    }
    
    
    func loadReadComic() {
        ComicProvider.shared.readComic(comicUrl) { [weak self] (result) in
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
    func presentReadViewController(_ comic: String, _ chapter: String = "Untitled", _ title: String? = nil, _ imgView: String? = nil) {
        let viewController = ReadViewController(nibName: "ReadViewController", bundle: nil)
        viewController.comicUrl = comic
        viewController.titleComic = chapter
        viewController.chapterComic = chapter
        viewController.realmTitle = title
        viewController.imgView = imgView
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}
