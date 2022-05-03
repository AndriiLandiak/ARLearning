//
//  QuestionView.swift
//  CourseWork
//
//  Created by Andrew Landiak on 03.05.2022.
//

import SwiftUI

struct QuestionView: View {
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                Text("Quiz Game").mainTitle()
                Spacer()
                Text("1 out of 10")
                    .foregroundColor(Color("AppColor"))
                    .fontWeight(.heavy)
            }
            ProgressBar(progress: 40)
            VStack(alignment: .leading, spacing: 20) {
                Text("How many games in the Crash Bandicoot series were released on the original Playstation?")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.gray)
            }
            PrimaryButton(text: "Next")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color(red: 0.9843113725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
