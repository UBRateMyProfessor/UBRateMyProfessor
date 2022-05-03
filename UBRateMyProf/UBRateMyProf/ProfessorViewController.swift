//
//  ProfessorViewController.swift
//  UBRateMyProf
//
//  Created by Andy Chen on 4/12/22.
//

import UIKit
import Parse


class ProfessorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var professorName: UILabel!
    @IBOutlet weak var professorDepartment: UILabel!
    @IBOutlet weak var professorRating: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let nameSearch : String =  "Hartloff"
    var professorInfo : PFObject!
    var ProfessorID : Int = 2055417
    var professorReviews = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 160
        tableView.rowHeight = UITableView.automaticDimension
        
    
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "leaveRatingSegue"  {
            var page = segue.destination as? ReviewViewController
            page!.professorID = self.ProfessorID
        }
    }
       
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        // Get professor info and reviews
        getProfessor()
    }
    
    func getProfessor(){
        // (Read/GET) GET “name” in list of professors
        let queryProfessor = PFQuery(className:"Professors")
        queryProfessor.whereKey("last_name", matchesText: nameSearch)
        queryProfessor.order(byDescending: "Name")
        queryProfessor.findObjectsInBackground { [self] (professors: [PFObject]?, error: Error?) in
           if let error = error {
              print(error.localizedDescription)
           }else if let professors=professors {
               print("Successfully retrieved \(professors.count) professors.")
               // Save professor info
               self.professorInfo = professors[0]
               // Update with professor's details
               self.professorName.text = "\(self.professorInfo["first_name"] ?? "firstName") \(self.professorInfo["last_name"] ?? "lastName")"
               self.professorDepartment.text = "\(self.professorInfo["department"] ?? "department")"
               self.professorRating.text = "\(self.professorInfo["overall_rating"] ?? "NA")"
               self.professorRating.textColor = ratingColor(rating: Float( truncating: self.professorInfo["overall_rating"] as! NSNumber))
               getReviews()
           }
        }
    }
    
    func getReviews(){
        // Get professor reviews
        // (Read/GET) GET “name” in list of professors
        let queryReviews = PFQuery(className:"Ratings")
        queryReviews.whereKey("ratemyprof_id", equalTo: self.professorInfo["ratemyprof_id"] ?? 0)
        queryReviews.order(byDescending: "Date")
        queryReviews.findObjectsInBackground { (reviews: [PFObject]?, error: Error?) in
           if let error = error {
              print(error.localizedDescription)
           } else if let reviews = reviews {
               print("Successfully retrieved \(reviews.count) reviews.")
               // Save reviews
               self.professorReviews = reviews
               self.tableView.reloadData()
           }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return professorReviews.count
    }
    
    func ratingColor(rating : Float) -> UIColor{
        if (rating < 2) {
            return UIColor.systemRed
        }else if (rating < 3.5){
            return UIColor.systemYellow
        }else{
            return UIColor.systemGreen
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewCell
        
        let review = self.professorReviews[indexPath.row]
        let title = review["rDate"] as! String
        let course = review["rClass"] as! String
        let content = review["rComments"] as! String
        let rating = review["rOverall"] as! Float
        
        cell.reviewTitle.text = title
        cell.reviewCourse.text = course
        cell.reviewContent.text = content
        cell.reviewRating.text = "\(rating)"
        cell.reviewRating.textColor = ratingColor(rating: rating)
        return cell
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
