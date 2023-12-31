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
                            var subjects = {() -> String in
                                var out = ""
                                for subject in session.subjects {
                                    out += subject.humanReadableDescription + " "
                                }
                                return out
                            }()
                            
                            Text("Student: \(manager.getUserProfile(fromID: session.student).name)").font(.largeTitle)
                            Text("Start: \(Date(timeIntervalSince1970: Double(session.start)).formatted())")
                            Text("End: \(Date(timeIntervalSince1970: Double(session.end)).formatted())")
                            Text("Subjects: \(subjects)")
                            Text(String(format: "Price: %.2f", session.totalCost))
                            Button {
                                cancelSession(id: session.id)
                            } label: {
                                Text("Cancel")
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
                            var subjects = {() -> String in
                                var out = ""
                                for subject in session.subjects {
                                    out += subject.humanReadableDescription + " "
                                }
                                return out
                            }()
                            Text("Tutor: \(manager.getUserProfile(fromID: session.tutor).name)").font(.largeTitle)
                            Text("Start: \(Date(timeIntervalSince1970: Double(session.start)).formatted())")
                            Text("End: \(Date(timeIntervalSince1970: Double(session.end)).formatted())")
                            Text("Subjects: \(subjects)")
                            Text(String(format: "Price: %.2f", session.totalCost))
                            Button {
                                cancelSession(id: session.id)
                            } label: {
                                Text("Cancel")
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
    func cancelSession(id: String?){
        if let docID = id {
            manager.removeSession(docID: docID)
        }
    }
}

