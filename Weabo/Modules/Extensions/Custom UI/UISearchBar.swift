//
//  UISearchBar.swift
//  Weabo
//
//  Created by yoga arie on 10/11/22.
//

import Foundation
import UIKit


extension UISearchBar {

    var textField: UITextField? {
        let subViews = subviews.flatMap { $0.subviews }
        return (subViews.filter { $0 is UITextField }).first as? UITextField
    }
}
