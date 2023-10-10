//
//  FeelingsViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 8/3/23.
//

import Foundation


// MARK: - Protocol
protocol FeelingsViewModelDelegate: FeelingsViewController {
    func successfullyLoadedData()
    func encountered(_ error: Error)
}

struct FeelingsViewModel {
    
    // MARK: - Properties
//    var model = Diary()
    var userDiary: Diary?
    private let feelingsService: FirebaseDiaryServicable
    weak var feelingsDelegate: FeelingsViewModelDelegate?
    
    // MARK: - Dependency Injection
    
    init(userDiary: Diary? = nil, feelingsService: FirebaseDiaryService = FirebaseDiaryService(), injectedDelegate: FeelingsViewModelDelegate) {
        self.userDiary = userDiary
        self.feelingsService = feelingsService
        self.feelingsDelegate = injectedDelegate
    }
    
    // MARK: - Function Crud
    func saveDiary(flow: String, cervicalMucus: String, feels: String, cravings: String, symptoms: String, notes: String, date: Date) {
        if userDiary != nil {
            updateDiary(newFlow: flow, newCervicalMucus: cervicalMucus, newFeels: feels, newCravings: cravings, newSymptoms: symptoms, newNotes: notes)

        } else {
            createDiary(flow: flow, cervicalMucus: cervicalMucus, feels: feels, cravings: cravings, symptoms: symptoms, notes: notes, date: date)
        }
    }

    func createDiary(flow: String, cervicalMucus: String, feels: String, cravings: String, symptoms: String, notes: String, date: Date) {
        
        let diaryDetails = Diary(flow: flow, cervicalMucus: cervicalMucus, feels: feels, cravings: cravings, symptoms: symptoms, notes: notes, date: date, feelingsCollectionType: Constants.Diary.diaryCollectionPath)
        feelingsService.saveDiary(userDiary: diaryDetails, completion: { result in
            switch result {
            case.success(_):
                feelingsDelegate?.successfullyLoadedData()
                print("User Diary was created")
            case.failure(let failure):
                print("There was an error creating the Diary")
                self.feelingsDelegate?.encountered(failure)
            }
        })
    }
    
    func updateDiary(newFlow: String, newCervicalMucus: String, newFeels: String, newCravings: String, newSymptoms: String, newNotes: String) {
        guard let diaryToUpdate = self.userDiary else { return }
        let updatedDiary = Diary(id: diaryToUpdate.id, flow: newFlow, cervicalMucus: newCervicalMucus, feels: newFeels, cravings: newCravings, symptoms: newSymptoms, notes: newNotes,feelingsCollectionType: Constants.Diary.diaryCollectionPath)
        feelingsService.updateDiary(userDiary: updatedDiary) { result in
            //
        }
        
    }


} // end of VM
