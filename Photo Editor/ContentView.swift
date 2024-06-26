//
//  ContentView.swift
//  Photo Editor
//
//  Created by Igor on 16.04.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthorizationViewModel
    
    var body: some View {
        switch viewModel.checkUserAuthorization() {
        case .signedIn: PhotoView()
        case .signedOut: AuthorizationView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
