//
//  LearningViewModel.swift
//  CourseWork
//
//  Created by Andrew Landiak on 12.05.2022.
//

import Foundation
import SwiftUI
import Combine
import Firebase

class LearningViewModel: Identifiable {
    var id: UUID
    var name: String
    var origin: String
    var info: String
    var youtube: URL
    var size: String
    var classtype: String
    var age: String
    var weight: Double
    
    init(animal: Animal) {
        self.id = animal.id ?? UUID()
        self.name = animal.name ?? ""
        self.origin = animal.origin ?? ""
        self.info = animal.info ?? ""
        self.youtube = animal.youtube ?? URL(fileURLWithPath: "")
        self.size = animal.size ?? ""
        self.classtype = animal.classtype ?? ""
        self.age = animal.age ?? ""
        self.weight = animal.weight 
    }
    
    init(id: UUID, name: String, origin: String, info: String, youtube: URL, size: String, classtype: String, age: String, weight: Double) {
        self.id = id
        self.name = name
        self.origin = origin
        self.info = info
        self.youtube = youtube
        self.size = size
        self.classtype = classtype
        self.age = age
        self.weight = weight
    }
}

