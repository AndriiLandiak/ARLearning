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

extension UIImage {
    func isEqual(to image: UIImage) -> Bool {
        return isEqual(image)
    }
}

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}


extension UIImage {
    func toPngString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
  
    func toJpegString(compressionQuality cq: CGFloat) -> String? {
        let data = self.jpegData(compressionQuality: cq)
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}

