//
//  ImagePicker.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 30/04/2025.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    var onImagePicked: ((UIImage) -> Void)?
    var onImageError: ((String) -> Void)?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                // Check image resolution
                if selectedImage.size.width >= 70 && selectedImage.size.height >= 70 {
                    // Check image size in MB
                    if let jpegData = selectedImage.jpegData(compressionQuality: 1.0),
                       jpegData.count <= 5 * 1024 * 1024 {  // 5MB limit
                        // Convert to JPG and pass the image
                        if let jpgImage = UIImage(data: jpegData) {
                            parent.image = jpgImage
                            parent.onImagePicked?(jpgImage)
                        }
                    } else {
                        parent.onImageError?("Image size exceeds the 5MB limit.")
                    }
                } else {
                    parent.onImageError?("Image resolution must be at least 70x70px.")
                }
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
