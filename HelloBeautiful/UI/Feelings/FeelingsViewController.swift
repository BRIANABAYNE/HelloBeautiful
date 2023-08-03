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
    // model objects
    var model = Diary()
    // date property passed from calendar
    var selectedDate: Date?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // segment control
        // this not connected to a date - we want each date to have its own diary model object.
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
    @IBAction func saveButtonTapped(_ sender: Any) {
        // This is where they will call a save function from the view model, that will save the model object to the date that they selected. Save everything from the segment controlls - this button will also go back to the calendar view page. Will need a place holder property for the date.
        
        // Notes - get the text from the textfield
        if let notesText = notesTextField.text {
            // setp 2 save the notes to the model object notes property
            model.notes = notesText
            // flow segment
            let flowString = flowSegmentControl.titleForSegment(at: flowSegmentControl.selectedSegmentIndex) ?? ""
                    model.flow = flowString
            // mucus segment
            let mucusString = mucusSegmentControl.titleForSegment(at: mucusSegmentControl.selectedSegmentIndex) ?? ""
                    model.cervicalMucus = mucusString
            //feelings segment
            let feelingsString = feelingsSegmentControl.titleForSegment(at: feelingsSegmentControl.selectedSegmentIndex) ?? ""
                    model.flow = feelingsString
            // craving segment
            let cravingsString = cravingsSegmentControl.titleForSegment(at: cravingsSegmentControl.selectedSegmentIndex) ?? ""
                    model.cravings = cravingsString
            // symptoms segment
            let symptomsString = symptomsSegmentControl.titleForSegment(at: symptomsSegmentControl.selectedSegmentIndex) ?? ""
                    model.symptoms = symptomsString
  // Check if the data is selected
            if let selectedDate = selectedDate {
                let diaryEntry = DateEntry(date: selectedDate, model: model)
                
                // Need to save this entry to firebase, so i'll be calling a save function that i created on viewmodel, that saves this model object to firebase for each selected day.
            }
        }
        
        
    }
    
    @IBAction func flowSegmentControlAction(_ sender: UISegmentedControl) {
        let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
        model.flow = selectedTitle
        print("Selected option: \(model.flow)")
    }

    @IBAction func mucusSegmentControlAction(_ sender: UISegmentedControl) {
        let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
        model.cervicalMucus = selectedTitle
        print("Selected option: \(model.cervicalMucus)")    }
    
    @IBAction func feelsSegmentControlAction(_ sender: UISegmentedControl) {
        let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
        model.feels = selectedTitle
        print("Selected option: \(model.feels)")    }
    
    @IBAction func cravingSegmentControlAction(_ sender: UISegmentedControl) {
        let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
        model.cravings = selectedTitle
        print("Selected option: \(model.cravings)")    }
    
    @IBAction func symptomsSegmentControlAction(_ sender: UISegmentedControl) {
        let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? ""
        model.symptoms = selectedTitle
        print("Selected option: \(model.symptoms)")    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
