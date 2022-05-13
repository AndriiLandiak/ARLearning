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
    func animalTitle() -> some View {
        self.font(.title)
            .fontWeight(.heavy)
            .foregroundColor(Color("AppColor"))
    }
    func animalTitleNames() -> some View {
        self.font(.headline)
            .fontWeight(.medium)
            .foregroundColor(.black)
            .italic()
    }
    func shitTitles() -> some View {
        self.font(.title2)
            .fontWeight(.medium)
            .foregroundColor(Color("AppColor"))
    }
    
    
    func username() -> some View {
        self.font(.title)
            .font(.callout)
            .fontWeight(.medium)
            .foregroundColor((Color("GreenColor")))
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

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }

    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension View {

    func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }

}

