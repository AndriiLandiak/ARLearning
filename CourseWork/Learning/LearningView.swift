//
//  LearningView.swift
//  CourseWork
//
//  Created by Andrew Landiak on 12.05.2022.
//

import SwiftUI

struct LearningView: View {
    var animalVM: LearningViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Image(animalVM.name)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding(.all, -30)
                            .foregroundColor(.white)
                        VStack {
                            VStack(alignment: .leading, spacing: 0) {
                                HStack {
                                    Text("Class:").shitTitles()
                                    Text(animalVM.classtype)
                                }
                                HStack {
                                    Text("Origin:").shitTitles()
                                    Text(animalVM.origin)
                                }
                                HStack {
                                    Text("Age:").shitTitles()
                                    Text(animalVM.age)
                                }
                                HStack {
                                    Text("Size:").shitTitles()
                                    Text(animalVM.size)
                                }
                                HStack {
                                    Text("Weight:").shitTitles()
                                    Text(String(animalVM.weight))
                                }
                            }
                        }   .frame(width: UIScreen.screenWidth-200, height: 200, alignment: .leading)
                        
                    }.frame(width: UIScreen.screenWidth, height: 200)
                        .background(.white)
                        .padding(.leading, 0)
                    HStack {
                        Text("YouTube: ")
                            .shitTitles()
                        Text(animalVM.youtube)
                            .foregroundColor(.blue)
                    }.frame(width: UIScreen.screenWidth - 20, height: 70)
                    ScrollView {
                        Text(animalVM.info)
                            .font(.system(size: 20, weight: .light, design: .serif))
                                .italic()
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                    }.frame(width: UIScreen.screenWidth-10, height: 300)
                        .background(.white)
                    NavigationLink {
                        MainARView()
                    } label: {
                        PrimaryButton(text: "AR")
                    }
                }.frame(width: UIScreen.screenWidth, height: 300)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.9843113725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(backgroundColor:UIColor(Color(red: 0.9843113725490196, green: 0.9294117647058824, blue: 0.8470588235294118)), titleColor: UIColor(Color("AppColor")))
            .toolbar {
                ToolbarItem(placement: .principal) {
                      VStack {
                          Text(animalVM.name).mainTitle()
                      }
                  }
            }
        }
    }
}
