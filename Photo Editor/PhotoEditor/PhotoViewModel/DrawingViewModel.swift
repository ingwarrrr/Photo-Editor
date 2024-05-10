//
//  DrawingViewModel.swift
//  Photo Editor
//
//  Created by Igor on 07.05.2024.
//

import SwiftUI
import PencilKit

class DrawingViewModel: ObservableObject {
    @Published var showImagePicker = false
    @Published var image: UIImage?
    
    @Published var canvas = PKCanvasView()
    
    @Published var toolPicker = PKToolPicker()
    
    @Published var textBoxes: [TextBox] = []
    @Published var addNewBox = false
    
    @Published var currentIndex: Int = 0
    
    @Published var rect: CGRect = .zero
    
    @Published var showAlert = false
    @Published var message = ""
    
    func calcelImageEditing() {
        image = nil
        canvas = PKCanvasView()
        textBoxes.removeAll()
    }
    
    func cancelTextView() {
        toolPicker.setVisible(true, forFirstResponder: canvas)
        canvas.becomeFirstResponder()
        
        withAnimation {
            addNewBox = false
        }
        
        if !textBoxes[currentIndex].isAdded {
            textBoxes.removeLast()
        }
    }
    
    func saveImage() {
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        canvas.drawHierarchy(in: CGRect(origin: .zero, size: rect.size), afterScreenUpdates: true)
        
        let swiftUIView = ZStack {
            ForEach(textBoxes) { [self] box in
                Text(textBoxes[currentIndex].id == box.id
                     && addNewBox ? "" : box.text)
                .font(.system(size: 30))
                .fontWeight(box.isBold ? .bold : .none)
                .foregroundColor(box.textColor)
                .offset(box.offset)
            }
        }
        
        if let controller = UIHostingController(rootView: swiftUIView).view {
            controller.frame = rect
            controller.backgroundColor = .clear
            controller.drawHierarchy(in: CGRect(origin: .zero, size: rect.size), afterScreenUpdates: true)
        }
        canvas.backgroundColor = .clear
        
        guard let generatedImage = UIGraphicsGetImageFromCurrentImageContext()?.pngData() else {
            return
        }
        
        UIGraphicsEndImageContext()
        
        if let image = UIImage(data: generatedImage) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            print("image created..")
            message = "Image created and saved"
            showAlert.toggle()
        }
    }
}
