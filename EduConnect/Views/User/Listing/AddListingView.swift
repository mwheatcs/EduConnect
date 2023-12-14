//
//  AddListingView.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 12/13/23.
//

import SwiftUI

struct AddListingView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var manager: Manager
    @State private var start = Date().addingTimeInterval(86400)
    @State private var end = Date().addingTimeInterval(86400)
    @State private var rate = "20"
    
    @State private var subjects = Set<Subject>()
    @State private var minimumTime = "15"
    @State private var availability : ScheduleMethod = .OnDemand
    @State private var visibility: ListingVisibility = .Everyone
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Add New Listing")
                    .foregroundColor(.black)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                
                DatePicker(
                    "Start Date",
                     selection: $start,
                     displayedComponents: [.date, .hourAndMinute]
                )
                Rectangle().frame(width: 350, height: 1)

                DatePicker(
                    "End Date",
                     selection: $end,
                     displayedComponents: [.date, .hourAndMinute]
                )
                
                Rectangle().frame(width: 350, height: 1)
                HStack{
                    Text("Availability ")
                    Picker ("Availability",selection: $availability) {
                        ForEach(ScheduleMethod.allCases, id: \.id) { value in
                            Text(value.humanReadableDescription).tag(value.id)
                        }
                    }
                }
                
                Rectangle().frame(width: 350, height: 1)
                HStack{
                    Text("Visibility ")
                    Picker ("Visiblity",selection: $visibility) {
                        ForEach(ListingVisibility.allCases, id: \.id) { value in
                            Text(value.humanReadableDescription).tag(value.id)
                        }
                    }
                }

                
                Rectangle().frame(width: 350, height: 1)
                HStack{
                    Text("Min Time ")
                    TextField("Mimum Time Slot", text: $minimumTime).keyboardType(.numberPad)
                }
                
                Rectangle().frame(width: 350, height: 1)
                HStack{
                    Text("Rate ")
                    TextField("Hourly Rate", text: $rate).keyboardType(.numberPad)
                }
                
                Rectangle().frame(width: 350, height: 1)
                                
                Menu("Subjects") {
                    ForEach(Subject.allCases, id: \.id) { value in
                        Button{
                            if subjects.contains(value) {
                                subjects.remove(value)
                            } else {
                                subjects.insert(value)
                            }
                        } label: {
                            HStack{
                                if subjects.contains(value) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                        .animation(.easeIn)
                                } else {
                                    Image(systemName: "circle")
                                        .foregroundColor(.primary)
                                        .animation(.easeOut)
                                }
                                Text(String(value.humanReadableDescription))
                            }
                        }
                    }
                }
                
                
                Button {
                    createListing()
                } label: {
                    Text("Create Listing")
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
    
    func createListing() {
        var payRate = Float(rate) ?? 20.0
        var subjectArray = Array(subjects)
        manager.createListing(listingData: ListingData(tutor: manager.userID, start: Int(start.timeIntervalSince1970), end: Int(end.timeIntervalSince1970), rate: payRate, subjects: subjectArray))
        dismiss()
    }

        
}




