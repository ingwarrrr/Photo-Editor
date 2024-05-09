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
    
    func calcelImageEditing() {
        image = nil
        canvas = PKCanvasView()
    }
    
    func cancelTextView() {
        toolPicker.setVisible(true, forFirstResponder: canvas)
        canvas.becomeFirstResponder()
        
        withAnimation {
            addNewBox = false
        }
        
        textBoxes.removeLast()
    }
}
