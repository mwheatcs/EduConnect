//
//  SignInEmailView.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 11/8/23.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    

    func signIn() -> Bool {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return true
        }
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Success")
                return false
            } catch {
                print("Error: \(error)")
                return true
            }
        }
        return true
    }
}


struct SignInEmailView: View {
    @EnvironmentObject private var showSignInView: Authenticated
    
    @StateObject private var viewModel = SignInEmailViewModel()
    
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
            Button {
                showSignInView.NoAuth = viewModel.signIn()
            } label : { Text("Sign In")                .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)}
            Spacer()
        }.navigationTitle("Email Sign-In")  
    }
}
