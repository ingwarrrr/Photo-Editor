//
//  LoginView.swift
//  Photo Editor
//
//  Created by Igor on 17.04.2024.
//

import SwiftUI

struct SignInView : View {
    @EnvironmentObject var viewModel: AuthorizationViewModel
    @State private var email = ""
    @State private var pass = ""
    @State private var showResetPassvordView = false
    @Binding var index : Int
    
    var body: some View{
        ZStack(alignment: .bottom) {
            VStack{
                HStack{
                    VStack(spacing: 10){
                        
                        Text(Strings.signIn)
                            .foregroundColor(self.index == 1 ? Color.button : Color.text)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Capsule()
                            .fill(self.index == 0 ? Color.yellow : Color.clear)
                            .frame(width: 100, height: 5)
                    }
                    
                    Spacer(minLength: 0)
                }
                .padding(.top, 30)
                
                VStack{
                    HStack(spacing: 15){
                        Image(systemName: Strings.envelopeFill)
                            .foregroundColor(Color.background)
                        
                        TextField(Strings.email, text: self.$email)
                            .textContentType(.emailAddress)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 40)
                
                VStack{
                    HStack(spacing: 15){
                        Image(systemName: Strings.eyeSlashFill)
                            .foregroundColor(Color.background)
                        
                        SecureField(Strings.password, text: self.$pass)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                HStack{
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        showResetPassvordView.toggle()
                    }) {
                        Text(Strings.forgetPassword)
                            .foregroundColor(Color.text)
                    }
                    .sheet(isPresented: $showResetPassvordView) {
                        ResetPasswordView()
                    }
                }
                .padding(.horizontal)
                .padding(.top, 30)
            }
            .padding()
            .padding(.bottom, 65)
            .background(.white)
            .clipShape(rightSideCurve())
            .contentShape(rightSideCurve())
            .modifier(SignViewStyle())
            .onTapGesture {
                self.index = 0
            }

            
            Button(action: {
                viewModel.signIn(with: email, password: pass)
            }) {
                Text(Strings.signIn)
                    .modifier(SignButtonTextStyle())
            }
            .offset(y: 25)
            .opacity(self.index == 0 ? 1 : 0)
        }
    }
}
