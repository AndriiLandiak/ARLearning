//
//  ModelPickerView.swift
//  CourseWork
//
//  Created by Andrew Landiak on 02.05.2022.
//

import SwiftUI

struct ModelPickerViewForAllAnimals: View {
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?
    var models: [Model]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(0 ..< models.count, id: \.self) { index in
                    Button(action: {
                        self.selectedModel = self.models[index]
                        self.isPlacementEnabled = true
                    }) {
                        Image(uiImage: self.models[index].image)
                            .resizable()
                            .frame(height: 80)
                            .aspectRatio(1/1, contentMode: .fit)
                            .background(Color.white)
                            .cornerRadius(12)
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }.padding(20)
    }
}

struct ModelPickerView: View {
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?
    var animalName: String
    var models: [Model]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                Button(action: {
                    if let i = models.firstIndex(where: { $0.modelName == animalName }) {
                        self.selectedModel = self.models[i]
                    } else {
                        self.selectedModel = nil
                    }
                    self.isPlacementEnabled = true
                }) {
                    Image(animalName)
                        .resizable()
                        .frame(height: 80)
                        .aspectRatio(1/1, contentMode: .fit)
                        .background(Color.white)
                        .cornerRadius(12)
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        .padding(20)
        }
}
