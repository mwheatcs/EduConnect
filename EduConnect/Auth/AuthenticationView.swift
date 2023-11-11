//
//  AuthenticationView.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 11/8/23.
//

import SwiftUI


struct AuthenticationView: View {
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
            }
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
            }
            Spacer()
        }.navigationTitle("Login or Register")
        Spacer()
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AuthenticationView()
        }
    }
}
