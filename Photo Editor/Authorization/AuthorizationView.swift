//
//  MainView.swift
//  Photo Editor
//
//  Created by Igor on 17.04.2024.
//

import SwiftUI

struct AuthorizationView : View {
    @EnvironmentObject var viewModel: AuthorizationViewModel
    @State var index = 0
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                ZStack {
                    SignUpView(index: self.$index)
                        .zIndex(Double(self.index))
                    SignInView(index: self.$index)
                }
                
                HStack(spacing: 15) {
                    Rectangle()
                        .fill(.yellow)
                        .frame(height: 1)
                    
                    Text(Strings.or)
                    
                    Rectangle()
                        .fill(.yellow)
                        .frame(height: 1)
                }
                .padding(.horizontal, 30)
                .padding(.top, 50)
                
                HStack(spacing: 25) {
                    Button(action: {
                        viewModel.signInWithGoogle()
                    }) {
                        Image(systemName: Strings.gCircle)
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .foregroundColor(.yellow)
                    }
                }
                .padding(.top, 30)
            }
            .padding(.top, 60)
            .padding(.vertical)
        }
        .background(Color.background.edgesIgnoringSafeArea(.all))
    }
}
