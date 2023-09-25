//
//  MoonHoroscopeViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/26/23.
//

import Foundation
import FirebaseFirestore

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
    var userData: User?
    var userDetail: UserDetails?
    var id: String?
    private let service: MoonHoroscopeServiceable
    
    // MARK: - Dependency Injection
    init(injectedDelegate: MoonHororscopeViewModelDelegate, injectedMoonHoroscopeService: MoonHoroscopeServiceable = MoonHoroscopeService()) {
        self.delegate = injectedDelegate
        self.service = injectedMoonHoroscopeService
        fetchMoonDetails()
        fetchUserZodiacSign()
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
    
    func fetchUserZodiacSign() {
        let defaultStore = Firestore.firestore()
         defaultStore.collection("UserDetails")
            .document((self.userData?.id)!).getDocument { snapshot, error in
                do {
                    let user = try (snapshot?.data(as: UserDetails.self))
                    self.fetchHoroscope(userSign: (user?.zodiacSign.lowercased())!)
                    self.userDetail = user
                    
                } catch {
                    print("print error")
                }
        
                }
            }
    

    func fetchHoroscope(userSign: String) {
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
