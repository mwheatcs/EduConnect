//
//  ListingData.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 12/11/23.
//
import Foundation
import FirebaseFirestore

struct ListingData: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    var start: Int
    var end: Int
    var rate: Float
    var subject: String
    
    var cost: Float {
        return rate * Float((end - start))/3600
    }
    
    init(name: String, start: Int, end: Int, rate: Float, subject: String) {
        self.name = name
        self.start = start
        self.end = end
        self.rate = rate
        self.subject = subject
    }
}
