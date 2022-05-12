//
//  LearningListViewModel.swift
//  CourseWork
//
//  Created by Andrew Landiak on 12.05.2022.
//

import Foundation
import SwiftUI
import Combine

class LearningListViewModel: ObservableObject {
    @Published var animals = [LearningViewModel]()

    func fetchAllInformation() {
        self.animals = ManageData.shared.getAnimals().map(LearningViewModel.init)
    }
    
    func addTransaction(somebody: LearningViewModel) {
        ManageData.shared.addAnimal(id: somebody.id, name: somebody.name, origin: somebody.origin, info: somebody.info, youtube: somebody.youtube)
    }
    
    func removeTransaction(at index: Int) {
        let somebody = animals[index]
        ManageData.shared.removeAnimal(id: somebody.id)
    }
    
    func updateTransaction(somebody: LearningViewModel) {
        ManageData.shared.updateAnimal(id: somebody.id, name: somebody.name, origin: somebody.origin, info: somebody.info, youtube: somebody.youtube)
    }
}
