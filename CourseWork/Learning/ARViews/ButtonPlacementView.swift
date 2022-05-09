//
//  ButtonPlacementView.swift
//  CourseWork
//
//  Created by Andrew Landiak on 02.05.2022.
//

import SwiftUI

struct ButtonPlacementView: View {
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?
    @Binding var modelConfirmedForPlacement: Model?
    var body: some View {
        HStack {
            Button(action: {
                self.resetPlacementParameters()
            }) {
                Image(systemName: "xmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }
            Button(action: {
                
                self.modelConfirmedForPlacement = self.selectedModel
                self.resetPlacementParameters()
            }) {
                Image(systemName: "checkmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }
        }
    }
    func resetPlacementParameters() {
        self.isPlacementEnabled = false
        self.selectedModel = nil
    }
}
