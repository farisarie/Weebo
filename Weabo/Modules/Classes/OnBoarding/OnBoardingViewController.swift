//
//  OnBoardingViewController.swift
//  Weabo
//
//  Created by yoga arie on 04/11/22.
//

import UIKit

class OnBoardingViewController: UIViewController {

    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var registerButtonOutlet: UIButton!
    @IBOutlet weak var topImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var coverImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTitle()
        coverImageSetup()
        setupButton()
      
    }
    
    func coverImageSetup(){
        coverImage.layer.cornerRadius = 4
        coverImage.layer.masksToBounds = true
    }
    
    func customTitle(){
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
    
    func setupButton(){
        registerButtonOutlet.layer.cornerRadius = 4
        registerButtonOutlet.layer.masksToBounds = true
        loginButtonOutlet.layer.cornerRadius = 4
        loginButtonOutlet.layer.masksToBounds = true
    }
    
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        showRegisterViewController() 
    }
    @IBAction func loginPageButtonTapped(_ sender: Any) {
        showLoginLandingViewController()
    }
}

extension UIViewController{
    func navigateToBoarding() {
   
    let viewController = OnBoardingViewController(nibName: "OnBoardingViewController", bundle: nil)
        let window = UIApplication.shared.windows.first
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        
    }}

