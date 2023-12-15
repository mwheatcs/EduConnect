//
//  AuthView.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 11/9/23.
//

import SwiftUI
import FirebaseAuth

struct AuthView: View {
    @EnvironmentObject var manager: Manager
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var toastData = ToastDataModel(title: "Success", image: "checkmark", color: .white)
    @State private var showToast = false
    
    var body: some View {
        NavigationView{
            ZStack {
                VStack(spacing: 20) {
                    Text("EduConnect")
                        .foregroundColor(.green)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                    Image("BookIcon")
                        .background(.opacity(0))

                    Spacer()
                    TextField("Email", text: $email)
                        .foregroundColor(.black)
                        .textFieldStyle(.plain)
                        .textInputAutocapitalization(.never)
                        .offset(x: 20)

                    Rectangle().frame(width: 350, height: 1)
                    
                    SecureField("Password", text: $password)
                        .foregroundColor(.black)
                        .textFieldStyle(.plain)
                        .offset(x: 20)
                    
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
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("First time? Register here!")
                            .bold()
                            .foregroundColor(.blue)
                    }
                    Spacer()
                }
            }
            .toast(toastView: Toast(dataModel: toastData, show: $showToast), show: $showToast)
        }
    }

    
    func login(){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
                toastData = ToastDataModel(title: "Incorrect username or password!", image: "xmark.seal", color: .red)
                showToast.toggle()
                return
            } else {
                toastData = ToastDataModel(title: "Succesfully Logged in!", image: "checkmark.seal", color: .green)
                showToast.toggle()
            }
        }


    }
}
extension UIImage {
    func imageWith(newSize: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
        
        return image.withRenderingMode(renderingMode)
    }
}


