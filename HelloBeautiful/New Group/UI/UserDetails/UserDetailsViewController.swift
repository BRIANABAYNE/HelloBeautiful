//
//  UserDetailsViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/28/23.
//

import UIKit

class UserDetailsViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        
       sunSignPicker.dataSource = self
        sunSignPicker.delegate = self
    }
    
    
    // MARK: - Action
    
    @IBOutlet weak var sunSignPicker: UIPickerView!
    
    
// MARK: - Properties
    var viewModel: UserDetailsViewModel!
    

} // end of ViewC

// MARK: - Extension
extension UserDetailsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.data.count
    }

}

extension UserDetailsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.data[row]
    }
}
