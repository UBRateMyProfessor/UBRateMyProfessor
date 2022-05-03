Original App Design Project - UBRateMyProfessor
===

# UB Rate My Professor

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
App that allows students to rate their professors, and be able to see a list of ratings for each one. 

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Education?
- **Mobile:** Viewing and rating in a mobile-first UI
- **Story:** Allows users to rate and browse professors.
- **Market:** UB Students
- **Habit:** Users can rate current or previous professors, but the app is most useful during class registration to ensure a good professor pick.
- **Scope:** Narrow focus on UB Professors, so the app is limited to University at Buffalo Students.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**
* ~ = In Progress
* API Set up [X]
* User can search for professors [~]
* User can rate professors [X]
* User can see professor rating [X]
* User can search by courses [~]
* User can search by department [~]


**Optional Nice-to-have Stories**

* Professor Profiles - Courses taught, etc.
* Favorite/Bookmarked professors

### 2. Screen Archetypes

* [Search Screen]
   * [User can search for professors]
   * ...
* [Professor Screen]
   * [User can see professor ratings]
   * ...
* [Rating Screen]
   * [User can leave rating on professor]
   * ...
### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Professors tab
* Majors tab
* Courses tab


## Wireframes
<img src="https://i.imgur.com/Ae1eHv8.png](https://i.imgur.com/Ae1eHv8.png" width=600>


### Professor
| Property       | Type       | Description                          |
| -------------- | ---------- | ------------------------------------ |
| professorName  | string     | Name of the professor                |
| ratings        | Rating\[\] | all of the ratings for the professor |
| courses        | string\[\] | List of course names                 |
| departmentName | string     | The Professor’s Department           |
| ratingVal      | float      | Professor’s overall rating           |

### Rating 
| Property    | Type                      | Description                        |
| ----------- | ------------------------- | ---------------------------------- |
| ratingValue | float                     | Overall rating in stars            |
| courseTaken | string                    | The course id taken                |
| comment     | string                    | The actual comment in the rating   |
| dateMade    | DateTime ( or string idk) | The published date of the comment  |



### Networking

#### Network Requests by screen

### Department Search : 
 - GET “department search” in list of professors
```swift
// (Read/GET) GET “department search” in list of professors
let query = PFQuery(className:"Professors")
query.whereKey("department", equalTo: departmentSearchText)
query.order(byDescending: "Name")
query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
   if let error = error {
      print(error.localizedDescription)
   } else if let posts = posts {
      print("Successfully retrieved \(professors.count) professors.")
      // TODO: Do something with department list...
   }
}
```

### Course Search : 
 - GET “course num search” in list of professors

```swift
// (Read/GET) GET “course search” in list of professors
let query = PFQuery(className:"professor")
query.whereKey("courses", equalTo: courseSearch)
query.order(byDescending: "Name")
query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
   if let error = error {
      print(error.localizedDescription)
   } else if let posts = posts {
      print("Successfully retrieved \(professors.count) professors.")
      // TODO: Do something with posts...
   }
}
```
### Prof Search :
- GET “prof name” in list of Professors
```swift
// (Read/GET) GET “name” in list of professors
let query = PFQuery(className:"Professors")
query.whereKey("last_name", matchesText: nameSearch)
query.order(byDescending: "Name")
query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
   if let error = error {
      print(error.localizedDescription)
   } else if let posts = posts {
      print("Successfully retrieved \(professors.count) professors.")
      // TODO: Do something with professor list...
   }
}
```
### Prof Screen:
<img src="https://i.imgur.com/QMlm7QL.gif" width="200" height="400">
- GET all ratings from professor in list

```swift
// (Read/GET) GET “name” in list of professors
let query = PFQuery(className:"Ratings")
query.whereKey("ratemyprof_id", equalTo: professorID)
query.order(byDescending: "createdAt")
query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
   if let error = error {
      print(error.localizedDescription)
   } else if let reviews = reviews {
      print("Successfully retrieved \(reviews.count) reviews.")
      // TODO: Do something with ratings list...
   }
}
```

Rating Screen:
 <img src="https://i.imgur.com/I0lNwBp.gif" width="200" height="400">
- POST new rating object to server for that professor

```swift
        let rating = PFObject(className: "Ratings")
        let date = Date()
        let formatter = DateFormatter()
        //Formatter Args
        
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
```        

