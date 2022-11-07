//
//  WeeboTextField.swift
//  Weabo
//
//  Created by yoga arie on 07/11/22.
//

import UIKit

class WeeboTextField: UITextField {
    @IBInspectable var padding: CGFloat = 0
    @IBInspectable var color: UIColor = UIColor.lightGray { didSet { setup() }}
    enum InputType: Int {
            case undefined = 0
            case email = 1
            case password = 2
        }
    
        private weak var underlineView: UIView!
        private weak var secureButton: UIButton?
        private var inputType: InputType = .undefined
        @IBInspectable var inputTypeId: Int = 0 {
            didSet {
                inputType = InputType(rawValue: inputTypeId) ?? .undefined
                setup()
            }
        }
    
        convenience init(inputType: InputType) {
            self.init(frame: .zero)
            self.inputType = inputType
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
    
        override func awakeFromNib() {
            super.awakeFromNib()
            setup()
        }
    
        override func prepareForInterfaceBuilder() {
            super.prepareForInterfaceBuilder()
            setup()
        }
    
        override var isSelected: Bool {
            didSet {
                update()
            }
        }
    
        override var text: String? {
            didSet {
                update()
            }
        }
    
        override var placeholder: String? {
            didSet {
                update()
            }
        }
    
        override var isSecureTextEntry: Bool {
            didSet {
                update()
            }
        }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= padding
        return textRect
    }
    
        func setup() {
            tintColor = UIColor(hex: "#E3E5E8")
            textColor = UIColor(hex: "BDBDBD")
            font = UIFont.systemFont(ofSize: 14, weight: .regular)
    
           
            let bundle = Bundle(for: WeeboTextField.self)
    
            // Setup left/right view
            switch inputType {
        
            case .email:
                textContentType = .emailAddress
                keyboardType = .emailAddress
                autocapitalizationType = .none
    

    
            case .password:
                if #available(iOS 11.0, *) {
                    textContentType = .password
                }
                keyboardType = .default
                autocapitalizationType = .none
                isSecureTextEntry = true
    
                // Add right view
                let button = UIButton(type: .system)
                button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
                button.setTitle(nil, for: .normal)
                button.addTarget(self, action: #selector(self.secureButtonTapped(_:)), for: .touchUpInside)
                rightView = button
                self.secureButton = button
                rightViewMode = .always
//                button.translatesAutoresizingMaskIntoConstraints = false
//                NSLayoutConstraint.activate([
//                    button.widthAnchor.constraint(equalToConstant: 18),
//                    button.heightAnchor.constraint(equalToConstant: 18)
//                ])

    
            case .undefined:
                textContentType = .none
                keyboardType = .default
                autocapitalizationType = .none
            }
    
            // Observe text field editing state
            let observeEditingEvents: () -> Void = { [unowned self] in
                self.addTarget(self, action: #selector(self.editingDidBegin(_:)), for: .editingDidBegin)
                self.addTarget(self, action: #selector(self.editingDidEnd(_:)), for: .editingDidEnd)
            }
            observeEditingEvents()
    
            // Just update after setup
            update()
        }
    
        func update() {
            attributedPlaceholder = NSAttributedString(
                string: placeholder ?? "",
                attributes: [
                    .font: UIFont.systemFont(ofSize: 14, weight: .regular),
                    .foregroundColor: UIColor(hex: "BDBDBD")
                ]
            )
          
            secureButton?.setImage(UIImage(named: isSecureTextEntry ? "icn_secure" : "icn_unsecure")?.withRenderingMode(.alwaysTemplate), for: .normal)
            secureButton?.tintColor = UIColor(hex: "#BDBDBD")
        }
    
        @objc func secureButtonTapped(_ sender: Any) {
            isSecureTextEntry = !isSecureTextEntry
        }
    
        @objc func editingDidBegin(_ sender: Any) {
            update()
        }
    
        @objc func editingDidEnd(_ sender: Any) {
            update()
        }
    }
