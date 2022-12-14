//
//  ProfileViewController.swift
//  Weabo
//
//  Created by yoga arie on 02/11/22.
//
import Firebase
import UIKit
import FirebaseAuth
import GoogleSignIn
import Kingfisher

class ProfileViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var xStackView: UIStackView!
    let currentUser = Auth.auth().currentUser
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        retrieveUserData()
        
    }

    func retrieveUserData() {
        profileImage.layer.cornerRadius = 104/2
        profileImage.layer.masksToBounds = true
        if let user = currentUser {
            emailLabel.text = user.email
            nameLabel.text = user.displayName
            profileImage.kf.setImage(with: user.photoURL)
        }
        
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
            showAlert()
            
        }
        
        func showAlert() {
            
            let alert = UIAlertController(title: "Log Out", message: "Are you Sure You want to Logout", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { action in
                GIDSignIn.sharedInstance.signOut()
                try! Auth.auth().signOut()
                self.navigateToBoarding()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:nil))
            self.present(alert, animated: true, completion: nil)
            }
        
    
}


extension UIViewController {
    func showProfileController() {
        let viewController = ProfileViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
