
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
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingIndicator()
        startLoadingIndicator()
        tableView.estimatedRowHeight = 80
        viewModel.fetchDiaryEntries()
        viewModel.serviceResultHandler = { [weak self] success, error in
            guard let self else { return }
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                if let error {
                    self.presentAlert(message: error.localizedDescription, title: "Oh no!")
                }
            }
            
            self.stopLoadingIndicator()
        }
    }
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        return indicator
    }()
    
    private func setupLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func startLoadingIndicator() {
        loadingIndicator.alpha = 1
        loadingIndicator.startAnimating()
    }
    
    private func stopLoadingIndicator() {
        loadingIndicator.alpha = 0
        loadingIndicator.stopAnimating()
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let viewModel = FeelingsViewModel(entry: nil)
        let viewController = FeelingsViewController.create(with: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.entryCellViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "feelingsCell", for: indexPath
        ) as! FeelingsListTableViewCell
        let viewModel =  viewModel.entryCellViewModels[indexPath.row]
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
        let entryCellViewModel = viewModel.entryCellViewModels[indexPath.row]
        let viewController = FeelingsViewController.create(with: entryCellViewModel.entryViewModel)
        viewController.entryCompletionHandler = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}
