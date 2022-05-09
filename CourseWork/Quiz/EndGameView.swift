//
//  EndGameView.swift
//  CourseWork
//
//  Created by Andrew Landiak on 04.05.2022.
//

import SwiftUI

struct EndGameView: View {
    @EnvironmentObject var quizManager: QuizManager
    var body: some View {
        if quizManager.reachedEnd {
            VStack(spacing: 20) {
                Text("QuizGame")
                    .mainTitle()
                Text("Congratulations, the game has finished!")
                Text("You scored \(quizManager.score) out of \(quizManager.length)🎉")
                Button {
                    Task.init {
                        await quizManager.fetchQuiz()
                    }
                } label: {
                    PrimaryButton(text: "Play again!")
                }
                
            }
            .foregroundColor(Color("AppColor"))
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.9843113725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
            .navigationBarHidden(true)
        } else {
            QuestionView()
                .environmentObject(quizManager)
        }
    }
}
