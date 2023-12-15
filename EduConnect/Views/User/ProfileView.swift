//
//  ProfileView.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 12/3/23.
//

import SwiftUI
import FirebaseAuth



struct ProfileView: View {
    @EnvironmentObject var manager: Manager
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var zip = ""
    @State private var age = ""
    @State private var grade: Grade = .K
    @State private var biography = ""
    
    @State private var logoutConfirm = false
    
    @State private var friends: [String] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("My Profile")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                
                TextField("Name", text: $name)
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .textInputAutocapitalization(.never)
                    .frame(width: 350)
                Rectangle().frame(width: 350, height: 1)
                Text("Name")
                                
                
                TextField("Age", text: $age)
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.numberPad)
                    .frame(width: 350)
                Rectangle().frame(width: 350, height: 1)
                Text("Age")
                
                TextField("Zip Code", text: $zip)
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.numberPad)
                    .frame(width: 350)
                Rectangle().frame(width: 350, height: 1)
                Text("ZIP Code")
                
                
                Picker ("Grade",selection: $grade) {
                    ForEach(Grade.allCases, id: \.id) { value in
                        Text(value.description).tag(value)
                    }
                }

                Rectangle().frame(width: 350, height: 1)
                Text("Grade")
                
                
                TextField("Biography", text: $biography)
                    .foregroundColor(.black)
                    .frame(width: 350)
                    .textFieldStyle(PlainTextFieldStyle())
                    .textInputAutocapitalization(.never)
                    .cornerRadius(16)
                    .frame(height:100)

                Rectangle().frame(width: 350, height: 1)
                Text("Biography")
                
                Spacer()
                
                Button {
                    updateProfile()
                } label: {
                    Text("Update Profile")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius:10, style: .continuous).fill(.linearGradient(colors:[.blue], startPoint: .top, endPoint: .bottomTrailing)))
                }
                Button {
                    logoutConfirm.toggle()
                } label: {
                    Text("Log Out")
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius:10, style: .continuous).fill(.linearGradient(colors:[.red], startPoint: .top, endPoint: .bottomTrailing)))
                }
            }
        }
        .onAppear (perform: reload)
        .confirmationDialog("Confirm Logout?", isPresented: $logoutConfirm) {
            Button {
                logout()
            } label: {
                Text("Confirm Log Out")
                    .foregroundColor(.red)
                    .bold()
                    .frame(width: 200, height: 40)
            }

        }
        
    }
    
    func reload() {
        guard !manager.noProfile else {
            name = UserProfile.noProfile.name
            age = String(UserProfile.noProfile.age)
            grade = UserProfile.noProfile.grade
            zip = String(UserProfile.noProfile.zip)
            biography = UserProfile.noProfile.biography
            friends = []
            
            return
        }
        guard let data = manager.loggedInUserData else{
            return
        }
        
        name = data.name
        age = String(data.age)
        grade = grade
        zip =  String(data.zip)
        biography = data.biography
        friends = data.friends
    }
    
    func logout(){
        guard let result = try? Auth.auth().signOut() else {
            print("Failed to log out!")
            return
        }
        reload()
        print("Logged Out!")
    }
    
    func updateProfile(){
        guard name != "" else {
            print("Name cannot be empty")
            return
        }
        guard age != "" else {
            print("Age cannot be empty")
            return
        }
        
        guard zip != "" else {
            print("Zip cannot be empty")
            return
        }
        
        let ageNumber = Int(age) ?? 0
        let zipNumber = Int(zip) ?? 00000
        
        let user = UserProfile(name, ageNumber, grade, zipNumber, biography, friends)
        
        manager.updateProfile(profile: user)
    }
}



