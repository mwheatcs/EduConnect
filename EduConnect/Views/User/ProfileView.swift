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
    @State private var grade = ""
    
    @State private var logoutConfirm = false
    
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
                                
                TextField("Grade", text: $grade)
                    .foregroundColor(.black)
                    .textFieldStyle(.plain)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.numberPad)
                    .frame(width: 350)
                Rectangle().frame(width: 350, height: 1)
                Text("Grade")
                
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
        .onAppear (perform:
                        {
            guard !manager.noProfile else {
                return
            }
            guard let data = manager.loggedInUserData else{
                return
            }
            
            name = data.name
            age = String(data.age)
            grade = String(data.grade)
            zip =  String(data.zip)
        })
        .confirmationDialog("Confirm Logout?", isPresented: $logoutConfirm) {
            Button {
                
            } label: {
                Text("Cancel")
                    .foregroundColor(.white)
                    .bold()
                    .frame(width: 200, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius:10, style: .continuous).fill(.linearGradient(colors:[.blue], startPoint: .top, endPoint: .bottomTrailing)))
            }
            Button {
                logout()
            } label: {
                Text("Confirm Log Out")
                    .foregroundColor(.white)
                    .bold()
                    .frame(width: 200, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius:10, style: .continuous).fill(.linearGradient(colors:[.red], startPoint: .top, endPoint: .bottomTrailing)))
            }

        }
        
    }

    func logout(){
        guard let result = try? Auth.auth().signOut() else {
            print("Failed to log out!")
            return
        }
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
        
        guard grade != "" else {
            print("Grade cannot be empty")
            return
        }
        
        guard zip != "" else {
            print("Zip cannot be empty")
            return
        }
        
        let ageNumber = Int(age) ?? 0
        let gradeNumber = Int(grade) ?? 0
        let zipNumber = Int(zip) ?? 00000
        
        let user = UserProfile(name, ageNumber, gradeNumber, zipNumber)
        
        manager.updateProfile(profile: user)
    }
}



