//
//  SignupView.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 11/9/23.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 20) {
                    Spacer()
                    Text("Registration")
                        .foregroundColor(.green)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                    Spacer()
                    
                    TextField("Email", text: $email)
                        .foregroundColor(.black)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)

                    Rectangle().frame(width: 350, height: 1)
                    
                    SecureField("Password", text: $password)
                        .foregroundColor(.black)
                        .textFieldStyle(.plain)
       
                    Rectangle().frame(width: 350, height: 1)

                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .foregroundColor(.black)
                        .textFieldStyle(.plain)

                    Rectangle().frame(width: 350, height: 1)
                    
                    Button {
                        register()
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
    func register(){
        guard password == confirmPassword else {
            print("Passwords don't match")
            return
        }
            
        Auth.auth().createUser(withEmail: email, password: password) {
            result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}
    

