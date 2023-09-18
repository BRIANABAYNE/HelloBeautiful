//
//  PopUp.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 9/17/23.
//

import UIKit

class PopUp: UIView {
    
// MARK: - Actions
    
    @IBOutlet weak var closeButtonTapped: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    }
    
    // MARK: - Functions
    func xibSetup(frame: CGRect) {
        let view = loadxib()
        view.frame = frame
        addSubview(view)
    }
    
    func loadxib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib =  UINib(nibName: "PopUp", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view!
    }

}
