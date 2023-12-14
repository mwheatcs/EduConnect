//
//  HomeView.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 12/3/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var manager: Manager

    var body: some View {
        VStack{
            
            Text("Welcome back, \(manager.loggedInUserData?.name ?? "")!")
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .bold, design: .rounded))
            Spacer()
        }
    }
}
