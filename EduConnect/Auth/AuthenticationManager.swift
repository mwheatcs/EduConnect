//
//  AuthenticationManager.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 11/8/23.
//

import SwiftUI
import FirebaseAuth

class AuthDataResultModel: ObservableObject {
    var uid: String
    var email: String?
    var photoUrl: String?
    
    public var unAuthenticated: Bool{
        get{
            return uid == ""
        }
        
        set{
            print(newValue)
        }
    }
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthenticationManager {
    static var shared: AuthenticationManager = AuthenticationManager()
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let authDataResult = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: authDataResult)
    }
}
