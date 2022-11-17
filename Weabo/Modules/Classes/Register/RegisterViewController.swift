//
//  RegisterViewController.swift
//  Weabo
//
//  Created by yoga arie on 04/11/22.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var repeatPassword: WeeboTextField!
    @IBOutlet weak var passwordTextField: WeeboTextField!
    @IBOutlet weak var emailTextField: WeeboTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Daftar Akun"
        passwordTextField.textColor = .black
        emailTextField.textColor = .black
        repeatPassword.textColor = .black
    }
    @IBAction func registerButton(_ sender: Any) {
        if isValid() {
            signUp()
        }
        else {
            
        }
    }
    
    
    
    func isValid() -> Bool {
        
        
        guard let email = emailTextField.text, email.isValidEmail else {
            print("email is not valid")
            return false
        }
        
        guard let password = passwordTextField.text, password.isValidPassword else {
            print("password is not valid")
            return false
        }
        
        guard let repeatPassword = repeatPassword.text, repeatPassword == password else{
            print("password is not same")
            return false
        }
        
        return true
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { (authResult, error) in
            if let error = error {
                // Error. If error.code == .MissingOrInvalidNonce, make sure
                // you're sending the SHA256-hashed nonce as a hex string with
                // your request to Apple.
                print(error.localizedDescription)
                return
            }
            // User is signed in to Firebase with Apple.
            // ...
            let request = authResult?.user.createProfileChangeRequest()
            request?.displayName = self.emailTextField.text ?? ""
            request?.commitChanges(completion: { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                self.showLoginLandingViewController()
            })
        }
    }
    
}


//MARK: - UIViewController
extension UIViewController{
    func showRegisterViewController() {
        let viewController = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
      
