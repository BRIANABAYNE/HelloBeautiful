//
//  FeelingsListViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 10/10/23.
//

import Foundation

// MARK: - Protocol
//protocol FeelingsListViewModelDelegate: FeelingsListTableViewController {
//}

class FeelingListViewModel  {
    
    // MARK: - Properties
    var diaryEntries: [DiaryEntry]?
    private let service: FirebaseDiaryServicable
    var userID: String
    var serviceResultHandler: ((_ success: Bool, FirebaseError?) -> Void)?
    
    // MARK: - Dependency Injection
    init(userID: String, service: FirebaseDiaryServicable = FirebaseDiaryService()) {
        self.service = service
        self.userID = userID
    }
    
//    init(userID: String, service: FirebaseDiaryServicable = FirebaseDiaryService()) {
//        self.service = service
//        self.userID = userID
//    }
    
    // MARK: - Functions
    func fetchDiaryEntries() {
        service.fetchDiaryEntries(userID: self.userID,  completion: { [weak self] result in
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
    
    func delete(indexPath: IndexPath, completion: @escaping() -> Void) {
        guard let diary = diaryEntries?[indexPath.row] else { return }
        service.deleteDiary(userDeleteDiary: diary) { [weak self] result in
            switch result {
            case .success(_):
                self?.diaryEntries?.remove(at: indexPath.row)
                completion()
            case .failure(let failure):
                self?.serviceResultHandler?(false, failure)
               // self.delegate?.encountered(failure)
            }
        }
    }
} // end of VC
