//
//  DrawingView.swift
//  Photo Editor
//
//  Created by Igor on 10.05.2024.
//

import SwiftUI

struct DrawingView: View {
    @EnvironmentObject var viewModel: DrawingViewModel
    
    var body: some View {
        ZStack {
            GeometryReader { proxy -> AnyView in
                let size = proxy.frame(in: .global).size
                
                return AnyView(
                    ZStack {
                        CanvasView(
                            canvas: $viewModel.canvas,
                            image: $viewModel.image,
                            toolPicker: $viewModel.toolPicker,
                            rect: size
                        )
                        
                        ForEach(viewModel.textBoxes) { box in
                            Text(viewModel.textBoxes[viewModel.currentIndex].id == box.id
                                 && viewModel.addNewBox ? "" : box.text)
                                .font(.system(size: 30))
                                .fontWeight(box.isBold ? .bold : .none)
                                .foregroundColor(box.textColor)
                                .offset(box.offset)
                                .gesture(DragGesture().onChanged({ value in
                                    let current = value.translation
                                    let lastOffset = box.lastOffset
                                    let newTranslation = CGSize(
                                        width: lastOffset.width + current.width,
                                        height: lastOffset.height + current.height)
                                    
                                    viewModel.textBoxes[getIndex(textBox: box)].lastOffset = newTranslation
                                }).onEnded({ value in
                                    viewModel.textBoxes[getIndex(textBox: box)].lastOffset = value.translation
                                }))
                        }
                    }
                )
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Text("Save")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.textBoxes.append(TextBox())
                    viewModel.currentIndex = viewModel.textBoxes.count - 1
                    
                    withAnimation {
                        viewModel.addNewBox.toggle()
                    }
                    viewModel.toolPicker.setVisible(false, forFirstResponder: viewModel.canvas)
                    viewModel.canvas.resignFirstResponder()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func getIndex(textBox: TextBox) -> Int {
        let index = viewModel.textBoxes.firstIndex { box in
            textBox.id == box.id
        } ?? 0
        
        return index
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView()
    }
}
