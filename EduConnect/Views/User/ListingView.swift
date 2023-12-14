//
//  ListingView.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 12/3/23.
//

import SwiftUI


struct ListingView: View {
    @EnvironmentObject var manager: Manager
    
    var body: some View {
        VStack {
            Text("Available Listings")
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .bold, design: .rounded))
            List {
                ForEach(manager.listings) {
                    listing in
                    VStack(alignment: .leading) {
                        Text(listing.name).font(.largeTitle)
                        Text("Start: \(Date(timeIntervalSince1970: Double(listing.start)).formatted())")
                        Text("End: \(Date(timeIntervalSince1970: Double(listing.end)).formatted())")
                        Button {
                            //Cancel Request
                        } label: {
                            Text("Book: $\(listing.cost)")
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: 200, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius:10, style: .continuous).fill(.green)
                                )
                        }
                    }
                }
                
            }
        }
    }
}

