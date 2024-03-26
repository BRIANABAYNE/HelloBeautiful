//
//  MoonHoroscopeViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/26/23.
//

import UIKit

class MoonHoroscopeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var sunSignLabel: UILabel!
    @IBOutlet weak var moonPhaseLabel: UILabel!
    @IBOutlet weak var moonDistanceLabel: UILabel!
    @IBOutlet weak var moonriseLabel: UILabel!
    @IBOutlet weak var illuminationLabel: UILabel!
    @IBOutlet weak var moonImage: UIImageView!
    @IBOutlet weak var horoscopeLabel: UILabel!
    @IBOutlet weak var stageLabel: UILabel!
    
    // MARK: - Properties
    
    var viewModel: MoonHoroscopeViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MoonHoroscopeViewModel(injectedDelegate: self)
    }

}

// MARK: - Extension

extension MoonHoroscopeViewController: MoonHoroscopeViewModelDelegate {
    func updateUI() {
        guard let topLevelDictionary = viewModel.topLevelDictionary,
        let moon = viewModel.moonData, /*else { return }*/
        let horoscope = viewModel.horoscopeData else { return }
        self.stageLabel.text = moon.stage
        self.moonPhaseLabel.text = moon.moonPhase
        self.moonDistanceLabel.text = "\(moon.moonDistance)"
        self.moonriseLabel.text = moon.moonrise
        self.illuminationLabel.text = moon.illumination
        self.horoscopeLabel.text = horoscope.horoscope
        self.horoscopeLabel.text = horoscope.sunSign
    }
}
