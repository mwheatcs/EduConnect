//
//  SessionData.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 12/11/23.
//

import Foundation
import FirebaseFirestore

struct SessionData: Identifiable, Codable{
    @DocumentID var id: String?
    var tutor: String
    var student: String
    var start: Int
    var end: Int
    var rate: Float
    var subjects: [Subject]
    
    var totalCost: Float {
        return abs(rate * Float(start - end) / 3600)
    }
    
    init(tutor: String, student: String, start: Int, end: Int, rate: Float, subjects: [Subject]) {
        self.tutor = tutor
        self.student = student
        self.start = start
        self.end = end
        self.rate = rate
        self.subjects = subjects
    }
}
