//
//  LearningView.swift
//  CourseWork
//
//  Created by Andrew Landiak on 12.05.2022.
//

import SwiftUI

struct LearningView: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Color("AppColor")]

        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: Color("AppColor")]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Image("tv_retro")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding(.all, -30)
                            .foregroundColor(.white)
                        VStack {
                            VStack(alignment: .leading, spacing: 0) {
                                HStack {
                                    Text("Class:").shitTitles()
                                    Text("Mammal")
                                }
                                HStack {
                                    Text("Origin:").shitTitles()
                                    Text("Africa")
                                }
                                HStack {
                                    Text("Age:").shitTitles()
                                    Text("17-20")
                                }
                                HStack {
                                    Text("Size:").shitTitles()
                                    Text("100x100")
                                }
                                HStack {
                                    Text("Weight:").shitTitles()
                                    Text("200")
                                }
                            }
                        }   .frame(width: UIScreen.screenWidth-200, height: 200, alignment: .leading)
                        
                    }.frame(width: UIScreen.screenWidth, height: 200)
                        .background(.white)
                        .padding(.leading, 0)
                    HStack {
                        Text("YouTube: ")
                            .shitTitles()
                        Text("https://www.youtube.com/watch?v=34vmsE2RiNk&t=797")
                            .foregroundColor(.blue)
                    }.frame(width: UIScreen.screenWidth - 20, height: 70)
                    ScrollView {
                        Text("Zebras  are African equines with distinctive black-and-white striped coats. There are three living species: the Grévy's zebra (Equus grevyi), plains zebra (E. quagga), and the mountain zebra (E. zebra). Zebras share the genus Equus with horses and asses, the three groups being the only living members of the family Equidae. Zebra stripes come in different patterns, unique to each individual. Several theories have been proposed for the function of these stripes, with most evidence supporting them as a deterrent for biting flies. Zebras inhabit eastern and southern Africa and can be found in a variety of habitats such as savannahs, grasslands, woodlands, shrublands, and mountainous areas.Zebra stripes come in different patterns, unique to each individual. Several theories have been proposed for the function of these stripes, with most evidence supporting them as a deterrent for biting flies. Zebras inhabit eastern and southern Africa and can be found in a variety of habitats such as savannahs, grasslands, woodlands, shrublands, and mountainous areas.")
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
            }.edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.9843113725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(backgroundColor:             UIColor(Color(red: 0.9843113725490196, green: 0.9294117647058824, blue: 0.8470588235294118)), titleColor: UIColor(Color("AppColor")))
            .toolbar {
                ToolbarItem(placement: .principal) {
                      VStack {
                          Text("Zebra").mainTitle()
                      }
                  }
            }
        }
    }
}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView()
    }
}
