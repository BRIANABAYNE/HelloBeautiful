//
//  FeelingsListViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 10/10/23.
//

import Foundation

class FeelingListViewModel  {
    
    // MARK: - Properties
    
    var diaryEntries: [DiaryEntry] = []
    private let service: FirebaseDiaryServiceable
    var userID: String?
    var serviceResultHandler: ((_ success: Bool, FirebaseError?) -> Void)?
    
    // MARK: - Dependency Injection
    
    init(
        userID: String?,
        service: FirebaseDiaryServiceable = FirebaseDiaryService())
    {
        self.service = service
        self.userID = userID
    }
    
    // MARK: - Functions
    
    var entryCellViewModels: [FeelingsTableCellViewModel] {
        diaryEntries.map { FeelingsTableCellViewModel(entry: $0) }
    }
    
    func fetchDiaryEntries() {
        if let userID {
            service.fetchDiaryEntries(userID: userID,  completion: { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let fetchedDiary):
                    self.diaryEntries = fetchedDiary
                    self.serviceResultHandler?(true, nil)
                case .failure(let error):
                    self.serviceResultHandler?(false, error)
                }
            })
        }
    }
    
    func delete(indexPath: IndexPath, completion: @escaping() -> Void) {
        let entry = diaryEntries[indexPath.row]
        service.deleteDiary(userDeleteDiary: entry) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(_):
                self.diaryEntries.remove(at: indexPath.row)
                completion()
            case .failure(let failure):
                self.serviceResultHandler?(false, failure)
            }
        }
    }
}
