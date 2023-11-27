
//  FeelingsTableViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 10/3/23.


import UIKit

class FeelingsListTableViewController: UITableViewController, AlertPresentable {
    
    // MARK: - Properties
    var viewModel: FeelingListViewModel
    
//    init?(viewModel: FeelingListViewModel, coder: NSCoder) {
//        self.viewModel = viewModel
//        super.init(coder: coder)
//    }
//
//    @available(*, unavailable, renamed: "init(viewModel:coder:)")
    required init?(coder: NSCoder) {
        viewModel = FeelingListViewModel(userID: UserDefaults.standard.string(forKey: "UserDocumentID")!)
        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecyles
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel = FeelingListViewModel(userID: UserDefaults.standard.string(forKey: "UserDocumentID")!, injectedDelegate: self)
        viewModel.serviceResultHandler = { [weak self] success, error in
            if success {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } else {
                if let error {
                    self?.presentAlert(message: error.localizedDescription, title: "Oh no!")
                }
            }
            
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchDiaryEntries()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.feelingsSOT?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feelingsCell", for: indexPath) as! FeelingsListTableViewCell
        let feelings = viewModel.feelingsSOT?[indexPath.row]
        cell.configureCell(with: feelings)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delete(indexPath: indexPath) {
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = viewModel.feelingsSOT?[indexPath.row]
      let viewModel = FeelingsViewModel(userDiary: entry)
    }
    
    //     MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? FeelingsViewController else { return }
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let entry = viewModel.feelingsSOT?[indexPath.row]
            destination.viewModel = FeelingsViewModel(userDiary: entry, injectedDelegate: destination)
        } else {
            destination.viewModel = FeelingsViewModel(injectedDelegate: destination)
        }
    }
}
// MARK: - Extension
//extension FeelingsListTableViewController: FeelingsListViewModelDelegate {
//    func successfullyLoadedData() {
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
//    
//    func encountered(_ error: Error) {
//        presentAlert(message: error.localizedDescription, title: "Oh no!")
//    }
//}

//extension FeelingsListTableViewController {
//    static func create(with viewModel: FeelingListViewModel) -> FeelingsListTableViewController {
//        let storyboard = UIStoryboard(name: "UserDetails", bundle: nil)
//        return storyboard.instantiateViewController(identifier: "UserDetailsViewController") { coder in
//            FeelingsListTableViewController(viewModel: viewModel, coder: coder)
//        }
//    }
//}
