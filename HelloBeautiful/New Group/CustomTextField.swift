//
//  CustomTextField.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 9/16/23.
//

import UIKit

class BBTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpField()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init( coder: aDecoder )
        setUpField()
    }
    
    
    private func setUpField() {
        tintColor             = .systemPink
        textColor             = .white
        font                  = UIFont(name: Constants.Fonts.mainstay, size: 18)
        backgroundColor       = UIColor(white: 1.0, alpha: 0.5)
        autocorrectionType    = .no
        layer.cornerRadius    = 25.0
        clipsToBounds         = true
        
        let placeholder       = self.placeholder != nil ? self.placeholder! : ""
        let placeholderFont   = UIFont(name: Constants.Fonts.mainstay, size: 18)!
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes:
                                                    [NSAttributedString.Key.foregroundColor: UIColor.white,
             NSAttributedString.Key.font: placeholderFont])
        
        let indentView        = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        leftView              = indentView
        leftViewMode          = .always
    }
}
