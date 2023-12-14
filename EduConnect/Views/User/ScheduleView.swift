//
//  ScheduleView.swift
//  EduConnect
//
//  Created by Mathew Wheatley on 12/3/23.
//

import SwiftUI


struct ScheduleView: View {
    @EnvironmentObject var manager: Manager
    var body: some View {
        VStack {
            Text("Your Scheduled Appointments")
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .bold, design: .rounded))
            
                List {
                    //Start with tutoring
                    ForEach(manager.tutoringSessions) {
                        session in
                        VStack(alignment: .leading) {
                            Text("Student: \(session.student)").font(.largeTitle)
                            Text("Start: \(Date(timeIntervalSince1970: Double(session.start)).formatted())")
                            Text("End: \(Date(timeIntervalSince1970: Double(session.end)).formatted())")
                            Button {
                                //Cancel Request
                            } label: {
                                Text("Request Cancellation")
                                    .foregroundColor(.white)
                                    .bold()
                                    .frame(width: 200, height: 40)
                                    .background(
                                        RoundedRectangle(cornerRadius:10, style: .continuous).fill(.red)
                                    )
                            }
                        }
                    }
                    ForEach(manager.learningSessions) {
                        session in
                        VStack(alignment: .leading) {
                            Text("Tutor: \(session.tutor)").font(.largeTitle)
                            Text("Start: \(Date(timeIntervalSince1970: Double(session.start)).formatted())")
                            Text("End: \(Date(timeIntervalSince1970: Double(session.end)).formatted())")
                            Button {
                                //Cancel Request
                            } label: {
                                Text("Request Cancellation")
                                    .foregroundColor(.white)
                                    .bold()
                                    .frame(width: 200, height: 40)
                                    .background(
                                        RoundedRectangle(cornerRadius:10, style: .continuous).fill(.red)
                                    )
                            }
                        }
                    }
                }
            }
    }
}
