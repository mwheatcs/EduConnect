//
//  SessionData.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 12/11/23.
//

import Foundation
import FirebaseFirestore

struct SessionData: Identifiable, Codable{
    @DocumentID var id: String? = UUID().uuidString
    var tutor: String
    var student: String
    var start: Int
    var end: Int
    var rate: Float
    var subject: String
    
    init(tutor: String, student: String, start: Int, end: Int, rate: Float, subject: String) {
        self.tutor = tutor
        self.student = student
        self.start = start
        self.end = end
        self.rate = rate
        self.subject = subject
    }
}
