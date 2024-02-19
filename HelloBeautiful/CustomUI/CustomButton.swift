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
    
    convenience init(color: UIColor, title: String, systemImageName: String) {
        self.init(frame: .zero)
        set(color:color, title: title, systemImageName: systemImageName)
    }
    
    private func setupButton() {
        configuration = .tinted()
        configuration?.cornerStyle = .medium
    }
    
        func set(color: UIColor, title: String, systemImageName: String) {
            configuration?.baseBackgroundColor = color
            configuration?.baseForegroundColor = color
            configuration?.title = title
            configuration?.image = UIImage(systemName: systemImageName)
            configuration?.imagePadding = 6
            configuration?.imagePlacement = .leading
        }
    }
