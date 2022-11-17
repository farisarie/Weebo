//
//  StringExtensions.swift
//  Siniar
//
//  Created by yoga arie on 10/05/22.
//

import Foundation
import UIKit

extension String {
    var isValidEmail: Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let regEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }
    
    var isValidPhone: Bool {
        let regEx = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: self)
    }
}

extension String {
    func date(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: self)
    }
}

extension String {
     var convertHtmlToNSAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data,options: [.documentType: NSAttributedString.DocumentType.html,.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }

     func convertHtmlToAttributedStringWithCSS(font: UIFont? , csscolor: String , lineheight: Int, csstextalign: String) -> NSAttributedString? {
        guard let font = font else {
            return convertHtmlToNSAttributedString
        }
        let modifiedString = "<style>body{font-family: '-apple-system'; font-size:\(font.pointSize)px; color: \(csscolor); line-height: \(lineheight)px; text-align: \(csstextalign); }</style>\(self)";
        guard let data = modifiedString.data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print(error)
            return nil
        }
    }
}
