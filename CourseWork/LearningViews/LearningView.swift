//
//  LearningView.swift
//  CourseWork
//
//  Created by Andrew Landiak on 03.05.2022.
//

import SwiftUI

struct LearningView: View {
    var body: some View {
        NavigationView {
            NavigationLink {
                MainARView()
            } label: {
                PrimaryButton(text: "AR")
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
             .edgesIgnoringSafeArea(.all)
             .background(Color(red: 0.9843113725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
        }
    }
}

