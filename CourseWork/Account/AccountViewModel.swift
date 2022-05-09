//
//  AccountViewModel.swift
//  CourseWork
//
//  Created by Andrew Landiak on 09.05.2022.
//

import Foundation
import SwiftUI

class AccountViewModel: ObservableObject {
    func getPhoto(user :String  ) -> UIImage {
        let fileName = user + ".txt"
        let data = self.read(fromDocumentsWithFileName: fileName)
        if data == "" {
            return UIImage(systemName: "person")!
        }
        return data.toImage()!
    }
    
    func savePhoto(photo: UIImage, user :String) {
        let fileName = user + ".txt"
        self.save(text: photo.toPngString() ?? "",
                      toDirectory: self.documentDirectory(),
                      withFileName: fileName)
    }
    
    func deletePhoto(user: String) {
        let filename = user + ".txt"
        self.save(text: UIImage(systemName: "person")?.toPngString() ?? "", toDirectory: self.documentDirectory(), withFileName: filename)
    }
    
    private func save(text: String,
                      toDirectory directory: String,
                      withFileName fileName: String) {
        guard let filePath = self.append(toPath: directory,
                                         withPathComponent: fileName) else {
            return
        }
        
        do {
            try text.write(toFile: filePath,
                           atomically: true,
                           encoding: .utf8)
        } catch {
            print("Error", error)
            return
        }
        

    }
    
    private func append(toPath path: String,
                        withPathComponent pathComponent: String) -> String? {
        if var pathURL = URL(string: path) {
            pathURL.appendPathComponent(pathComponent)
            
            return pathURL.absoluteString
        }
        
        return nil
    }
    
    private func documentDirectory() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                    .userDomainMask,
                                                                    true)
        return documentDirectory[0]
    }
    
    private func read(fromDocumentsWithFileName fileName: String)-> String {
        guard let filePath = self.append(toPath: self.documentDirectory(),
                                         withPathComponent: fileName) else {
                                            return ""
        }
        
        do {
            let savedString = try String(contentsOfFile: filePath)
            return savedString
        
        } catch {
            return ""
        }
    }
}

