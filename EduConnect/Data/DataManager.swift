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
    @Published var requests: [String] = []
    @Published var friends: [UserProfile] = []
    @Published var listings: [ListingData] = []
    @Published var myListings: [ListingData] = []
    @Published var tutoringSessions: [SessionData] = []
    @Published var learningSessions: [SessionData] = []
    @Published var userProfiles: [String: UserProfile] = [:]
    @Published var loggedInUserData: UserProfile?
    @Published var userID: String = ""
    @Published var loggedOut : Bool = true
    @Published var noProfile : Bool = false
    
    init() {
        Auth.auth().addStateDidChangeListener{auth, user in
            if user != nil {
                self.fetchUserProfiles()
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

  
    func removeSession(docID: String) {
        let db = Firestore.firestore()
        
        let document = db.collection("Session").document(docID)

        document.delete()
    }
    
    func createSession(sessionData: SessionData){
        let db = Firestore.firestore()
        
        let document = db.collection("Session").document()

        do {
            try document.setData(from: sessionData)
        } catch {
            print("Failed to create session!")
        }
    }
    
    func addFriend(id: String){
        let db = Firestore.firestore()
        
        guard var otherUserNewFriends = self.userProfiles[id]?.friends else {
            print("User doesn't exist")
            return
        }
        
        otherUserNewFriends.append(userID)
        db.collection("Profile").document(id).updateData(["friends":otherUserNewFriends])

        
        var currentUserNewFriends = loggedInUserData?.friends ?? []
        currentUserNewFriends.append(id)
        db.collection("Profile").document(userID).updateData(["friends" : currentUserNewFriends])
        
    }
    func removeListing(docID: String) {
        let db = Firestore.firestore()
        
        let document = db.collection("Listings").document(docID)

        document.delete()
    }
    
    func createListing(listingData: ListingData) {
        let db = Firestore.firestore()
        
        let document = db.collection("Listings").document()
        do {
            try document.setData(from: listingData)
        } catch {
            print("Failed to create listing!")
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
                    return
                }
            }
            
        }
        print("No profile exists for authenticated user")
        self.noProfile = self.loggedInUserData == nil
        return
    }
    
    func getUserProfile(fromID: String) -> UserProfile {
        return self.userProfiles[fromID] ?? UserProfile.noProfile
    }
    
    func fetchUserProfiles() {
        let db = Firestore.firestore()
        
        
        db.collection("Profile").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No Profiles")
                return
            }
            
            for document in documents {
                self.userProfiles[document.documentID] = try? document.data(as: UserProfile.self)
            }
        }
    }
    
    func fetchListings() {
        let db = Firestore.firestore()
        
        db.collection("Listings").addSnapshotListener { (querySnapshot, error) in
            self.listings.removeAll()
            self.myListings.removeAll()
            
            guard let documents = querySnapshot?.documents else {
                print("No Listings")
                return
            }
            for document in documents {
                if let listingData = try?document.data(as: ListingData.self) {
                    if listingData.tutor == self.userID {
                        self.myListings.append(listingData)
                    }else {
                        self.listings.append(listingData)
                    }
                }
            }
        }
    }
        func fetchSessions() {
            let db = Firestore.firestore()
            
            db.collection("Session").addSnapshotListener { (querySnapshot, error) in
                self.tutoringSessions.removeAll()
                self.learningSessions.removeAll()
                
                guard let documents = querySnapshot?.documents else {
                    print("No Listings")
                    return
                }
                
                for document in documents {
                    if let sessionData = try?document.data(as: SessionData.self) {
                        print(sessionData.tutor)
                        print(sessionData.student)
                        if sessionData.tutor == self.userID {
                            self.tutoringSessions.append(sessionData)
                            print("tutor")
                        } else if sessionData.student == self.userID {
                            self.learningSessions.append(sessionData)
                            print("student")
                        }
                    }
                }
            }
        }
}
