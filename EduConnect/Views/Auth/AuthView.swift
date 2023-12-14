//
//  AuthView.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 11/9/23.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView{
            ZStack {
                
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [.blue, .green], startPoint: .topTrailing, endPoint: .bottomLeading))
                    .frame(width: 1000, height: 1000)
                
                VStack(spacing: 20) {
                    Text("Welcome")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .offset(x: -100, y: -100)
                    
                    TextField("Email", text: $email)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)

                    Rectangle().frame(width: 350, height: 1)
                    
                    SecureField("Password", text: $password)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)

                    
                    Rectangle().frame(width: 350, height: 1)
                    
                    Button {
                        login()
                    } label: {
                        Text("Login")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius:10, style: .continuous).fill(.linearGradient(colors:[.green], startPoint: .top, endPoint: .bottomTrailing)))
                    }
                    .padding(.top)
                    .offset(y: 100)
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("First time? Register here!")
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                .frame(width:350)
            }
            .ignoresSafeArea()
        }
    }

    
    func login(){
        print("\(email) + \(password)")
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            print(result)
        }
    }
}
