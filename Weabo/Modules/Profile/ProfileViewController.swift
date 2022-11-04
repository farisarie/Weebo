//
//  ProfileViewController.swift
//  Weabo
//
//  Created by yoga arie on 02/11/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileCollectionView: UICollectionView! //nanti didelete
    @IBOutlet weak var xStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"

        
    }


}

extension UIViewController {
    func showProfileController() {
        let viewController = ProfileViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
