//
//  PressableButtonStyle.swift
//  CABA APP
//
//  Created by Brandon Kassab on 9/12/25.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(configuration.isPressed ? Color("AppGray") : Color("AppBlack"))
            .foregroundColor(Color("AppWhite"))
            .cornerRadius(12)
            .shadow(radius: 6)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}
