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
    @IBOutlet weak var moonPhaseLabel: UILabel!
    @IBOutlet weak var moonDistanceLabel: UILabel!
    @IBOutlet weak var moonriseLabel: UILabel!
    @IBOutlet weak var illuminationLabel: UILabel!
    @IBOutlet weak var moonImage: UIImageView!
    @IBOutlet weak var horoscopeLabel: UILabel!
    
    // MARK: - Properties
    
    var viewModel: MoonHoroscopeViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MoonHoroscopeViewModel(injectedDelegate: self)
    }

//     MARK: - ScrollView
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let scrollView = UIScrollView(frame: CGRect(
            x: 5,
            y: 5,
            width: view.frame.size.width - 5,
            height: view.frame.size.height - 5
        ))
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 4000)
        view.sendSubviewToBack(scrollView)
    }
}

// MARK: - Extension

extension MoonHoroscopeViewController: MoonHoroscopeViewModelDelegate {
    func updateUI() {
        guard let topLevelDictionary = viewModel.topLevelDictionary,
              let moon = viewModel.moonData,
              let horoscope = viewModel.horoscopeData else { return }
        self.zodiacSignLabel.text = moon.zodiacSign
        self.moonPhaseLabel.text = moon.moonPhase
        self.moonDistanceLabel.text = "\(moon.moonDistance)"
        self.moonriseLabel.text = moon.moonrise
        self.illuminationLabel.text = moon.illumination
        self.horoscopeLabel.text = horoscope.horoscope
    }
}
