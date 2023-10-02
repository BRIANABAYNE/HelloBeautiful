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
    @IBOutlet weak var horoscopeLable: UILabel!
    
    // MARK: - Properties
    var viewModel: MoonHoroscopeViewModel!
    var userDetails: UserDetails?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MoonHoroscopeViewModel(injectedDelegate: self)
        
        view.backgroundColor = .white
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let scrollView = UIScrollView(frame: CGRect(x: 10, y: 10, width: view.frame.size.width - 20, height: view.frame.size.height - 20 ))
        scrollView.backgroundColor = .gray
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 3000)
        view.sendSubviewToBack(scrollView)
    }

    // MARK: - Functions
    // set horocsope will need to access current user saved data from firebase and will update that when I get to that. This will always be dependant on the user create page, UI being finished.
    //    func setHoroscope() {
    //        guard let user = viewModel.userData,
    //        viewModel.fetchHoroscope(userSign: user.zodiacSign)
    //        DispatchQueue.main.async {
    //            self.horoscopeLable.text = horoscope.horoscope
    //        }
    //    }
}
// MARK: - Extensions
extension MoonHoroscopeViewController: MoonHororscopeViewModelDelegate {
    func updateUI() {
        guard let tld = viewModel.tld,
              let moon = viewModel.moonData,
        let horoscope = viewModel.horoscopeData else { return }
        self.zodiacSignLabel.text = moon.zodiacSign
        self.moonPhaseLabel.text = moon.moonPhase
        self.moonDistanceLabel.text = "\(moon.moonDistance)"
        self.moonriseLabel.text = moon.moonrise
        self.illuminationLabel.text = moon.illumination
       self.horoscopeLable.text = horoscope.horoscope
        
    }
}
