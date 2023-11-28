//
//  FeelingsTableViewCell.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 10/3/23.
//

import UIKit

class FeelingsListTableViewCell: UITableViewCell {
 
    private var viewModel: FeelingsTableCellViewModel!
    
    // MARK: - Outlets
    
    @IBOutlet weak var feelingDateLabel: UILabel!
    @IBOutlet weak var feelingsNotesLabel: UILabel!
    
    // MARK: - Methods
    
    func configureCell(with viewModel: FeelingsTableCellViewModel) {
        self.viewModel = viewModel
//        feelingDateLabel.text = viewModel.title
//        feelingsNotesLabel.text = viewModel.subtitle
        contentConfiguration
    }
}
