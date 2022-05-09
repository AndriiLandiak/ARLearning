//
//  ImagePicker.swift
//  CourseWork
//
//  Created by Andrew Landiak on 09.05.2022.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
 
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let photoPicker: ImagePicker
 
        init(photoPicker: ImagePicker) {
            self.photoPicker = photoPicker
        }
 
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                photoPicker.image = image
            } else {
                // handle an error
            }
            picker.dismiss(animated: true)
        }
 
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            picker.dismiss()
//        }
 
    }

}
