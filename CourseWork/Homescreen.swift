//
//  ContentView.swift
//  CourseWork
//
//  Created by Andrew Landiak on 02.05.2022.
//

import SwiftUI

struct Homescreen : View {
    var body: some View {
        TabView {
            AccountView().tabItem { Label("Account", systemImage: "house") }
            LearningView().tabItem { Label("Learning", systemImage: "book") }
            QuizView().tabItem { Label("Quiz", systemImage: "circle.grid.cross")}
        }.colorMultiply(.white)
            .edgesIgnoringSafeArea(.top)
            .accentColor(.black)
    }
}
