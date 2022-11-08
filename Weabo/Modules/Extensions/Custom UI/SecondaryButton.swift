//
//  SecondaryButton.swift
//  Siniar
//
//  Created by yoga arie on 10/05/22.
//

import Foundation
import UIKit

class SecondaryButton: UIButton {
    private weak var underlineView: UIView!
    
    convenience init() {
        self.init(type: .system)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        tintColor = UIColor(hex: "5865F2")
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 5, right: 5)
        layer.cornerRadius = 4
        layer.masksToBounds = true
        
        let underlineView = UIView(frame: .zero)
        addSubview(underlineView)
        self.underlineView = underlineView
        underlineView.backgroundColor = .purple
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underlineView.heightAnchor.constraint(equalToConstant: 1),
            underlineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            underlineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            underlineView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
}
