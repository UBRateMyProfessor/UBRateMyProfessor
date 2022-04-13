//
//  Rating.swift
//  UBRateMyProf
//
//  Created by William Krasnov on 4/13/22.
//

import Foundation
class Rating
{
    var ratingValue:Float = 0.0
    var courseTaken:String = ""
    var comment:String = ""
    var dateMade:Date = Date()
    public func Rating(ratingVal:Float,coursesTaken:String,comment:String,dateMade:Date){
        self.ratingValue = ratingVal
        self.courseTaken = coursesTaken
        self.comment = comment
        self.dateMade = dateMade
    }

}
