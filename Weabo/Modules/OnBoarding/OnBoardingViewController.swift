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
        let label = UILabel(frame: .zero)
        label.text = "Weebo"
        label.font = UIFont(name: "ExpletusSans-Bold", size: 21)
        label.textColor = UIColor(hex: "5865F2")
        navigationItem.titleView = label
        let screenWidth = UIScreen.main.bounds.width
        let lowestScreenWidth: CGFloat = 375.0
        bottomButtonConstraint.constant = screenWidth > lowestScreenWidth ? 108 : 59
        topImageConstraint.constant = screenWidth > lowestScreenWidth ? 40 : 20
    }
    
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        showRegisterViewController() 
    }
    @IBAction func loginPageButtonTapped(_ sender: Any) {
        showLoginLandingViewController()
    }
}

