//
//  AnswerRow.swift
//  CourseWork
//
//  Created by Andrew Landiak on 03.05.2022.
//

import SwiftUI

struct AnswerRow: View {
    @State private var isSelected = false
    @EnvironmentObject var quizManager: QuizManager
    var answer: Answer
    var green = Color(hue: 0.437, saturation: 0.711, brightness: 0.711)
    var red = Color(red:0.71, green: 0.094, blue: 0.1)
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "circle.fill")
                .font(.caption)
            
            Text(answer.text)
                .bold()
            
            if isSelected {
                Spacer()
                Image(systemName: answer.isCorrect ? "checkmark" : "x.circle.fill")
                    .foregroundColor(answer.isCorrect ? green : red)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(quizManager.answerSelected ? (isSelected ? Color("AppColor") : .gray) : Color("AppColor"))
        .background(.white)
        .cornerRadius(10)
        .shadow(color: isSelected ? (answer.isCorrect ? green : red) : .gray, radius: 5, x: 0.5, y: 0.5) 
        .onTapGesture {
            if !quizManager.answerSelected {
                isSelected  = true
                quizManager.selectAnswer(answer: answer)
            }
        }
    }
}
