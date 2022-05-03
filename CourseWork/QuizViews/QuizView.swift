//
//  QuizView.swift
//  CourseWork
//
//  Created by Andrew Landiak on 03.05.2022.
//

import SwiftUI

struct QuizView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                VStack(spacing: 20) {
                    Text("Quiz Game")
                        .mainTitle()
                    Text("Are you ready to test out your skills?")
                        .foregroundColor(Color("AppColor"))
                }
                NavigationLink {
                    QuestionView()
                } label: {
                    PrimaryButton(text: "Let's go")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color(red: 0.9843113725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
        }
    }
}

struct QuizView_Preview: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
