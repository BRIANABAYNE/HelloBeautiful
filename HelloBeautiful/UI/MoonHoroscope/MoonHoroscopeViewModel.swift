//
//  MoonHoroscopeViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/26/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

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
    var lowercaseZodiac: String = ""
    
    // MARK: - Dependency Injection
    init(injectedDelegate: MoonHororscopeViewModelDelegate, injectedMoonHoroscopeService: MoonHoroscopeServiceable = MoonHoroscopeService()) {
        self.delegate = injectedDelegate
        self.service = injectedMoonHoroscopeService
        fetchMoonDetails()
        fetchUserZodiacSign()
//      fetchUserZodiacSign()
//        fetchHoroscope(userSign: lowercaseZodiac)
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
    
//    func fetchUserZodiacSign(){

//        let defaultStore = Firestore.firestore()
//        defaultStore.collection("UserDetails").getDocuments { snapshot, error in
//            if let error = error {
//                print("Error getting User Docs \(error)")
//            } else {
//                let currentUID: String = Auth.auth().currentUser!.uid
//                let userRef = defaultStore.collection("UserDetails").document(currentUID)
//                userRef.getDocument { document, error in
//                    if let document = document, document.exists {
//                        var userZodiac: String = ""
//                        if(document.get("zodiacSign") as? String != nil ) {
//                            userZodiac = document.get("zodiacSign") as? String ?? ""
//                            self.lowercaseZodiac = userZodiac.lowercased()
//                            print("\(userZodiac.lowercased())")
//                            self.fetchHoroscope(userSign: self.lowercaseZodiac)
//
//                        }
//                    }
//                }
//            }
//
//        }
//    
//
    func fetchUserZodiacSign(){
        
        let userID = UserDefaults.standard.value(forKey: "UserDocumentID") as! String
        let defaultStore = Firestore.firestore()
        defaultStore.collection("UserDetails").document(userID).getDocument(as: UserDetails.self) { result in
            print(result)
            // Use the result to fetch the zodiac sign
            
        }
        defaultStore.collection("UserDetails")
            .document(userID).getDocument { snapshot, error in
                do {
                    let user = try (snapshot?.data(as: UserDetails.self))
                    self.fetchHoroscope(userSign: (user?.zodiacSign.lowercased())!)
                    self.userDetail = user
                    
                } catch {
                    print("print error")
                }
                
            }
    }
    
    
    //    func fetchUserZodiacSign() {
    //        let defaultStore = Firestore.firestore()
    //        let path = defaultStore.collection("UserDetails").document((self.userDetail?.id!)!)
    //        path.getDocument(as: User.self) { result in
    //            switch result {
    //            case.success(let success):
    //                print(success.zodiacSign.lowercased())
    //            case.failure(let failure):
    //                print("Wasn't able to get zodiacSign", failure.localizedDescription)
    //        }
    //    }
    //}
    
    
    func fetchHoroscope(userSign: String) {
        
//        let sign = UserDefaults.standard.string(forKey: "UserZodiacSign")
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
