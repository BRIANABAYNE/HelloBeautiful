//
//  FeelingsViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 8/3/23.
//

import UIKit

class FeelingsViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var flowSegmentControl: UISegmentedControl!
    @IBOutlet weak var mucusSegmentControl: UISegmentedControl!
    @IBOutlet weak var feelingsSegmentControl: UISegmentedControl!
    @IBOutlet weak var cravingsSegmentControl: UISegmentedControl!
    @IBOutlet weak var symptomsSegmentControl: UISegmentedControl!
    @IBOutlet weak var notesTextField: UITextField!
    
    // MARK: - Properties

var viewModel: FeelingsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    viewModel = FeelingsViewModel()
   
    }
    
    
    
    
    func configureFeelingsSegmentedControl() {
//        feelingsSegmentControl.setTitle("\u{e008}", forSegmentAt: 0)
//        feelingsSegmentControl.setTitle("\u{e008}", forSegmentAt: 1)
//        feelingsSegmentControl.setTitle("\u{e008}", forSegmentAt: 2)
//        feelingsSegmentControl.setTitle("\u{e008}", forSegmentAt: 3)
//        feelingsSegmentControl.setTitle("\u{e008}", forSegmentAt: 4)
    }
    
    // MARK: - Methods
    
//    func segmentsSetup() {
//        flowSegmentControl.addTarget(self, action: #selector(flowSegmentControlAction(_:)), for: .valueChanged)
//        flowSegmentControl.addTarget(self, action: #selector(mucusSegmentControlAction(_:)), for: .valueChanged)
//        flowSegmentControl.addTarget(self, action: #selector(feelsSegmentControlAction(_:)), for: .valueChanged)
//        flowSegmentControl.addTarget(self, action: #selector(cravingSegmentControlAction(_:)), for: .valueChanged)
//        flowSegmentControl.addTarget(self, action: #selector(symptomsSegmentControlAction(_:)), for: .valueChanged)
//    }
    
    
    // MARK: - Actions
    
    
//    @IBAction func flowAction(_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            flowSegmentControl.
//        default:
//            <#code#>
//        }
//    }
    
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        // This is where they will call a save function from the view model, that will save the model object to the date that they selected. Save everything from the segment controlls - this button will also go back to the calendar view page. Will need a place holder property for the date.
        
     
        
           let notes = notesTextField.text
//        notesTextField.text = diary.notes
        if let notesText = notesTextField.text {
            // setp 2 save the notes to the model object notes property
            viewModel.model.notes
            // flow segment
            let flowString = flowSegmentControl.titleForSegment(at: flowSegmentControl.selectedSegmentIndex) ?? ""
            viewModel.model.flow = flowString
            // mucus segment
            let mucusString = mucusSegmentControl.titleForSegment(at: mucusSegmentControl.selectedSegmentIndex) ?? ""
            viewModel.model.cervicalMucus = mucusString
            //feelings segment
            let feelingsString = feelingsSegmentControl.titleForSegment(at: feelingsSegmentControl.selectedSegmentIndex) ?? ""
            viewModel.model.flow = feelingsString
            // craving segment
            let cravingsString = cravingsSegmentControl.titleForSegment(at: cravingsSegmentControl.selectedSegmentIndex) ?? ""
            viewModel.model.cravings = cravingsString
            // symptoms segment
            let symptomsString = symptomsSegmentControl.titleForSegment(at: symptomsSegmentControl.selectedSegmentIndex) ?? ""
            viewModel.model.symptoms = symptomsString
  // Check if the data is selected
//            if let selectedDate = selectedDate {
//                let diaryEntry = DateEntry(date: selectedDate, model: viewModel.model)
//
//                // Need to save this entry to firebase, so i'll be calling a save function that i created on viewmodel, that saves this model object to firebase for each selected day.
//            } // end of selectedDate
        } // end of notes
    }
    
    @IBAction func flowSegmentControlAction(_ sender: UISegmentedControl) {
       let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
                viewModel.model.flow = selectedTitle
                print("Selected option: \(viewModel.model.flow)")
    }

    @IBAction func mucusSegmentControlAction(_ sender: UISegmentedControl) {
        let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
        viewModel.model.cervicalMucus = selectedTitle
        print("Selected option: \(viewModel.model.cervicalMucus)")    }
    
    @IBAction func feelsSegmentControlAction(_ sender: UISegmentedControl) {
        let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
        viewModel.model.feels = selectedTitle
        print("Selected option: \(viewModel.model.feels)")    }
    
    @IBAction func cravingSegmentControlAction(_ sender: UISegmentedControl) {
        let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
        viewModel.model.cravings = selectedTitle
        print("Selected option: \(viewModel.model.cravings)")    }
    
    @IBAction func symptomsSegmentControlAction(_ sender: UISegmentedControl) {
        let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
        viewModel.model.symptoms = selectedTitle
        print("Selected option: \(viewModel.model.symptoms)")    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
