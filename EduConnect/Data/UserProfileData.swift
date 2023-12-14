//
//  UserData.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 11/11/23.
//

import Foundation
import FirebaseFirestore


class UserProfile: ObservableObject, Codable, Identifiable{
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    var age: Int
    var grade: Int
    var zip: Int
    
    init(_ name: String, _ age: Int, _ grade: Int, _ zip: Int) {
        self.id = UUID().uuidString
        self.name = name
        self.age = age
        self.grade = grade
        self.zip = zip
    }
    
    
}
