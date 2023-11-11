//
//  AuthenticationView.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 11/8/23.
//

import SwiftUI

class Authenticated: ObservableObject {
    public var NoAuth: Bool = true
}

struct AuthenticationView: View {
    @EnvironmentObject private var showSignInView: Authenticated
    
    var body: some View {
        VStack {
            Spacer()
            NavigationLink{
                SignInEmailView()
            } label: {
                Text("Sign in with Email")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
            }.environmentObject(showSignInView)
            Text("OR")
            NavigationLink{
                SignUpEmailView()
            } label: {
                Text("Register with Email")
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(10)
            }.environmentObject(showSignInView)
            Spacer()
        }.navigationTitle("Login or Register")
        Spacer()
    }
}

