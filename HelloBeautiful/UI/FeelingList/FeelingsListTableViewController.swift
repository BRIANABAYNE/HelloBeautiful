
//  FeelingsTableViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 10/3/23.


import UIKit

class FeelingsListTableViewController: UITableViewController, AlertPresentable {
    
    // MARK: - Properties
    var viewModel: FeelingListViewModel
    
    required init?(coder: NSCoder) {
        viewModel = FeelingListViewModel(userID: UserDefaults.standard.string(forKey: "UserDocumentID")!)
        super.init(coder: coder)
       
    }
    
    
    // MARK: - Lifecyles
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 80
        viewModel.fetchDiaryEntries()
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
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let viewModel = FeelingsViewModel(entry: nil)
        let viewController = FeelingsViewController.create(with: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.diaryEntries?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "feelingsCell", for: indexPath
        ) as! FeelingsListTableViewCell
        let config = UIListContentConfiguration.subtitleCell()
        cell.contentConfiguration = config
        guard let entry = viewModel.diaryEntries?[indexPath.row] else { return UITableViewCell() }
        let viewModel = FeelingsTableCellViewModel(entry: entry)
        cell.configureCell(with: viewModel)
        
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            viewModel.delete(indexPath: indexPath) {
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = viewModel.diaryEntries?[indexPath.row]
        let viewModel = FeelingsViewModel(entry: entry)
        let viewController = FeelingsViewController.create(with: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
