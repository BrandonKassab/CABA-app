//
//  StandingsView.swift
//  CABA APP
//
//  Created by Brandon Kassab on 9/15/25.
//

import SwiftUI

struct StandingsView: View {
    // Sample data
    let topPPG = [
        Leader(name: "John Doe", value: "27.4"),
        Leader(name: "Michael Smith", value: "25.1"),
        Leader(name: "David Johnson", value: "22.8")
    ]
    
    let topWins = [
        Leader(name: "Alex Williams", value: "6"),
        Leader(name: "John Doe", value: "4"),
        Leader(name: "Michael Smith", value: "3")
    ]
    
    let topMVPs = [
        Leader(name: "David Johnson", value: "3"),
        Leader(name: "Alex Williams", value: "2"),
        Leader(name: "John Doe", value: "1")
    ]
    
    let topBlocks = [
        Leader(name: "Michael Smith", value: "2.1"),
        Leader(name: "David Johnson", value: "1.9"),
        Leader(name: "Alex Williams", value: "1.7")
    ]
    
    let topSteals = [
        Leader(name: "John Doe", value: "2.3"),
        Leader(name: "Michael Smith", value: "2.0"),
        Leader(name: "Alex Williams", value: "1.8")
    ]
    
    let topAssists = [
        Leader(name: "David Johnson", value: "9.4"),
        Leader(name: "John Doe", value: "8.7"),
        Leader(name: "Michael Smith", value: "8.1")
    ]
    
    var body: some View {
        ZStack {
            Color("AppBlack").ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Fixed Header (title + description)
                VStack(spacing: 8) {
                    Text("STANDINGS & STATS")
                        .font(.system(size: 28, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .tracking(2)
                        .shadow(color: .blue.opacity(0.5), radius: 6)
                        .padding(.top, 40) // ✅ closer to top but still safe
                    
                    Text("Check out the top performers in CABA tournaments")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                // Scrollable Leaderboards
                ScrollView {
                    VStack(spacing: 30) {
                        LeaderboardSection(title: "Most PPG", icon: "🏀", leaders: topPPG, unit: "PPG")
                        LeaderboardSection(title: "Most CABA Wins", icon: "🏆", leaders: topWins, unit: "Wins")
                        LeaderboardSection(title: "Most MVPs", icon: "⭐", leaders: topMVPs, unit: "MVPs")
                        LeaderboardSection(title: "Best Defender (Blocks)", icon: "🛡", leaders: topBlocks, unit: "BPG")
                        LeaderboardSection(title: "Best Defender (Steals)", icon: "🛡", leaders: topSteals, unit: "SPG")
                        LeaderboardSection(title: "Best Teammate (Assists)", icon: "🤝", leaders: topAssists, unit: "APG")
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

// MARK: - Leader Model
struct Leader: Identifiable {
    let id = UUID()
    let name: String
    let value: String
}

// MARK: - Leaderboard Section
struct LeaderboardSection: View {
    let title: String
    let icon: String
    let leaders: [Leader]
    let unit: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 6) {
                Text(icon)
                Text(title.uppercased())
            }
            .font(.headline)
            .foregroundColor(.blue)
            .padding(.leading, 4)
            
            ForEach(leaders.indices, id: \.self) { index in
                HStack {
                    Text("\(index + 1). \(leaders[index].name)")
                        .font(.subheadline.bold())
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("\(leaders[index].value) \(unit)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color("AppBlack").opacity(0.85))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue.opacity(0.7), lineWidth: 1.2)
                )
                .shadow(color: .blue.opacity(0.25), radius: 4, x: 0, y: 2)
            }
        }
    }
}

#Preview {
    StandingsView()
}
