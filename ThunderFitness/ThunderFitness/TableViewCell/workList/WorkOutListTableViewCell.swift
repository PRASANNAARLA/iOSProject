//
//  WorkOutListTableViewCell.swift
//  ThunderFitness
//
//  Created by shabnam shaik on 05/12/2021.
//

import UIKit

class WorkOutListTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var radioBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
