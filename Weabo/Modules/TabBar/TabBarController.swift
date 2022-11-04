//
//  TabBarController.swift
//  Weabo
//
//  Created by yoga arie on 04/10/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setup()
    }
    
    func setup(){
        tabBar.tintColor = UIColor(hex: "5F33BA")
        tabBar.unselectedItemTintColor = UIColor(hex: "828282")
    }

}

extension UIViewController{
    func navigateToHome() {
    let storyboard = UIStoryboard(name: "Tabbar", bundle: nil) //Akses story board
    let viewController = storyboard.instantiateViewController(withIdentifier: "Tabbar") //akses viewcontroller
  
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        window?.rootViewController = viewController
    }
}
