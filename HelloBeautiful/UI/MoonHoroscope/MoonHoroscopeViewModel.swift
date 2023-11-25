//
//  MoonHoroscopeViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/26/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

// MARK: - Protocol
protocol MoonHororscopeViewModelDelegate: MoonHoroscopeViewController {
    func updateUI ()
}

class MoonHoroscopeViewModel {
    
    // MARK: - Delegate
    weak var delegate: MoonHororscopeViewModelDelegate?
    
    // MARK: - Properties
    var tld: TopLevelDictionary?
    var moonData: Moon?
    var horoscopeData: Horoscope?
    private let service: MoonHoroscopeServiceable
    
    // MARK: - Dependency Injection
    init(injectedDelegate: MoonHororscopeViewModelDelegate, injectedMoonHoroscopeService: MoonHoroscopeServiceable = MoonHoroscopeService()) {
        self.delegate = injectedDelegate
        self.service = injectedMoonHoroscopeService
        fetchMoonDetails()
        fetchHoroscope()
    }
    
    // MARK: - Functions
    func fetchMoonDetails() {
        service.fetchMoonDetails { result in
            switch result {
            case .success(let tld):
                self.tld = tld
                self.moonData = tld.moon
                DispatchQueue.main.async {
                    self.delegate?.updateUI()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchHoroscope() {
        
        guard let userSign = UserDefaults.standard.string(forKey: "UserZodiacSign") else {print("SHOOT! SOMETHING WENT WRONG WITH THE USER DEFAULTS ZODIAK");return}
        service.fetchHoroscope(sunSign: userSign) { result in
            switch result {
            case .success(let horoscope):
                self.horoscopeData = horoscope
                DispatchQueue.main.async {
                    self.delegate?.updateUI()
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
