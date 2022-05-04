//
//  HeaderTableViewCell.swift
//  UBRateMyProf
//
//  Created by Wasif  Khan on 5/3/22.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var professorHeader: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewCell
//
//        let review = self.professorReviews[indexPath.row]
//        let title = review["rDate"] as! String
//        let course = review["rClass"] as! String
//        let content = review["rComments"] as! String
//        let rating = review["rOverall"] as! Float
//
//        cell.reviewTitle.text = title
//        cell.reviewCourse.text = course
//        cell.reviewContent.text = content
//        cell.reviewRating.text = "\(rating)"
//        cell.reviewRating.textColor = ratingColor(rating: rating)
//        return cell
    }
    
    
    

}
