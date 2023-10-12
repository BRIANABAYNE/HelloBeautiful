//
//  FeelingsListViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 10/10/23.
//

import Foundation

protocol FeelingsListViewModelDelegate: FeelingsListTableViewController {
    
}


class FeelingListViewModel  {
    
    // MARK: - Properties
    
    var feelingsSOT: [Diary]?
    private let service: FirebaseDiaryServicable
    weak var delegate: FeelingsListViewModelDelegate?
    var userID: String
    // MARK: - Dependency Injection
    
    init(userID: String, injectedDelegate: FeelingsListViewModelDelegate, service: FirebaseDiaryServicable = FirebaseDiaryService()) {
        self.delegate = injectedDelegate
        self.service = service
        self.userID = userID
    }
    
    // MARK: - Functions
    
    func fetchDiaryEntries() {
        service.fetchDiaryEntries(userID: self.userID,  completion: { result in
            switch result {
            case .success(let fetchedDiary):
                self.feelingsSOT = fetchedDiary
                self.delegate?.successfullyLoadedData()
            case .failure(let error):
                self.delegate?.encountered(error)
            }
        })
    }
   

    
    func delete(indexPath: IndexPath, completion: @escaping() -> Void) {
        guard let diary = feelingsSOT?[indexPath.row] else { return }
        service.deleteDiary(userDeleteDiary: diary) { result in
            switch result {
            case .success(_):
                self.feelingsSOT?.remove(at: indexPath.row)
                completion()
            case .failure(let failure):
                self.delegate?.encountered(failure)
            }
        }
        
    }
    
    
    
    
    
    
    
} // end of VC
