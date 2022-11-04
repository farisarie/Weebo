//
//  OnBoardingViewController.swift
//  Weabo
//
//  Created by yoga arie on 04/11/22.
//

import UIKit

class OnBoardingViewController: UIViewController {

    @IBOutlet weak var topImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomButtonConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weabo"
        let screenWidth = UIScreen.main.bounds.width
        let lowestScreenWidth: CGFloat = 375.0
        bottomButtonConstraint.constant = screenWidth > lowestScreenWidth ? 108 : 59
        topImageConstraint.constant = screenWidth > lowestScreenWidth ? 40 : 20
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        showLoginLandingViewController() // Hehe
    }
    @IBAction func loginPageButtonTapped(_ sender: Any) {
        showLoginLandingViewController()
    }
}
