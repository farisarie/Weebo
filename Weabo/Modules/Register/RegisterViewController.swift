//
//  RegisterViewController.swift
//  Weabo
//
//  Created by yoga arie on 04/11/22.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Daftar Akun"
    }

}

//MARK: - UIViewController
extension UIViewController{
    func showRegisterViewController() {
        let viewController = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
      
