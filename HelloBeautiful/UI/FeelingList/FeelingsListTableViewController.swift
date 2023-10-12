
//  FeelingsTableViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 10/3/23.


import UIKit

class FeelingsListTableViewController: UITableViewController, AlertPresentable {
    
    // MARK: - Properties
    
    var viewModel: FeelingListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FeelingListViewModel(injectedDelegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchDiary()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.feelingsSOT?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feelinsgCell", for: indexPath) as! FeelingsListTableViewCell
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
    
    //     MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? FeelingsViewController else { return }
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let userDiary = viewModel.feelingsSOT?[indexPath.row]
            
            destination.viewModel = FeelingsViewModel(userDiary: userDiary, injectedDelegate: destination)
        } else {
            destination.viewModel = FeelingsViewModel(injectedDelegate: destination)
         }
    }
}
// MARK: - Extension
extension FeelingsListTableViewController: FeelingsListViewModelDelegate {
    func successfullyLoadedData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func encountered(_ error: Error) {
        presentAlert(message: error.localizedDescription, title: "Oh no!")
    }
}
