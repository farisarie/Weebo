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
            let error = UIAlertController(title: "Login Error", message: "Your email or password still empty", preferredStyle: .alert)
            error.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(error, animated: true)
            
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
                self.emailTextField.layer.borderColor = UIColor.clear.cgColor
                self.emailTextField.layer.borderColor = UIColor.clear.cgColor
            }
            
        }
    }
    
    
    
    func isValid() -> Bool {
        
        
        guard let email = emailTextField.text, email.isValidEmail else {
            presentError(title: "Error", message: "Email is empty or not valid!")
            print("email is not valid")
            return false
        }
        
        guard let password = passwordTextField.text, password.isValidPassword else {
            presentError(title: "Error", message: "Password is empty or not valid!")
            print("password is not valid")
            return false
        }
        
        guard let repeatPassword = repeatPassword.text, repeatPassword == password else{
            presentError(title: "Error", message: "Confirm password is different")
            print("password is not same")
            return false
        }
        
        return true
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { (authResult, error) in
            if let x = error {
                let err = x as NSError
                switch err.code {
                case AuthErrorCode.wrongPassword.rawValue:
                    self.presentError(title: "Wrong Password !", message: "")
                case AuthErrorCode.invalidEmail.rawValue:
                    self.presentError(title: "Invalid Email !", message: "")
                    print("invalid email")
                case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                    print("accountExistsWithDifferentCredential")
                case AuthErrorCode.emailAlreadyInUse.rawValue: //<- Your Error
                    self.presentError(title: "Email Already In Use !", message: "")
                default:
                    print("unknown error: \(err.localizedDescription)")
                }
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

