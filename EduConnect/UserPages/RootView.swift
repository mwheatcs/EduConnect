//
//  LandingPage.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 11/9/23.
//

import SwiftUI

struct RootView: View {
    @State private var showSignInView: Bool = false
    
    @Environment private var user: AuthDataResultModel

    var body: some View {
        VStack {
            //TODO: Add image
            //Image(URL(string: user.photo))?
            Text("Email Address: \(user.email ?? "")")
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Text("ID: \(user.uid)")
                .padding()
                .background(Color.gray.opacity(0.4))
                    .cornerRadius(10)
            
            //TODO: Add other user information
            Button {
                showSignInView = true
            } label : { Text("Sign Out")                .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)}
            Spacer()
        }.onAppear(
            let authuser = AuthenticationManager.shared.si
        )
        .navigationTitle("User Information")
            .fullScreenCover(isPresented: $showSignInView, content: {
                NavigationStack{
                    AuthenticationView()
                }
            })
    }
}
