//
//  LearningView.swift
//  CourseWork
//
//  Created by Andrew Landiak on 03.05.2022.
//

import SwiftUI

struct LearningList: View {
    @ObservedObject var learningVM = LearningListViewModel()
    var body: some View {
        NavigationView {
            List(learningVM.animals, id: \.id) { animal in
                NavigationLink(
                    destination: LearningView(animalVM: animal)) {
                        LearningCell(animalVM: animal).padding(.leading, 20)
                    }
            }
            .navigationTitle("Animals")
        }
        .onAppear() {
            learningVM.fetchAllInformation()
        }
    }
}

