//
//  MoonHoroscopeViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/26/23.
//

import UIKit

class MoonHoroscopeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var zodiacSignLabel: UILabel!
    @IBOutlet weak var weeklyHoroscopeLabel: UITextView!
    @IBOutlet weak var moonPhaseLabel: UILabel!
    @IBOutlet weak var moonDateLabel: UILabel!
    @IBOutlet weak var moonDistanceLabel: UILabel!
    @IBOutlet weak var moonriseLabel: UILabel!
    @IBOutlet weak var lunarCycleLabel: UILabel!
    @IBOutlet weak var illuminationLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    // MARK: - Properties
    var viewModel:MoonHoroscopeViewModel!
    var moon: Moon?
    
    // MARK: - Functions
    
}
