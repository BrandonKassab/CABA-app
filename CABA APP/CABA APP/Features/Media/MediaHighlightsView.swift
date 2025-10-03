//
//  MediaHighlightsView.swift
//  CABA APP
//
//  Created by Brandon Kassab on 9/15/25.
//

import SwiftUI

struct MediaHighlightsView: View {
    var body: some View {
        ZStack {
            // Background
            Color("AppBlack").ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Title
                Text("MEDIA & HIGHLIGHTS")
                    .font(.system(size: 28, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                    .tracking(2)
                    .shadow(color: .blue.opacity(0.5), radius: 6)
                    .padding(.top, 40)
                
                Spacer()
                
                // Cute placeholder
                VStack(spacing: 16) {
                    Image(systemName: "play.rectangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.blue)
                        .shadow(color: .blue.opacity(0.5), radius: 10)
                    
                    Text("Coming Soon…")
                        .font(.title.bold())
                        .foregroundColor(.white)
                    
                    Text("Stay tuned for player highlights and clips!")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    MediaHighlightsView()
}
