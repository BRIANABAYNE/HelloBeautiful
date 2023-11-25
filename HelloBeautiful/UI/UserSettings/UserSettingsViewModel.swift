//
//  UserSettingsViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 8/1/23.
//

import Foundation
import FirebaseAuth
import UIKit

// MARK: - Protocol
protocol UserSettingsViewModelDelegate: UserSettingDetailViewController {
}

struct UserSettingsViewModel {
    
    // MARK: - Properties
    private let authService: FirebaseAuthServiceable
    private let userDetailsService: FirebaseUserDetailServiceable
    weak var delegate: UserSettingsViewModelDelegate?
    
    // MARK: - Dependenct Injections
    init(authService:FirebaseAuthServiceable = FirebaseAuthService(), userDetailsService:FirebaseUserDetailServiceable = FirebaseUerDetailsService(), delegate: UserSettingsViewModelDelegate) {
        self.authService = authService
        self.userDetailsService = userDetailsService
        self.delegate = delegate
    }
    
    func signOut() {
        authService.signOut()
#warning("Should we only change the UI if sigbning out was sucessful?")
    }
    
    func delete() {
        authService.delete()
    }
}
