//
//  PhotoView.swift
//  Photo Editor
//
//  Created by Igor on 07.05.2024.
//

import SwiftUI

struct PhotoView: View {
    @EnvironmentObject var authorization: AuthorizationViewModel
    @StateObject var viewModel = DrawingViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    if let _ = viewModel.image {
                        DrawingView()
                            .environmentObject(viewModel)
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button {
                                        viewModel.calcelImageEditing()
                                    } label: {
                                        Image(systemName: "xmark")
                                    }
                                }
                            }
                    }
                    else {
                        Button {
                            viewModel.showImagePicker.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundColor(.black)
                                .frame(width: 70, height: 70)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                                .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: -5)
                        }
                        
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            authorization.signOut()
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.forward")
                        }
                    }
                }
                .navigationTitle("Image Editor")
            }
            
            if viewModel.addNewBox {
                Color.black.opacity(0.75)
                    .ignoresSafeArea()
                
                TextField("Type Here", text: $viewModel.textBoxes[viewModel.currentIndex].text)
                    .font(.system(size: 35))
                    .foregroundColor(viewModel.textBoxes[viewModel.currentIndex].textColor)
                    .colorScheme(.dark)
                    .padding()
                
                HStack {
                    Button {
                        viewModel.toolPicker.setVisible(true, forFirstResponder: viewModel.canvas)
                        viewModel.canvas.becomeFirstResponder()
                        
                        withAnimation {
                            viewModel.addNewBox = false
                        }
                    } label: {
                        Text("Add")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Button {
                        viewModel.cancelTextView()
                    } label: {
                        Text("Cancel")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .overlay(
                    ColorPicker("", selection: $viewModel.textBoxes[viewModel.currentIndex].textColor)
                )
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePickerView(image: $viewModel.image, showPicker: $viewModel.showImagePicker)
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView()
    }
}
