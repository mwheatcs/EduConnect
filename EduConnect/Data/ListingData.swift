//
//  ListingData.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 12/11/23.
//
import Foundation
import FirebaseFirestore

enum Subject: String, Codable, CaseIterable, Identifiable {
    case Math = "Math"
    case Science = "Science"
    case Reading = "Reading"
    case Writing = "Writing"
    case Technology = "Technology"
    case History = "History"
    case Music = "Music"
    case Geography = "Geography"
    case Art = "Art"
    
    var id: String { self.rawValue }
    
    var humanReadableDescription: String {
        return self.rawValue
    }
}

enum ListingVisibility: String, Codable, CaseIterable, Identifiable {
    case Friends = "Friends"
    case Associates = "Associates"
    case Everyone = "Everyone"
    
    var id: String { self.rawValue }
    
    var humanReadableDescription: String {
        return self.rawValue
    }
}

enum ScheduleMethod: String, Codable, CaseIterable, Identifiable {
    case Request = "Request Only"
    case OnDemand = "On Demand"
    
    var id: String { self.rawValue }
    
    var humanReadableDescription: String {
        return self.rawValue
    }
}

struct ListingData: Identifiable, Codable {
    @DocumentID var id: String?
    var tutor: String

    var rate: Float
    var subjects: [Subject]
    
    var start: Int
    var end: Int
    var minimumTime: Int = 15
    
    var visbility: ListingVisibility = .Everyone
    var availability: ScheduleMethod = .OnDemand
    
    var notes: String = ""
    
    var totalCost: Float {
        return rate * Float(start - end) / 3600
    }
    
    init(tutor: String, start: Int, end: Int, rate: Float, subjects: [Subject]) {
        self.tutor = tutor
        self.start = start
        self.end = end
        self.rate = rate
        self.subjects = subjects
    }
}
