//
//  ProfileFirstView.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 12/13/23.
//

import SwiftUI

struct ProfileFirstView: View {
    @EnvironmentObject var manager: Manager
    @State private var name = ""
    @State private var zip = ""
    @State private var age = ""
    @State private var grade : Grade = .K
    
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack(spacing: 20) {
                    Text("Profile Setup")
                        .foregroundColor(.black)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .offset(x: -50, y: -100)
                    
                    TextField("Name", text: $name)
                        .foregroundColor(.black)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)

                    Rectangle().frame(width: 350, height: 1)
                    
                    
                    TextField("Age", text: $age)
                        .foregroundColor(.black)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.numberPad)
       
                    Rectangle().frame(width: 350, height: 1)

                    TextField("Zip Code", text: $zip)
                        .foregroundColor(.black)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.numberPad)

                    Rectangle().frame(width: 350, height: 1)
                    
                    HStack{
                        Text("Grade")
                        Picker ("Grade",selection: $grade) {
                            ForEach(Grade.allCases, id: \.id) { value in
                                Text(value.description).tag(value)
                            }
                        }
                    }
                    
                    Button {
                        setupProfile()
                    } label: {
                        Text("Register")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius:10, style: .continuous).fill(.linearGradient(colors:[.green], startPoint: .top, endPoint: .bottomTrailing)))
                    }
                }
                .frame(width:350)
                }
            }
        }
    func setupProfile(){
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
        
        let user = UserProfile(name, ageNumber, grade, zipNumber, "")
        
        manager.updateProfile(profile: user)
    }
}
