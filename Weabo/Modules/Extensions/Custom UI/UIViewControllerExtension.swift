//
//  UIViewControllerExtension.swift
//  FoodDelivery
//
//  Created by yoga arie on 21/06/22.
//

import Foundation
import UIKit

extension UIViewController{
    @IBAction func backButtonTapped(_ sender: Any){
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    @IBAction func closeButtonTapped(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Alert
extension UIViewController{
    public func presentAlert(title: String?, message: String?, actionTitle: String? = nil, handler: (() -> Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            handler?()
        }))
        
        alert.addAction(UIAlertAction(title: actionTitle ?? "OK", style: .destructive, handler: { _ in
            handler?()
        }))
        
       
        
        present(alert, animated: true, completion: nil)
    }
}
