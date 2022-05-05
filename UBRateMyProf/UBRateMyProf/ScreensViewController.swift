//
//  ScreensViewController.swift
//  UBRateMyProf
//
//  Created by Wasif  Khan on 5/3/22.
//

import UIKit
import Parse

class ScreensViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var professors = [PFObject]()
    var profID = 0
    var profName = "NULL"
    @IBOutlet weak var professorSearchBar: UISearchBar!
    
    
    @IBOutlet weak var professorTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationNavigationController = segue.destination as! UINavigationController
        let targetController = destinationNavigationController.viewControllers[0] as! ProfessorViewController
        
        targetController.ProfessorID = profID
        targetController.nameSearch = profName
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        profID = professors[indexPath.row]["ratemyprof_id"] as! Int
        profName = "\(professors[indexPath.row]["first_name"] ?? "") \(professors[indexPath.row]["last_name"] ?? "")"
        performSegue(withIdentifier: "professorViewSegue", sender: self)
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
        let nameCell = tableView.dequeueReusableCell(withIdentifier: "NameTableViewCell") as! NameTableViewCell
        
        let name = "\( self.professors[indexPath.row]["first_name"] ?? "") \(self.professors[indexPath.row]["last_name"] ?? "")"
        nameCell.professorName.text = name
        return nameCell
    }
    
    func searchProfessor(){
        let query = PFQuery(className:"Professors")
        //query.whereKey("last_name", matchesText: professorSearchBar.text ?? "") //OMIT THIS IF JUST PULLING ALL PROFS
        query.order(byAscending: "last_name")
        query.limit = 1000;
        query.whereKey("last_name", contains: professorSearchBar.text)
        query.findObjectsInBackground { (professor: [PFObject]?, error: Error?) in
           if let error = error {
              print(error.localizedDescription)
           } else if let professor = professor {
               self.professors = professor
               print("Successfully retrieved \(self.professors.count) professors.")
              // TODO: Do something with professor list...
               self.professorTableView.reloadData()
           }
        }
    }
    func getProfessor(){
        //query.whereKey("last_name", matchesText: professorSearchBar.text ?? "") //OMIT THIS IF JUST PULLING ALL PROFS
        self.professors = []
        for char in "ABCDEFGHIJKLMNOPQRSTUVWXYZ" {
         let query = PFQuery(className:"Professors")
            query.limit = 1000
            query.whereKey("last_name", hasPrefix: String(char))
            query.order(byAscending: "last_name")
            query.findObjectsInBackground { (professor: [PFObject]?, error: Error?) in
               if let error = error {
                  print(error.localizedDescription)
               } else if let professor = professor {
                   self.professors.append(contentsOf: professor)
                   print("Successfully retrieved \(professor.count) professors.")
                   self.professorTableView.reloadData()
                   print("Successfully retrieved TOTAL: \(self.professors.count) professors.")
                   self.professors = self.professors.sorted { (prof1, prof2) -> Bool in
                               let profName1 = prof1["last_name"] as! String
                               let profName2 = prof2["last_name"] as! String
                               return (profName1.localizedCaseInsensitiveCompare(profName2) == .orderedAscending)
                   }
               }
           }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return professors.count
        }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        professorTableView.dataSource = self
        professorTableView.delegate = self
        professorTableView.estimatedRowHeight = 80
        professorTableView.rowHeight = UITableView.automaticDimension

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool){
            super.viewDidAppear(animated)
            // Get professor info and reviews
            getProfessor()
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
