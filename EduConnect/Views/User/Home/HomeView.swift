//
//  HomeView.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 12/3/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var manager: Manager
    
    @State var showNotifications = false

    var body: some View {
        VStack{
            HStack {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)

                Spacer()
                Text("Home")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                Spacer()
                Button {
                    showNotifications = true
                } label: {
                    Image(systemName: "bell.badge.fill")
                    .frame(width: 50, height: 50)

                }
            }
            Text("Welcome back, \(manager.loggedInUserData?.name ?? "")!")
                .font(.system(size: 18, weight: .bold, design: .rounded))

            Spacer()
        }                
        .fullScreenCover(isPresented: $showNotifications){
            NotificationView
        }
    }
    
    var NotificationView: some View {
        VStack {
            HStack {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)

                Spacer()
                Text("Notifications")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                Spacer()
                Button {
                    showNotifications = false
                } label: {
                    Image(systemName: "x.circle.fill")
                    .frame(width: 50, height: 50)
                }
            }
            List {
                //Iterate through notification
            }
        }
        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
    }
}
