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
        formatter.dateFormat = "M"
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
                self.UpdateRating()
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Error saving rating: \(String(describing: error?.localizedDescription))")
            }
            
        }
    }
    
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func UpdateRating(){
        let queryReviews = PFQuery(className:"Ratings")
        queryReviews.whereKey("ratemyprof_id", equalTo: self.professorID ?? 0)
        queryReviews.findObjectsInBackground { (reviews: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let reviews = reviews {
                print("Successfully retrieved \(reviews.count) reviews.")
                var sum = 0;
                for x in reviews {
                    sum += x.value(forKey: "rOverall") as! Int
                }
                let average = Float(sum) / Float(reviews.count)
                print("average is \(average)")
                let queryProfessor = PFQuery(className:"Professors")
                queryProfessor.whereKey("ratemyprof_id", equalTo: self.professorID ?? 0)
                queryProfessor.findObjectsInBackground { [self] (professors: [PFObject]?, error: Error?) in
                    if let error = error {
                        print(error.localizedDescription)
                    }else if let professors=professors {
                        print("Successfully retrieved \(professors.count) professors.")
                        for x in professors {
                            x.setValue(average, forKey: "overall_rating")
                            x.saveEventually()
                        }
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Reviewing: \(self.professorID ?? 0)"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil);
        }

        @objc func keyboardWillShow() {
             self.view.frame.origin.y = -150 // Move view 150 points upward
        }

        @objc func keyboardWillHide() {
             self.view.frame.origin.y = 0 // Move view to original position
        }
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        reviewLabel.resignFirstResponder()
        courseLabel.resignFirstResponder()
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
