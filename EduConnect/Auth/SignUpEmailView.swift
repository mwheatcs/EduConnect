//
//  SignInEmailView.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 11/8/23.
//

import SwiftUI

@MainActor
final class SignUpEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var passwordRepeat = ""
    //TODO: Add data types and initialize with firestore on separate or this view
    
    func signUp() -> Bool{
        guard !email.isEmpty else {
            print("No email provided")
            return true
        }
        
        guard email.contains("@") else {
            print("Invalid email provided")
            return true
        }
        
        guard !password.isEmpty else {
            print("No password provided")
            return true
        }
        
        guard password == passwordRepeat else {
            print("Passwords do not match")
            return true
        }
    
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Successfully signed up ")
                print(returnedUserData)
                return false
            } catch {
                print("Error: \(error)")
                return true
            }
        }
        return true
    }
}


struct SignUpEmailView: View {
    @EnvironmentObject private var showSignInView: AuthDataResultModel

    @StateObject private var viewModel = SignUpEmailViewModel()

    var body: some View {
        VStack {
            TextField("Email Address", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
            SecureField("Repeat Password", text: $viewModel.passwordRepeat)
                .padding()
                .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
            Button {
                showSignInView.NoAuth = viewModel.signUp()
            } label : { Text("Sign Up")                .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)}
            Spacer()
        }.navigationTitle("User Registration")
    }
}


