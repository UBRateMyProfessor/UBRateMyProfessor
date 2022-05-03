//
//  ReviewViewController.swift
//  UBRateMyProf
//
//  Created by Tawhidur Rahman on 4/27/22.
//

import UIKit
import Parse

class ReviewViewController: UIViewController {
    
    var professorID: Int!
    
    @IBOutlet weak var courseLabel: UITextField!
    
    @IBOutlet weak var reviewLabel: UITextField!
    
    @IBOutlet weak var difficultyRating: UISegmentedControl!
    
    @IBOutlet weak var preparednessRating: UISegmentedControl!
    
    @IBOutlet weak var paceOfCourseRating: UISegmentedControl!
    
    @IBOutlet weak var overallRating: UISegmentedControl!
    
    @IBAction func submitButton(_ sender: Any) {
        let rating = PFObject(className: "Ratings")
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yy"
        let year = formatter.string(from: date)
        formatter.dateFormat = "MM"
        let month = formatter.string(from: date)
        formatter.dateFormat = "d"
        let day = formatter.string(from: date)
        let formattedDate = "\(month)/\(day)/\(year)"
        
        rating["ratemyprof_id"] = professorID
        rating["rClass"] = courseLabel.text!
        rating["rComments"] = reviewLabel.text!
        rating["rOverall"] = overallRating.selectedSegmentIndex+1 //(not too sure here)
        rating["rPreparedness"] = preparednessRating.selectedSegmentIndex+1
        rating["rPace"] = paceOfCourseRating.selectedSegmentIndex+1
        rating["rDate"] = formattedDate
        
        rating.saveInBackground {(success, error) in
            if success {
                print("Saved rating successfully")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Error saving rating: \(String(describing: error?.localizedDescription))")
            }
            
        }
    }
    
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    func updateProfRating(){
        let queryProfessor = PFQuery(className:"Professors")
        queryProfessor.whereKey("ratemyprof_id", equalTo: professorID)
        queryProfessor.order(byDescending: "Name")
        queryProfessor.findObjectsInBackground { [self] (professors: [PFObject]?, error: Error?) in
           if let error = error {
              print(error.localizedDescription)
           }else if let professors=professors {
               print("Successfully retrieved \(professors.count) professors.")
               let rating = professors[0]["overall_rating"]
               //TODO UPDATE RATING BASED ON ALL OTHER RATINGS
           }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Reviewing: \(professorID ?? 0)"
    

        // Do any additional setup after loading the view.
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
