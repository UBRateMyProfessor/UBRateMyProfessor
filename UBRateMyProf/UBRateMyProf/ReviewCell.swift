//
//  RatingCell.swift
//  UBRateMyProf
//
//  Created by Andy Chen on 4/12/22.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var reviewTitle: UILabel!
    @IBOutlet weak var reviewContent: UILabel!
    @IBOutlet weak var reviewRating: UILabel!
    @IBOutlet weak var reviewCourse: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
