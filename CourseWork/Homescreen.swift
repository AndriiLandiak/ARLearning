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
        private var models: [Model] = {
            let filemanager = FileManager.default
            guard let path = Bundle.main.resourcePath, let files = try? filemanager.contentsOfDirectory(atPath: path) else {
                return []
            }
            var availableModels: [Model] = []
            for filename in files where
                filename.hasSuffix("usdz") {
                    let modelname = filename.replacingOccurrences(of: ".usdz", with: "")
                    let model = Model(modelName: modelname)
                    availableModels.append(model)
            }
            return availableModels
        }()
    var body: some View {
        TabView {
            AccountView().tabItem { Label("Account", systemImage: "house") }
            LearningList(models: models).tabItem { Label("Learning", systemImage: "book") }
            QuizView().tabItem { Label("Quiz", systemImage: "circle.grid.cross")}
        }.colorMultiply(Color(red: 0.9843113725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
            .edgesIgnoringSafeArea(.top)
            .accentColor(.black) }
}
