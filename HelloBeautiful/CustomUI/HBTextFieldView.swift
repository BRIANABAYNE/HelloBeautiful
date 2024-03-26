//
//  HBTextFieldView.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 12/12/23.
//

import UIKit

class HBTextFieldView: UIView {
    
    static private let nibName = "HBTextFieldView"
    private var contentView: UIView?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        layer.cornerRadius = 25
        clipsToBounds = true
//        UIReturnKeyType = .go
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    
    // MARK: - View Properties
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.tintColor = .accentColor
        textField.borderStyle = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .go
        textField.delegate = self
        return textField
    }()
  
    /// Gets the text value from the text field.
    var text: String? {
        textField.text
    }
    
    /// Sets the text and placeholder for the text field.
    /// - Parameters:
    ///   - text: default is nil
    ///   - placeholder: default is nil. string is drawn 70% gray
    func set(text: String? = nil, placeholder: String?) {
        textField.text = text
        textField.placeholder = placeholder
    }
    
    func makeFirstResponder() {
        if textField.canBecomeFirstResponder {
            textField.becomeFirstResponder()
        }
    }
}

private extension UIColor {
    static var accentColor: UIColor {
        UIColor(named: "accentColor") ?? .systemBlue
    }
}

extension HBTextFieldView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       print("Did tap return")
        return true
    }
}
