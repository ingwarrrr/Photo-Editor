//
//  SignUpView.swift
//  Photo Editor
//
//  Created by Igor on 17.04.2024.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewModel: AuthorizationViewModel
    @State var email = ""
    @State var pass = ""
    @State var repass = ""
    @Binding var index : Int
    
    var body: some View{
        ZStack(alignment: .bottom) {
            VStack{
                HStack{
                    Spacer(minLength: 0)
            
                    VStack(spacing: 10){
                        
                        Text(Strings.signUp)
                            .foregroundColor(self.index == 1 ? Color.button : Color.text)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Capsule()
                            .fill(self.index == 1 ? Color.yellow : Color.clear)
                            .frame(width: 100, height: 5)
                    }
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
                
                VStack{
                    HStack(spacing: 15){
                        
                        Image(systemName: Strings.eyeSlashFill)
                            .foregroundColor(Color.background)
                        
                        SecureField(Strings.password, text: self.$repass)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 30)
            }
            .padding()
            .padding(.bottom, 65)
            .background(.white)
            .clipShape(leftSideCurve())
            .contentShape(leftSideCurve())
            .modifier(SignViewStyle())
            .onTapGesture {
                self.index = 1
            }
            
            Button(action: {
                if pass == repass {
                    viewModel.signUp(with: email, password: pass)
                }
            }) {
                Text(Strings.signUp)
                    .modifier(SignButtonTextStyle())
            }
            .offset(y: 25)
            .opacity(self.index == 1 ? 1 : 0)
        }
    }
}
