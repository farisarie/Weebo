//
//  LoginViewController.swift
//  Weabo
//
//  Created by yoga arie on 02/11/22.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {

    @IBOutlet weak var rightWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftWidthConstraint: NSLayoutConstraint!
  
    @IBOutlet weak var passwordTextField: WeeboTextField!
    @IBOutlet weak var emailTextField: WeeboTextField!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        customTitle()
        emailTextField.textColor = .black
        passwordTextField.textColor = .black
        let screenWidth = UIScreen.main.bounds.width
        let lowestScreenWidth: CGFloat = 375.0
        rightWidthConstraint.constant = screenWidth > lowestScreenWidth ? 154 : 145
        leftWidthConstraint.constant = screenWidth > lowestScreenWidth ? 154 : 145
        
    }
    
    func customTitle(){
        let label = UILabel(frame: .zero)
        label.text = "Masuk Akun"
        label.font = UIFont(name: "ABCGintoNormal-Bold-Trial", size: 20)
        label.textColor = UIColor(hex: "292B2F")
        navigationItem.titleView = label
    }
    
    func isValid() -> Bool {
        
        guard let email = emailTextField.text, email.isValidEmail  else {
                
                self.emailTextField.layer.borderColor = UIColor.red.cgColor
                self.emailTextField.layer.borderWidth = 0.5
                self.emailTextField.layer.cornerRadius = 5
                self.emailTextField.layer.masksToBounds = true
            
            
            return false
        }
        
        guard let name = passwordTextField.text, name.count >= 3 else {
            
            print("Name error")
            self.passwordTextField.layer.borderColor = UIColor.red.cgColor
            self.passwordTextField.layer.borderWidth = 0.5
            self.passwordTextField.layer.cornerRadius = 5
            self.passwordTextField.layer.masksToBounds = true
        
        
            return false
        }

        return true
    }
    
    func navigatePage() {
        navigateToHome()
    }
    
    func showTextInputPrompt(withMessage message: String,
                               completionBlock: @escaping ((Bool, String?) -> Void)) {
        let prompt = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
          completionBlock(false, nil)
        }
        weak var weakPrompt = prompt
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
          guard let text = weakPrompt?.textFields?.first?.text else { return }
          completionBlock(true, text)
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(cancelAction)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil)
      }  //Google Sign In
    
    
    @IBAction func googleButtonTapped(_ sender: Any) {
        loginWithGoogle()
    }
    
    func loginWithGoogle(){
        setupGoogle()
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { (authResult, error) in
            if let error = error {
                // Error. If error.code == .MissingOrInvalidNonce, make sure
                // you're sending the SHA256-hashed nonce as a hex string with
                // your request to Apple.
                print(error.localizedDescription)
                return
            }
            // User is signed in to Firebase with Apple.
            // ...
            print("User is signed in to Firebase with Apple.")
            self.navigatePage()
        }
    }
    
    @IBAction func LoginButtonTapped(_ sender: Any) {
        if isValid() {
            signIn()
        }
        else {
            let error = UIAlertController(title: "Login Error", message: "Your email or password still empty", preferredStyle: .alert)
            error.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(error, animated: true)

            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                self.emailTextField.layer.borderColor = UIColor.clear.cgColor
                self.emailTextField.layer.borderColor = UIColor.clear.cgColor
            }

        }
    }
        
    }


//MARK: - UIViewController
extension UIViewController{
    func showLoginLandingViewController() {
        let viewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        navigationController?.pushViewController(viewController, animated: true)
    }
}


      
