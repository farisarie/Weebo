//
//  CategoryViewController.swift
//  Weabo
//
//  Created by yoga arie on 07/11/22.
//

import UIKit

class CategoryViewController: UIViewController {

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
    }
    @IBAction func scrollViewDidChange(_ sender: Any) {
        segmentedControl.underlinePosition()
    }

}

extension CategoryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "category_comic", for: indexPath) as! CategoryTableViewCell
        cell.titleComic.text = "Chainsawman"
        cell.descComic.text = "Bercerita seputar kehidupan tokoh utamanya, Naruto Uzumaki, seorang ninja yang hiper..."
        
        cell.categoryComic.text = "Action"
        cell.totalLikesComic.text = "200"
        
        return cell
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
        label.text = "10 Komik"
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
        navigationController?.pushViewController(viewController, animated: true)
    }
}
