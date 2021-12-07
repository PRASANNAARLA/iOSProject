//
//  TrainerTableViewCell.swift
//  ThunderFitness
//
//  Created by shabnam shaik on 26/11/2021.
//

import UIKit

class TrainerTableViewCell: UITableViewCell {
    
    @IBOutlet var contantView: UIView!
    @IBOutlet var imgView: UIImageView!
    
    @IBOutlet var nameLbl: UILabel!
    
    @IBOutlet weak var ageLbl: UILabel!
    
    @IBOutlet weak var expierenceLbl: UILabel!
    @IBOutlet var radioBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
