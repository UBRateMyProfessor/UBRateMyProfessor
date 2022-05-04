//
//  NameTableViewCell.swift
//  UBRateMyProf
//
//  Created by Wasif  Khan on 5/3/22.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    @IBOutlet weak var professorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
