//
//  ResetPasswordView.swift
//  Photo Editor
//
//  Created by Igor on 18.04.2024.
//

import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var viewModel: AuthorizationViewModel
    @State private var email = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { _ in
            VStack {
                Spacer(minLength: 0)

                VStack {
                    HStack {
                        VStack(spacing: 10){
                            Text(Strings.passwordReset)
                                .foregroundColor(Color.text)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.top, 30)
                    
                    VStack {
                        Text(Strings.emailInstruction)
                            .foregroundColor(Color.text)
                            .padding(.bottom, 20)
                        
                        HStack(spacing: 15) {
                            Image(systemName: Strings.envelopeFill)
                                .foregroundColor(Color.background)
                            
                            TextField(Strings.email, text: self.$email)
                                .textContentType(.emailAddress)
                        }
                        
                        Divider().background(Color.white.opacity(0.5))
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
                .padding()
                .padding(.bottom, 45)
                .background(.white)
                .modifier(SignViewStyle())
                
                Button(action: {
                    viewModel.resetPassword(with: email)
                }) {
                    Text(Strings.send)
                        .modifier(SignButtonTextStyle())
                }
                .offset(y: -30)
                
                Spacer(minLength: 0)
            }
        }
        .background(Color.background.edgesIgnoringSafeArea(.all))
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
