//
//  ReadViewController.swift
//  Weabo
//
//  Created by yoga arie on 12/11/22.
//

import UIKit

class ReadViewController: UIViewController {
    var readComic : [ImageURL]?
    var comicUrl: String!
    var titleComic: String!
    @IBOutlet weak var containerView: UIView!
    var movePage: Read!

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        containerViewRound()
        nextPageComic()
        loadReadComic()
        setupTable()
        self.setNeedsStatusBarAppearanceUpdate()
        setupTitle()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           setNeedsStatusBarAppearanceUpdate()
        setupColorNavigation()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent //.default for black style
    }
    
    
    func containerViewRound(){
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
    }
    
    func setupTable(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ReadViewCell", bundle: nil), forCellReuseIdentifier: "read_cell")
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
    
    func setupTitle(){
        title = titleComic
        titleComic = ""
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        let chapter = movePage.prevURL.removeCharacters(from: CharacterSet.decimalDigits.inverted)
        let titleComic = titleComic + " Eps." + chapter
        if movePage.prevURL.isEmpty {
            print("damn my love life like a shit")
        } else {
          
         presentReadViewController(movePage.prevURL, titleComic) }
    
    }
    
    @IBAction func nextPageButtonTapped(_ sender: Any) {
        let chapter = movePage.nextURL.removeCharacters(from: CharacterSet.decimalDigits.inverted)
        let titleComic = titleComic + " Eps." + chapter
        if movePage.nextURL.isEmpty {
            print("damn my love life like a shit")
        } else {
            presentReadViewController(movePage.nextURL, titleComic) }
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
    func presentReadViewController(_ comic: String, _ title: String = "Untitled") {
        let viewController = ReadViewController(nibName: "ReadViewController", bundle: nil)
        viewController.comicUrl = comic
        viewController.titleComic = title
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}
