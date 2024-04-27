//
//  SignViewStyle.swift
//  Photo Editor
//
//  Created by Igor on 27.04.2024.
//

import SwiftUI

struct SignViewStyle: ViewModifier {

    func body(content: Content) -> some View {
        return content
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
            .cornerRadius(35)
            .padding(.horizontal,20)
    }
}
