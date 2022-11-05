//
//  LoginViewController.swift
//  Weabo
//
//  Created by yoga arie on 02/11/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var rightWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Masuk Akun"
        let screenWidth = UIScreen.main.bounds.width
        let lowestScreenWidth: CGFloat = 375.0
        rightWidthConstraint.constant = screenWidth > lowestScreenWidth ? 154 : 145
        leftWidthConstraint.constant = screenWidth > lowestScreenWidth ? 154 : 145
        
    }
    
    func isValid() -> Bool {
        

        guard let email = emailTextField.text, email.isValidEmail  else {
           
                self.emailTextField.layer.borderColor = UIColor.red.cgColor
                self.emailTextField.layer.borderWidth = 0.5
                self.emailTextField.layer.cornerRadius = 5
                self.emailTextField.layer.masksToBounds = true
            
            
            return false
        }
        
        guard let name = nameTextField.text, name.count >= 3 else {
            
            print("Name error")
            self.nameTextField.layer.borderColor = UIColor.red.cgColor
            self.nameTextField.layer.borderWidth = 0.5
            self.nameTextField.layer.cornerRadius = 5
            self.nameTextField.layer.masksToBounds = true
        
        
            return false
        }

        return true
    }
    
    func navigatePage() {
        navigateToHome()
    }
    
    
    @IBAction func LoginButtonTapped(_ sender: Any) {
        if isValid() {
            navigatePage()
        }
        else {
            let error = UIAlertController(title: "Login Error", message: "Your email or password still empty", preferredStyle: .alert)
            error.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(error, animated: true)
            
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                self.nameTextField.layer.borderColor = UIColor.clear.cgColor
                self.emailTextField.layer.borderColor = UIColor.clear.cgColor
            }
            
        }
      
    }
    
}


extension String {
    var isValidEmail: Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }
    
}

//MARK: - UIViewController
extension UIViewController{
    func showLoginLandingViewController() {
        let viewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
      