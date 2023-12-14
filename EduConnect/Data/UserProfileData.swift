//
//  UserData.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 11/11/23.
//

import Foundation
import FirebaseFirestore


enum Grade: String, Codable, CaseIterable, Identifiable, CustomStringConvertible {
    case K = "K"
    case First = "1st"
    case Second = "2nd"
    case Third = "3rd"
    case Fourth = "4th"
    case Fifth = "5th"
    case Sixth = "6th"
    case Seventh = "7th"
    case Eighth = "8th"
    case Ninth = "9th"
    case Tenth = "10th"
    case Eleventh = "11th"
    case Twelfth = "12th"
    case CollegeFreshman = "College Freshman"
    case CollegeSophomore = "College Sophomore"
    case CollegeJunior = "College Junior"
    case CollegeSenior = "College Senior"
    case CollegeSeniorPlus = "College Senior+"
    case Graduate = "Graduate"
    case None = "None"

    var description: String {
        return rawValue
    }
    
    var id: RawValue {rawValue}
}
class UserProfile: ObservableObject, Codable, Identifiable{
    static let noProfile = UserProfile("No Profile Found", 0, .None, 00000, "")

    @DocumentID var id: String?
    var name: String
    var age: Int
    var grade: Grade
    var zip: Int
    var biography: String
    
    init(_ name: String, _ age: Int, _ grade: Grade, _ zip: Int, _ biography: String) {
        
        self.id = UUID().uuidString
        self.name = name
        self.age = age
        self.grade = grade
        self.zip = zip
        self.biography = biography
    }
    
    
}
