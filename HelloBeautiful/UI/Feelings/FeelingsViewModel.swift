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

class FeelingsViewModel {
    
    // MARK: - Properties
    
    var userDiary: DiaryEntry?
    private let feelingsService: FirebaseDiaryServicable
    weak var feelingsDelegate: FeelingsViewModelDelegate?
    
    // MARK: - Dependency Injection
    init(
        userDiary: DiaryEntry? = nil,
        feelingsService: FirebaseDiaryService = FirebaseDiaryService(),
        injectedDelegate: FeelingsViewModelDelegate
    ){
        self.userDiary = userDiary
        self.feelingsService = feelingsService
        self.feelingsDelegate = injectedDelegate
    }
    
    // MARK: - Function Crud
    func saveDiary(
        flow: Int,
        cervicalMucus: Int,
        feels: Int,
        cravings: Int,
        symptoms: Int,
        notes: String,
        date: Date
    ) {
        if userDiary != nil {
            updateDiary(
                newFlow: flow,
                newCervicalMucus: cervicalMucus,
                newFeels: feels, newCravings: cravings,
                newSymptoms: symptoms,
                newNotes: notes
            )
        } else {
            createDiary(
                flow: flow,
                cervicalMucus: cervicalMucus,
                feels: feels, cravings: cravings,
                symptoms: symptoms,
                notes: notes,
                date: date
            )
        }
    }
    
    func createDiary(
        flow: Int,
        cervicalMucus: Int,
        feels: Int,
        cravings: Int,
        symptoms: Int,
        notes: String,
        date: Date
    ) {
        let diaryDetails = DiaryEntry (
            flow: flow,
            cervicalMucus: cervicalMucus,
            feels: feels, cravings: cravings,
            symptoms: symptoms,
            notes: notes,
            feelingsCollectionType: Constants.Diary.diaryCollectionPath
        )
        
        feelingsService.createDiary(userDiary: diaryDetails, completion: { result in
            switch result {
            case.success(_):
                self.feelingsDelegate?.successfullyLoadedData()
                print("User Diary was created")
            case.failure(let failure):
                print("There was an error creating the Diary")
                self.feelingsDelegate?.encountered(failure)
            }
        })
    }
    
    func updateDiary (
        newFlow: Int,
        newCervicalMucus: Int,
        newFeels: Int,
        newCravings: Int,
        newSymptoms: Int,
        newNotes: String,
        date: Date? = nil
    ) {
        
        guard let diaryToUpdate = self.userDiary else { return }
        
        let updatedDiary = DiaryEntry(
            id: diaryToUpdate.id,
            flow: newFlow,
            cervicalMucus: newCervicalMucus,
            feels: newFeels,
            cravings: newCravings,
            symptoms: newSymptoms,
            notes: newNotes,
            date: date ?? diaryToUpdate.date,
            feelingsCollectionType: Constants.Diary.diaryCollectionPath
        )
        
        feelingsService.updateDiary(userDiary: updatedDiary) { result in
            
        }
    }
    
    private func update(updateDiary: DiaryEntry) {
        feelingsService.updateDiary(userDiary: updateDiary) { result in
            switch result {
            case .success(_):
                print("Diary updated successfully")
            case .failure(let failure):
                self.feelingsDelegate?.encountered(failure)
            }
        }
    }
}
