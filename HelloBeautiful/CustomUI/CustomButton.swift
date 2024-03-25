//
//  CustomButton.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 9/16/23.
//

import UIKit


class BBButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    convenience init(color: UIColor) {
        self.init(frame: .zero)
        set(color: color)
    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    private func setupButton() {
        configuration = .tinted()
        configuration?.cornerStyle = .medium
//        translatesAutoresizingMaskIntoConstraints = false
    }
    
        func set(color: UIColor) {
            configuration?.baseBackgroundColor = color
            configuration?.baseForegroundColor = color
//            configuration?.image = UIImage(systemName: systemImageName)
//            configuration?.imagePadding = 6
            configuration?.imagePlacement = .leading
        }
    }
