//
//  UserCycleViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 11/3/23.
//

import Foundation

protocol UserCycleViewModelDelegate: ViewController {
    func successfullyLoadedCycleData()
    func encountered(_ error: Error)
}

struct UserCycleViewModel {
    
    // MARK: - Properties

    var userCycle: UserCycle?
    private let userCycleService: FirebaseUserCycleServicable
    weak var cycleDelegate: UserCycleViewModelDelegate?
    
    // MARK: - Dependency Injection
    
    init(userCycle: UserCycle, userCycleService: FirebaseUserCycleService = FirebaseUserCycleService(), injectedDelegate: UserCycleViewModelDelegate)
    {
        self.userCycle = userCycle
        self.userCycleService = userCycleService
        self.cycleDelegate = injectedDelegate
    }

  // MARK: - Crud Functions
    
    func saveUserCycle(dateComponent: DateComponents, cycleType: CycleType) {
        let userCycle = UserCycle(dateComponent: dateComponent, cycleType: cycleType.rawValue,cycleCollectionType: Constants.UserCycle.userCycleCollectionPath)
        userCycleService.saveUserCycle(userCycle: userCycle, completion: { result in
            switch result {
            case .success(_):
                cycleDelegate?.successfullyLoadedCycleData()
                print("User Cycle was saved to FB")
            case .failure(let failure):
                print("There was an error saving the cycle to FB")
                self.cycleDelegate?.encountered(failure)
            }
        })
    }
}
