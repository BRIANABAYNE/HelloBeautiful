//
//  UserSettingsViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 8/1/23.
//

import Foundation
import FirebaseAuth
import UIKit

protocol UserSettingsViewModelDelegate: UserSettingDetailViewController {
    
}

struct UserSettingsViewModel {
    
    
    // MARK: - Properties

    var userDetails: UserDetails?
    var user: User?
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
    }
        
    func delete() {
        authService.delete()
    }
}
