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
    
    func signUp() {
        guard !email.isEmpty else {
            print("No email provided")
            return
        }
        
        guard email.contains("@") else {
            print("Invalid email provided")
            return
        }
        
        guard !password.isEmpty else {
            print("No password provided")
            return
        }
        
        guard password == passwordRepeat else {
            print("Passwords do not match")
            return
        }
    
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("Successfully signed up ")
                print(returnedUserData)
            } catch {
                print("Error: \(error)")
            }
        }
    }
}


struct SignUpEmailView: View {
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
                viewModel.signUp()
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

struct SignUpEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SignUpEmailView()
        }
    }
}

