//
//  Tab.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 12/3/23.
//

import SwiftUI
import FirebaseAuth

struct Tab: View {
    @EnvironmentObject var manager: Manager
    
    var body: some View {
        NavigationStack{
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                PeopleView()
                    .tabItem {
                        Image(systemName: "person.3.fill")
                        Text("People")
                    }
                ListingView()
                    .tabItem {
                        Image(systemName: "list.bullet.rectangle.portrait.fill")
                        Text("Listings")
                    }
                ScheduleView()
                    .tabItem {
                        Image(systemName: "calendar.circle.fill")
                        Text("Schedule")
                    }
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("My Profile")
                    }
            }                
                .fullScreenCover(isPresented: $manager.loggedOut){
                    AuthView()
                }
                .transaction({ transaction in
                    transaction.disablesAnimations = true
                })
                .fullScreenCover(isPresented: $manager.noProfile){
                    ProfileFirstView()
                }
        }
    }
}
