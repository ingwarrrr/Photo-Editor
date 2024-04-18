//
//  Photo_EditorApp.swift
//  Photo Editor
//
//  Created by Igor on 16.04.2024.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct Photo_EditorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var authorizationVM = AuthorizationViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(authorizationVM)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }

    func application(
      _ app: UIApplication,
      open url: URL,
      options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
