//
//  UISegmentView.swift
//  Weabo
//
//  Created by yoga arie on 06/11/22.
//

import UIKit

let screenWidth = UIScreen.main.bounds.width
let lowestScreenWidth: CGFloat = 375.0

class UISegmentView: UISegmentedControl {

  
}

// MARK: - UIImage
extension UIImage{
    class func getSegRect(color: CGColor, andSize size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        context?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}

extension UISegmentedControl {
    func removeBorder(){
        let background = UIImage.getSegRect(color: UIColor.clear.cgColor, andSize: self.bounds.size)
        
        self.setBackgroundImage(background, for: .normal, barMetrics: .default)
        self.setBackgroundImage(background, for: .selected, barMetrics: .default)
        self.setBackgroundImage(background, for: .highlighted, barMetrics: .default)
        
        let deviderLine = UIImage.getSegRect(color: UIColor.clear.cgColor, andSize: CGSize(width: 1.0, height: 5))
        
        self.setDividerImage(deviderLine, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor(hex: "4F5660")], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor(hex: "5865F2")], for: .selected)
    }
    
    func highlightSelectedSegment(){
        removeBorder()
        let lineWidth : CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let lineHeight: CGFloat = 7.0
        let lineXPosition = CGFloat(selectedSegmentIndex * Int(lineWidth))
        let lineYPosition = self.bounds.size.height - 6.0
        let underLineFrame = CGRect(x: lineXPosition, y: lineYPosition, width: screenWidth > lowestScreenWidth ? lineWidth : lineWidth - 10, height: lineHeight)
        let underLine = UIView(frame: underLineFrame)
        underLine.backgroundColor = UIColor(hex: "5865F2")
        underLine.tag = 1
        self.addSubview(underLine)
    }
    
    func underlinePosition(){
        guard let underLine = self.viewWithTag(1) else {
            return
        }
        
        let xPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseInOut) {
            underLine.frame.origin.x = xPosition
        }
    }
    
}
