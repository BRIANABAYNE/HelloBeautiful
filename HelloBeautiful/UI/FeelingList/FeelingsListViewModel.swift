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
    
    // MARK: - Dependency Injection
    
    init(injectedDelegate: FeelingsListViewModelDelegate, service: FirebaseDiaryServicable = FirebaseDiaryService()) {
        self.delegate = injectedDelegate
        self.service = service
    }
    
    // MARK: - Functions
    
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
}
