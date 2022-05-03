//
//  ReviewViewController.swift
//  UBRateMyProf
//
//  Created by Tawhidur Rahman on 4/27/22.
//

import UIKit
import Parse

class ReviewViewController: UIViewController {
    
    @IBOutlet weak var professorID: UINavigationItem!
    @IBOutlet weak var courseLabel: UITextField!
    
    @IBOutlet weak var reviewLabel: UITextField!
    
    @IBOutlet weak var difficultyRating: UISegmentedControl!
    
    @IBOutlet weak var preparednessRating: UISegmentedControl!
    
    @IBOutlet weak var paceOfCourseRating: UISegmentedControl!
    
    @IBOutlet weak var overallRating: UISegmentedControl!
    
    @IBAction func submitButton(_ sender: Any) {
        let rating = PFObject(className: "Ratings")
        rating["ratemyprof_id"] = professorID.title
        rating["rClass"] = courseLabel.text!
        rating["rComments"] = reviewLabel.text!
        rating["rOverall"] = overallRating.selectedSegmentIndex+1 //(not too sure here)
        rating["rPreparedness"] = preparednessRating.selectedSegmentIndex+1
        rating["rPace"] = paceOfCourseRating.selectedSegmentIndex+1
        
        
        rating.saveInBackground {(success, error) in
            if success {
                print("Saved rating successfully")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Error saving rating: \(String(describing: error?.localizedDescription))")
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    

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
