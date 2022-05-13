//
//  LearningCell.swift
//  CourseWork
//
//  Created by Andrew Landiak on 12.05.2022.
//

import SwiftUI

struct LearningCell: View {
    var animalVM: LearningViewModel
    var body: some View {
        HStack {
            Image(animalVM.name)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.screenWidth/2 ,height: 200)
                .foregroundColor(.white)
                .cornerRadius(4)
                .padding(.all, -30)
            VStack(alignment: .leading, spacing: 5) {
                Text(animalVM.name).mainTitle()
                HStack {
                    Text("Class:").animalTitleNames()
                    Text(animalVM.classtype).bold().foregroundColor(Color("AppColor"))
                }
                HStack {
                    Text("Origin:").animalTitleNames()
                    Text(animalVM.origin).bold().foregroundColor(Color("AppColor"))
                }
                Text("          AR          ")
                    .foregroundColor(.white)
                    .background(Color("AppColor"))
                    .cornerRadius(30)
                    .shadow(radius: 10)
                    .frame(minWidth: 150, alignment: .leading)
                    .padding(.top, 4)
            }.frame(width: UIScreen.screenWidth/1.7, alignment: .leading)
                .padding(.top, 0)
            .padding(.trailing)
        }.frame(width: UIScreen.screenWidth, height: 200)
            .padding(.leading, 0)
    }
}
