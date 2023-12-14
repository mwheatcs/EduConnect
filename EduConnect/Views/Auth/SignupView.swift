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
                
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [.blue, .green], startPoint: .topTrailing, endPoint: .bottomLeading))
                    .frame(width: 1000, height: 1000)
                
                VStack(spacing: 20) {
                    Text("Registration")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .offset(x: -75, y: -100)
                    
                    TextField("Email", text: $email)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)

                    Rectangle().frame(width: 350, height: 1)
                    
                    SecureField("Password", text: $password)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
       
                    Rectangle().frame(width: 350, height: 1)

                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .foregroundColor(.white)
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
            .ignoresSafeArea()
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
    

