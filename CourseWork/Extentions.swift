//
//  Extentions.swift
//  CourseWork
//
//  Created by Andrew Landiak on 03.05.2022.
//

import Foundation
import SwiftUI

extension Text {
    func mainTitle() -> some View {
        self.font(.title)
            .fontWeight(.heavy)
            .foregroundColor(Color("AppColor"))
    }
}

