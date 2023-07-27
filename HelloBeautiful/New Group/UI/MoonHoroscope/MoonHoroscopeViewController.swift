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
    @IBOutlet weak var illuminationLabel: UILabel!
    
    
    // MARK: - Properties
    var viewModel: MoonHoroscopeViewModel!
    // User property reciever
    var userData: User?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MoonHoroscopeViewModel(injectedDelegate: self)
//        setHoroscope()

    }
    
    // MARK: - Functions
     // set horocsope will need to access current user saved data from firebase and will update that when I get to that. This will always be dependant on the user create page, UI being finished.
    func setHoroscope() {
        guard let user = userData,
              let horoscope = viewModel.horoscopeData else { return }
        viewModel.fetchHoroscope(userSign: user.zodiacSign)
        DispatchQueue.main.async {
            self.weeklyHoroscopeLabel.text = horoscope.horoscope
            
        }
    }
    
//    func updateUI() {
//        guard let tld = viewModel.tld,
//              let moon = viewModel.moonData else { return }
//        DispatchQueue.main.async {
//            self.zodiacSignLabel.text = moon.zodiacSign
//            self.moonPhaseLabel.text = moon.moonPhase
//            self.moonDateLabel.text = tld.datestamp
//            self.moonDistanceLabel.text = "\(moon.moonDistance)"
//            self.moonriseLabel.text = moon.moonrise
//            self.illuminationLabel.text = moon.illumination
//
//        }
//
//    }
    
    
    
    
    
}
extension MoonHoroscopeViewController: MoonHororscopeViewModelDelegate {
    func updateUI() {
        guard let tld = viewModel.tld,
              let moon = viewModel.moonData else { return }
            self.zodiacSignLabel.text = moon.zodiacSign
            self.moonPhaseLabel.text = moon.moonPhase
            self.moonDateLabel.text = tld.datestamp
            self.moonDistanceLabel.text = "\(moon.moonDistance)"
            self.moonriseLabel.text = moon.moonrise
            self.illuminationLabel.text = moon.illumination
  
    }
}
