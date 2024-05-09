//
//  ImagePickerView.swift
//  Photo Editor
//
//  Created by Igor on 07.05.2024.
//

import SwiftUI
import PhotosUI

struct ImagePickerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = PHPickerViewController
    @Binding var image: UIImage?
    @Binding var showPicker: Bool

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        config.preferredAssetRepresentationMode = .current
        config.filter = PHPickerFilter.any(of: [.images, .livePhotos])
     
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate, UINavigationControllerDelegate {
        var imagePicker: ImagePickerView
     
        init(with imagePicker: ImagePickerView) {
            self.imagePicker = imagePicker
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            imagePicker.showPicker.toggle()

            guard !results.isEmpty else {
                return
            }
            
            results.forEach { result in
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                        guard let image = reading as? UIImage, error == nil else {
                            return
                        }
                        DispatchQueue.main.async { [unowned self] in
                            self.imagePicker.image = image
                        }
                    }
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
            Coordinator(with: self)
        }
}
