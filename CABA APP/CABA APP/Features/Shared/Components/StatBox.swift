//
//  StatBox.swift
//  CABA APP
//
//  Created by Brandon Kassab on 9/16/25.
//

import SwiftUI

struct StatBox: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 6) {
            Text(value)
                .font(.headline.bold())
                .foregroundColor(.white)
            Text(label)
                .font(.caption)
                .foregroundColor(.blue)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("AppBlack"), Color.blue.opacity(0.2)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: Color.blue.opacity(0.3), radius: 6, x: 0, y: 3)
    }
}
