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

* User can search for professors
* User can rate professors


**Optional Nice-to-have Stories**

* Professor Profiles - Courses taught, etc.
* Favorite/Bookmarked professors

### 2. Screen Archetypes

* [Search Screen]
   * [User can search for professors]
   * ...
* [Professor Screen]
   * [list associated required story here]
   * ...
* [Rating Screen]
   * [list associated required story here]
   * ...
### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Professors tab
* Majors tab
* Courses tab


## Wireframes
<img src="https://i.imgur.com/Ae1eHv8.png](https://i.imgur.com/Ae1eHv8.png" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]

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

### Course Search : 
 - GET “course num search” in list of professors

### Prof Search :
- GET “prof name” in list of Professors

### Prof Screen:
- GET all ratings from professor in list

Rating Screen:
- POST new rating object to server for that professor
  
  

- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
