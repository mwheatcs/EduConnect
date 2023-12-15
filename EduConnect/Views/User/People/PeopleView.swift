//
//  PeopleView.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 12/13/23.
//

import SwiftUI

struct PeopleView: View {
    @EnvironmentObject var manager: Manager
    
    @State var showAddFriend: Bool = false
     
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                        .frame(width: 50, height: 50)

                }
                Spacer()
                Text("My People")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "person.fill.badge.plus")
                        .frame(width: 50, height: 50)
                }
            }
            Button {
                
            } label: {
                
            }
            List {
                
            }
        }
    }
}


