//
//  SignButtonStyle.swift
//  Photo Editor
//
//  Created by Igor on 27.04.2024.
//

import SwiftUI

struct SignButtonTextStyle: ViewModifier {

    func body(content: Content) -> some View {
        return content
            .foregroundColor(.white)
            .fontWeight(.bold)
            .padding(.vertical)
            .padding(.horizontal, 50)
            .background(Color("Color2"))
            .clipShape(Capsule())
            .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}
