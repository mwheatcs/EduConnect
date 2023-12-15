//
//  Toast.swift
//  EduConnect
//
//  ATTRIBUTION: THIS IS A LIBRARY, NONE IS ORIGINAL
//  https://www.devtechie.com/community/public/posts/279749-how-to-build-toast-message-in-swiftui

import SwiftUI

struct ToastDataModel {
    var title:String
    var image:String
    var color:Color
}

struct Toast: View {
    
    let dataModel: ToastDataModel
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Image(systemName: dataModel.image)
                Text(dataModel.title)
            }.font(.headline)
                .foregroundColor(.primary)
                .padding([.top,.bottom],20)
                .padding([.leading,.trailing],10)
                .background(dataModel.color)
                .clipShape(.capsule)
        }
        .frame(width: UIScreen.main.bounds.width / 1.25)
        .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
        .onTapGesture {
            withAnimation {
                self.show = false
            }
        }.onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.show = false
                }
            }
        })
    }
}

struct ToastModifier : ViewModifier {
    @Binding var show: Bool
    
    let toastView: Toast
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if show {
                toastView
            }
        }
    }
}

extension View {
    func toast(toastView: Toast, show: Binding<Bool>) -> some View {
        self.modifier(ToastModifier.init(show: show, toastView: toastView))
    }
}
