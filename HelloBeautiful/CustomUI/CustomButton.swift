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
    
    private func setupButton() {
        backgroundColor     = Constants.Colors.customPink
        titleLabel?.font    = UIFont(name: Constants.Fonts.mainstay, size: 22)
        layer.cornerRadius  = frame.size.height/2
        setTitleColor(.white, for: .normal)
    }
}
