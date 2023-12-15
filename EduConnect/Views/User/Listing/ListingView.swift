//
//  ListingView.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 12/3/23.
//

import SwiftUI


struct ListingView: View {
    @EnvironmentObject var manager: Manager
    @State var showAddListing = false
    
    @State private var toastData = ToastDataModel(title: "Success", image: "checkmark", color: .white)
    @State private var showToast = false

    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                        .frame(width: 50, height: 50)
                }
                
                Spacer()
                
                Text("Available Listings")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                Spacer()
                Button {
                    showAddListing.toggle()
                } label: {
                    Image(systemName: "plus.app")
                        .frame(width: 50, height: 50)
                }
            }
            List {
                ForEach(manager.myListings) {
                    listing in
                    VStack(alignment: .leading) {
                        var subjects = {() -> String in
                            var out = ""
                            for subject in listing.subjects {
                                out += subject.humanReadableDescription + " "
                            }
                            return out
                        }()
                        Text("My Listing")
                            .font(.largeTitle)
                        
                        Text("Start: \(Date(timeIntervalSince1970: Double(listing.start)).formatted())")
                        Text("End: \(Date(timeIntervalSince1970: Double(listing.end)).formatted())")
                        Text("Subjects: \(subjects)")
                        Text(String(format: "Price: %.2f", listing.totalCost))
                        Button {
                            removeListing(id: listing.id)
                        } label: {
                            Text("Remove Listing")
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: 200, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius:10, style: .continuous).fill(.red)
                                )
                        }
                    }
                }
                ForEach(manager.listings) {
                    listing in
                    VStack(alignment: .leading) {
                        var subjects = {() -> String in
                            var out = ""
                            for subject in listing.subjects {
                                out += subject.humanReadableDescription + " "
                            }
                            return out
                        }()
                        Text(manager.getUserProfile(fromID: listing.tutor).name)
                            .font(.largeTitle)
            
                        Text("Start: \(Date(timeIntervalSince1970: Double(listing.start)).formatted())")
                        Text("End: \(Date(timeIntervalSince1970: Double(listing.end)).formatted())")
                        Text("Subjects: \(subjects)")
                        Text(String(format: "Price: %.2f", listing.totalCost))
                        Button {
                            reserveListing(listing: listing)
                        } label: {
                            Text(String(describing: listing.availability))
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
        .fullScreenCover(isPresented: $showAddListing){
            AddListingView()
        }
        .toast(toastView: Toast(dataModel: toastData, show: $showToast), show: $showToast)
    }
        
    func removeListing(id: String?){
        if let docID =  id {
            manager.removeListing(docID: docID)
            toastData = ToastDataModel(title: "Listing successfully removed!", image: "checkmark", color: .green)
            showToast.toggle()
        }
    }
    
    func reserveListing(listing: ListingData){
        if let docID =  listing.id {
            manager.removeListing(docID: docID)
            manager.createSession(sessionData: SessionData(tutor: listing.tutor, student: manager.userID, start: listing.start, end: listing.end, rate: listing.rate, subjects: listing.subjects))
            toastData = ToastDataModel(title: "Listing successfully reserved!", image: "checkmark", color: .green)
            showToast.toggle()
        }
    }
    
}


