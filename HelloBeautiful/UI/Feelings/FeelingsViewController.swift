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
    
        
        
        
//        flowSegmentControl.layer.cornerRadius = .
        
        
//        configureView()
    }

    // MARK: - Methods
    
//    private func configureView() {
//        guard let diary = viewModel.userDiary else { return }
//        flowSegmentControl.selectedSegmentIndex = "\(diary.flow)"
//        mucusSegmentControl.selectedSegmentIndex =  "\(diary.cervicalMucus)"
//        feelingsSegmentControl.selectedSegmentIndex = "\(diary.feels)"
//        cravingsSegmentControl.selectedSegmentIndex = "\(diary.cravings)"
//        symptomsSegmentControl.selectedSegmentIndex = "\(diary.symptoms)"
//    }

    
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        // This is where they will call a save function from the view model, that will save the model object to the date that they selected. Save everything from the segment controlls - this button will also go back to the calendar view page. Will need a place holder property for the date.
//        let storyboard = UIStoryboard(name:"UserCycle", bundle: nil)
//        let calenderCycle = storyboard.instantiateViewController(identifier:"calenderCycle")
//        self.view.window?.rootViewController = calenderCycle
        
        guard let notes = notesTextField.text else { return }
        notesTextField.text = ""


        let flowString = flowSegmentControl.titleForSegment(at: flowSegmentControl.selectedSegmentIndex) ?? ""
        
//        let flowAsInt = Int(flowString)

        let mucusString = mucusSegmentControl.titleForSegment(at: mucusSegmentControl.selectedSegmentIndex) ?? ""
        
//        let muscusAsInt = Int(mucusString)

        let feelingsString = feelingsSegmentControl.titleForSegment(at: feelingsSegmentControl.selectedSegmentIndex) ?? ""
        
//        let feelingsAsInt = Int(feelingsString)

        let cravingsString = cravingsSegmentControl.titleForSegment(at: cravingsSegmentControl.selectedSegmentIndex) ?? ""
        
//        let cravingsAsInt = Int(cravingsString)

        let symptomsString = symptomsSegmentControl.titleForSegment(at: symptomsSegmentControl.selectedSegmentIndex) ?? ""
        
//        let symptomsAsInt = Int(symptomsString)
        
        if viewModel.userDiary != nil {
            viewModel.updateDiary(newFlow: flowString, newCervicalMucus: mucusString, newFeels: feelingsString, newCravings: cravingsString, newSymptoms: symptomsString, newNotes: notes)
        } else if viewModel.userDiary == nil {
          
            viewModel.createDiary(flow: flowString, cervicalMucus: cravingsString, feels: flowString, cravings: cravingsString, symptoms: symptomsString, notes: notes, date: Date())
        }
        
//
//        viewModel.saveDiary(flow: flowString , cervicalMucus: mucusString, feels: feelingsString, cravings: cravingsString, symptoms: symptomsString, notes: notes, date: Date())
    }
    
    @IBAction func flowSegmentControlAction(_ sender: UISegmentedControl) {
//   let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
    }
    
    @IBAction func mucusSegmentControlAction(_ sender: UISegmentedControl) {
//        let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""

    }
    
    @IBAction func feelsSegmentControlAction(_ sender: UISegmentedControl) {
//        let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
    }
    
    @IBAction func cravingSegmentControlAction(_ sender: UISegmentedControl) {
//       let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""

    }
    
    @IBAction func symptomsSegmentControlAction(_ sender: UISegmentedControl) {
//     let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""

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
