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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 150
        
    
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // (Read/GET) GET “name” in list of professors
        let query = PFQuery(className:"Professors")
        query.whereKey("last_name", matchesText: nameSearch)
        query.order(byDescending: "Name")
        query.findObjectsInBackground { (professors: [PFObject]?, error: Error?) in
           if let error = error {
              print(error.localizedDescription)
           } else if let professors=professors {
              print("Successfully retrieved \(professors.count) professors.")
              // TODO: Do something with professor list...
           }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewCell
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
