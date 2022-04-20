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
* User can rate professors [~]
* User can see professor rating [~]
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
let query = PFQuery(className:"professor")
query.whereKey("department", equalTo: departmentSearchText)
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
let query = PFQuery(className:"professor")
query.whereKey("name", equalTo: nameSearch)
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
### Prof Screen:
- GET all ratings from professor in list
<img src="https://user-images.githubusercontent.com/14352665/163086037-ca4ac95e-af06-44d2-8282-bba503759b38.png" width="200" height="400">

```swift
// (Read/GET) GET “rating” in list of professors
let query = PFQuery(className:"rating")
query.whereKey("professor", equalTo: professor)
query.order(byDescending: "datePosted")
query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
   if let error = error {
      print(error.localizedDescription)
   } else if let posts = posts {
      print("Successfully retrieved \(professors.count) professors.")
      // TODO: Do something with posts...
   }
}
```

Rating Screen:
 <img src="https://media4.giphy.com/media/QOQEzime25L9JXFDyX/giphy.gif?cid=790b7611714dff09968cf0aafeb1ac29332d79a217168945&rid=giphy.gif" width="200" height="400">
- POST new rating object to server for that professor

```swift
        let today = Date()
        let post = PFObject(className: "Rating")
        let rating = Rating()   
        post["dateUploaded"] = today
        post["caption"] = commentField.text!
        post["rating"] = overallRating.value!
        
        post.saveInBackground {(success, error) in
            if success {
                print("Saved post successfully")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Error saving post: \(String(describing: error?.localizedDescription))")
            }
            
        }
```        

