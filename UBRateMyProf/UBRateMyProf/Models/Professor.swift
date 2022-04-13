//
//  Professor.swift
//  UBRateMyProf
//
//  Created by William Krasnov on 4/13/22.
//

import Foundation
class Professor
{
    var name:String = ""
    var ratings:[Rating] = []
    var courses:[String] = []
    var department:String = ""
    var ratingVal:Float = 0.0
    public func Professor(name:String,ratings:[Rating],courses:[String],department:String,ratingVal:Float){
        self.name = name
        self.ratings = ratings
        self.courses = courses
        self.department = department
        self.ratingVal = ratingVal
    }
}
