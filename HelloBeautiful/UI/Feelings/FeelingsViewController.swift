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
    
    var viewModel: FeelingsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: - Update this to use the date from FB if the user came via segue
        feelingsDateLabel.text = Date().stringValue()
        // ^^^
        viewModel = FeelingsViewModel(injectedDelegate: self)
        
        ////       flowSegmentControl.selectionViewFillType = .fillSegment
        ////        flowSegmentControl.titleDistribution = .equalSpacing
        //        segmentedControl.isDragEnabled = true
        //        segmentedControl.isSizeAdjustEnabled = true
        //        segmentedControl.isSwitchBehaviorEnabled = false
        //        flowSegmentControl.containerBackgroundColor = .white
        //        segmentedControl.cornerRadius = .constant(value: 15)
        //        segmentedControl.cornerCurve = .continous
        //        segmentedControl.padding = .init(width: 2, height: 2)
        //
        
    }

    // MARK: - Methods
    
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        // This is where they will call a save function from the view model, that will save the model object to the date that they selected. Save everything from the segment controlls - this button will also go back to the calendar view page. Will need a place holder property for the date.
//        let storyboard = UIStoryboard(name:"UserCycle", bundle: nil)
//        let calenderCycle = storyboard.instantiateViewController(identifier:"calenderCycle")
//        self.view.window?.rootViewController = calenderCycle
        
        guard let notes = notesTextField.text else { return }
        notesTextField.text = ""

//        viewModel.model.notes = notes
        // flow segment
        let flowString = flowSegmentControl.titleForSegment(at: flowSegmentControl.selectedSegmentIndex) ?? ""
//        viewModel.model.flow = flowString
        // mucus segment
        let mucusString = mucusSegmentControl.titleForSegment(at: mucusSegmentControl.selectedSegmentIndex) ?? ""
//        viewModel.model.cervicalMucus = mucusString
        //feelings segment
        let feelingsString = feelingsSegmentControl.titleForSegment(at: feelingsSegmentControl.selectedSegmentIndex) ?? ""
//        viewModel.model.flow = feelingsString
        // craving segment
        let cravingsString = cravingsSegmentControl.titleForSegment(at: cravingsSegmentControl.selectedSegmentIndex) ?? ""
//        viewModel.model.cravings = cravingsString
        // symptoms segment
        let symptomsString = symptomsSegmentControl.titleForSegment(at: symptomsSegmentControl.selectedSegmentIndex) ?? ""
//        viewModel.model.symptoms = symptomsString
      
        viewModel.saveDiary(flow: flowString , cervicalMucus: mucusString, feels: feelingsString, cravings: cravingsString, symptoms: symptomsString, notes: notes, date: Date())
    }
    
    @IBAction func flowSegmentControlAction(_ sender: UISegmentedControl) {
        let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
//        viewModel.model.flow = selectedTitle
//        print("Selected option: \(viewModel.model.flow)")
        
    }
    
    @IBAction func mucusSegmentControlAction(_ sender: UISegmentedControl) {
        let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
//        viewModel.model.cervicalMucus = selectedTitle
//        print("Selected option: \(viewModel.model.cervicalMucus)")
        
    }
    
    @IBAction func feelsSegmentControlAction(_ sender: UISegmentedControl) {
        let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
//        viewModel.model.feels = selectedTitle
//        print("Selected option: \(viewModel.model.feels)")
        
    }
    
    @IBAction func cravingSegmentControlAction(_ sender: UISegmentedControl) {
        let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
//        viewModel.model.cravings = selectedTitle
//        print("Selected option: \(viewModel.model.cravings)")
        
    }
    
    @IBAction func symptomsSegmentControlAction(_ sender: UISegmentedControl) {
        let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
//        viewModel.model.symptoms = selectedTitle
//        print("Selected option: \(viewModel.model.symptoms)")
        
    }
    
}

extension FeelingsViewController: FeelingsViewModelDelegate {
    func successfullyLoadedData() {
        navigationController?.popViewController(animated: true)
    }
    
    func encountered(_ error: Error) {
        presentAlert(message: error.localizedDescription, title: "Oh no!")
    }
    
    
}
