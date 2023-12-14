//
//  EduConnectApp.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 11/8/23.
//

import SwiftUI
import FirebaseCore

@main
struct EduConnectApp: App {
    @StateObject var manager = Manager()
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                Tab()
            }
        }
        .environmentObject(manager)
        
    }
}
