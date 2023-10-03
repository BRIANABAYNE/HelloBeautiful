//
//  FeelingsTableViewCell.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 10/3/23.
//

import UIKit

class FeelingsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var feelingDateLabel: UILabel!
    @IBOutlet weak var feelingsNotesLabel: UILabel!
    @IBOutlet weak var feelingSymptomsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    // need to figure out the date 
    func configureCell(with diary: Diary?) {
        guard let diary else { return }
        feelingsNotesLabel.text = diary.notes
        feelingSymptomsLabel.text = diary.symptoms
    }



}
