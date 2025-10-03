//
//  CABA_APPApp.swift
//  CABA APP
//
//  Created by Brandon Kassab on 9/12/25.
//

import SwiftUI

@main
struct CABA_APPApp: App {
    // Persistent flag for login status
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                HomeView()
                    .buttonStyle(PressableButtonStyle()) // Global Button Style
            } else {
                AuthView() // 👈 new login/signup screen
            }
        }
    }
}
