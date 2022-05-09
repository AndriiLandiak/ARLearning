//
//  QuestionView.swift
//  CourseWork
//
//  Created by Andrew Landiak on 03.05.2022.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var quizManager: QuizManager
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Text("Quiz Game").mainTitle()
                Spacer()
                Text("\(quizManager.index + 1) out of \(quizManager.length)")
                    .foregroundColor(Color("AppColor"))
                    .fontWeight(.heavy)
            }
            ProgressBar(progress: quizManager.progress)
            VStack(alignment: .leading, spacing: 20) {
                Text(quizManager.question)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.gray)
                ForEach(quizManager.answerChoices, id: \.id) { answer in
                    AnswerRow(answer: answer)
                        .environmentObject(quizManager)
                }
                
            }
            Button {
                quizManager.goToNextQuestion()
            } label: {
                PrimaryButton(text: "Next", background: quizManager.answerSelected ? Color("AppColor") : Color(hue: 1.0, saturation: 0.0, brightness: 0.564, opacity: 0.327))
            }
            .disabled(!quizManager.answerSelected)
            Spacer()
        }
        .padding(.top, 30)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color(red: 0.9843113725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
        .navigationBarHidden(true)
    }
}
