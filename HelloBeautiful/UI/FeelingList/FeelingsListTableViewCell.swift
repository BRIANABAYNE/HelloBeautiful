//
//  FeelingsTableViewCell.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 10/3/23.
//

import UIKit

class FeelingsListTableViewCell: UITableViewCell {
 
    private var viewModel: FeelingsTableCellViewModel!
    
    // MARK: - Methods
    
    func configureCell(with viewModel: FeelingsTableCellViewModel) {
        self.viewModel = viewModel
        var config = UIListContentConfiguration.subtitleCell()
        config.text = viewModel.title
        config.secondaryText = viewModel.subtitle
        config.secondaryTextProperties.numberOfLines = 1
        contentConfiguration = config
    }
}
