//
//  DietaryTableViewCell.swift
//  ThunderFitness
//
//  Created by shabnam shaik on 26/11/2021.
//

import UIKit

class DietaryTableViewCell: UITableViewCell {
    
    @IBOutlet var contantView: UIView!
    @IBOutlet var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
