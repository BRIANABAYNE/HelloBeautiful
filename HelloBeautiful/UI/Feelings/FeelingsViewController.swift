//
//  FeelingsViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 8/3/23.
//

import UIKit


@IBDesignable // allows to show on the storyboard
class FeelingsViewController: UIViewController, AlertPresentable  {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var flowSegmentControl: UISegmentedControl!
    @IBOutlet weak var mucusSegmentControl: UISegmentedControl!
    @IBOutlet weak var feelingsSegmentControl: UISegmentedControl!
    @IBOutlet weak var cravingsSegmentControl: UISegmentedControl!
    @IBOutlet weak var symptomsSegmentControl: UISegmentedControl!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var feelingsDateLabel: UILabel!
    
    
    // MARK: - Properties
    
    var viewModel: FeelingsViewModel
    
    init?(viewModel: FeelingsViewModel, coder: NSCoder) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    @available(*, unavailable, renamed: "init(viewModel:coder:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecyles
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: - Update this to use the date from FB if the user came via segue
        feelingsDateLabel.text = Date().stringValue()
        // ^^^
        viewModel = FeelingsViewModel(injectedDelegate: self)
        setupSegmentedControls()
    }
    
    // MARK: - Methods
    
    
    private func setupSegmentedControls() {
        guard let diary = viewModel.userDiary else { return }
        
        for (index, flow) in Flow.allCases.enumerated() {
            flowSegmentControl.setTitle(flow.flowTitle, forSegmentAt: index)
            flowSegmentControl.selectedSegmentIndex = diary.flow
        }
        
        for (index, mucus) in CervicalMucus.allCases.enumerated() {
            mucusSegmentControl.setTitle(mucus.mucusTitle, forSegmentAt: index)
            mucusSegmentControl.selectedSegmentIndex = diary.cervicalMucus
        }
        
        for (index, feels) in Feels.allCases.enumerated() {
            feelingsSegmentControl.setTitle(feels.feelingsTitle, forSegmentAt: index)
            feelingsSegmentControl.selectedSegmentIndex = diary.feels
        }
        
        for (index, cravings) in Cravings.allCases.enumerated() {
            cravingsSegmentControl.setTitle(cravings.cravingTitle, forSegmentAt: index)
            cravingsSegmentControl.selectedSegmentIndex = diary.cravings
        }
        
        for (index, symptoms) in Symptoms.allCases.enumerated() {
            symptomsSegmentControl.setTitle(symptoms.symptomsTitle, forSegmentAt: index)
            symptomsSegmentControl.selectedSegmentIndex = diary.symptoms
        }
    }

    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        if viewModel.userDiary != nil {
            viewModel.updateDiary (
                newFlow: flowSegmentControl.selectedSegmentIndex,
                newCervicalMucus: mucusSegmentControl.selectedSegmentIndex,
                newFeels: feelingsSegmentControl.selectedSegmentIndex,
                newCravings: cravingsSegmentControl.selectedSegmentIndex,
                newSymptoms: symptomsSegmentControl.selectedSegmentIndex,
                newNotes: notesTextField.text ?? ""
            )
        } else if viewModel.userDiary == nil {
            viewModel.createDiary(
                flow: flowSegmentControl.selectedSegmentIndex,
                cervicalMucus: mucusSegmentControl.selectedSegmentIndex,
                feels: feelingsSegmentControl.selectedSegmentIndex,
                cravings: cravingsSegmentControl.selectedSegmentIndex,
                symptoms: symptomsSegmentControl.selectedSegmentIndex,
                notes: notesTextField.text ?? "",
                date: Date()
            )
        }
    }
    
    @IBAction func flowSegmentControlAction(_ sender: UISegmentedControl) {
        
    }
    
    @IBAction func mucusSegmentControlAction(_ sender: UISegmentedControl) {
        
    }
    
    @IBAction func feelsSegmentControlAction(_ sender: UISegmentedControl) {
    }
    
    @IBAction func cravingSegmentControlAction(_ sender: UISegmentedControl) {
        
    }
    
    @IBAction func symptomsSegmentControlAction(_ sender: UISegmentedControl) {
        
    }
}
// MARK: - Extension

extension FeelingsViewController: FeelingsViewModelDelegate {
    func successfullyLoadedData() {
        navigationController?.popViewController(animated: true)
    }
    
    func encountered(_ error: Error) {
        presentAlert(message: error.localizedDescription, title: "Oh no!")
    }
}

extension FeelingsViewController {
    static func create(with viewModel: FeelingsViewModel) -> FeelingsViewController {
        let storyboard = UIStoryboard(name: "Feelings", bundle: nil)
        return storyboard.instantiateViewController(identifier: "FeelingViewController") { coder in
            FeelingsViewController(viewModel: viewModel, coder: coder)
        }
    }
}
