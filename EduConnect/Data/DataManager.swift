//
//  Manager.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 12/11/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

class Manager: ObservableObject {
    @Published var listings: [ListingData] = []
    @Published var tutoringSessions: [SessionData] = []
    @Published var learningSessions: [SessionData] = []
    @Published var loggedInUserData: UserProfile?
    @Published var userID: String = ""
    @Published var loggedOut : Bool = true
    @Published var noProfile : Bool = false
    
    init() {
        Auth.auth().addStateDidChangeListener{auth, user in
            print("Auth State Changed")
            if user != nil {
                self.fetchUser()
                self.fetchListings()
                self.fetchSessions()
                
                self.loggedOut = false
                
                self.noProfile = self.loggedInUserData == nil
            } else {
                self.loggedOut = true
                self.noProfile = false
            }
        }
    }
    
    func updateProfile(profile: UserProfile) {
        let db = Firestore.firestore()

        let collection = db.collection("Profile")
        let document = collection.document(self.userID)
        do {
            try document.setData(from: profile)
        } catch {
            print("Failed to set profile!")
        }
    }
    
    func fetchUser() {
        let db = Firestore.firestore()

        guard let id = Auth.auth().currentUser?.uid else {
            print("No User to get!")
            return
        }
        
        self.userID = id
        
        db.collection("Profile").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No Profiles")
                return
            }
            
            for document in documents {
                if document.documentID == id {
                    self.loggedInUserData = try? document.data(as: UserProfile.self)
                    self.noProfile = self.loggedInUserData == nil
                }
            }

        }
        print("No profile exists for authenticated user")
        return
    }
    
    func fetchListings() {
        listings.removeAll()
        let db = Firestore.firestore()
        
        db.collection("Listings").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No Listings")
                return
            }
            
            self.listings = documents.compactMap { (queryDocumentSnapshot) -> ListingData? in
                return try? queryDocumentSnapshot.data(as: ListingData.self)
            }
        }
    }
    
    func fetchSessions() {
        tutoringSessions.removeAll()
        learningSessions.removeAll()
        
        let db = Firestore.firestore()
        
        guard let name = self.loggedInUserData?.name else {
            print("No Profile")
            return
        }
        db.collection("Sessions").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No Listings")
                return
            }
            
            for document in documents {
                if let sessionData = try?document.data(as: SessionData.self) {
                    if sessionData.tutor == name {
                        self.tutoringSessions.append(sessionData)
                    } else if sessionData.student == name {
                        self.learningSessions.append(sessionData)
                    }
                }
            }
        }
    }
}
    
