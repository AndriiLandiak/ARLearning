//
//  ContentView.swift
//  CourseWork
//
//  Created by Andrew Landiak on 02.05.2022.
//

import SwiftUI
import Firebase

struct Home : View {
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false

    var body: some View{
        VStack {
            if self.status {
                Homescreen()
            }else{
                Login()
            }
        }.onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in
                self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
            }
    }
}

struct Homescreen : View {
    var body: some View {
        TabView {
            AccountView().tabItem { Label("Account", systemImage: "house") }
            LearningList().tabItem { Label("Learning", systemImage: "book") }
            QuizView().tabItem { Label("Quiz", systemImage: "circle.grid.cross")}
        }.colorMultiply(Color(red: 0.9843113725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
            .edgesIgnoringSafeArea(.top)
            .accentColor(.black)
    }
}
