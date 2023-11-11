//
//  LandingPage.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 11/9/23.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var user: AuthDataResultModel
    
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
                user.uid = ""
            } label : { Text("Sign Out")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)}
            Spacer()
        }.onAppear{
            let authUser = try?AuthenticationManager.shared.getAuthenticatedUser()
            user.uid = authUser?.uid ?? " "
            user.email = authUser?.email
            user.photoUrl = authUser?.photoUrl
        }
        .navigationTitle("User Information")
        .fullScreenCover(isPresented: $user.unAuthenticated, content: {
                NavigationStack{
                    AuthenticationView()
                }.environmentObject(user)
            })
    }
}
