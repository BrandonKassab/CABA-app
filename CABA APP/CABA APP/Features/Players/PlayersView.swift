//
//  PlayersView.swift
//  CABA APP
//
//  Created by Brandon Kassab on 9/15/25.
//

//
//  PlayersView.swift
//  CABA APP
//
//  Created by Brandon Kassab on 9/15/25.
//

import SwiftUI

struct PlayersView: View {
    @State private var searchText: String = ""
    @FocusState private var isSearchFocused: Bool
    
    // Sample data using global CABAPlayer model (20 players)
    let players = [
        CABAPlayer(name: "John Doe", position: "Point Guard", height: "6'1\"", imageName: "person.fill"),
        CABAPlayer(name: "Michael Smith", position: "Shooting Guard", height: "6'3\"", imageName: "person.fill"),
        CABAPlayer(name: "David Johnson", position: "Center", height: "6'9\"", imageName: "person.fill"),
        CABAPlayer(name: "Alex Williams", position: "Forward", height: "6'5\"", imageName: "person.fill"),
        CABAPlayer(name: "Chris Evans", position: "Point Guard", height: "6'0\"", imageName: "person.fill"),
        CABAPlayer(name: "James Brown", position: "Shooting Guard", height: "6'2\"", imageName: "person.fill"),
        CABAPlayer(name: "Robert Green", position: "Center", height: "7'0\"", imageName: "person.fill"),
        CABAPlayer(name: "Daniel White", position: "Forward", height: "6'6\"", imageName: "person.fill"),
        CABAPlayer(name: "Anthony Miller", position: "Point Guard", height: "6'1\"", imageName: "person.fill"),
        CABAPlayer(name: "Brian Scott", position: "Shooting Guard", height: "6'4\"", imageName: "person.fill"),
        CABAPlayer(name: "Kevin Adams", position: "Forward", height: "6'7\"", imageName: "person.fill"),
        CABAPlayer(name: "Jason Lee", position: "Center", height: "6'10\"", imageName: "person.fill"),
        CABAPlayer(name: "William Clark", position: "Forward", height: "6'5\"", imageName: "person.fill"),
        CABAPlayer(name: "Matthew Lewis", position: "Point Guard", height: "6'0\"", imageName: "person.fill"),
        CABAPlayer(name: "Andrew Walker", position: "Shooting Guard", height: "6'3\"", imageName: "person.fill"),
        CABAPlayer(name: "Justin Hall", position: "Forward", height: "6'6\"", imageName: "person.fill"),
        CABAPlayer(name: "Brandon King", position: "Center", height: "6'11\"", imageName: "person.fill"),
        CABAPlayer(name: "Eric Young", position: "Point Guard", height: "6'2\"", imageName: "person.fill"),
        CABAPlayer(name: "Patrick Wright", position: "Shooting Guard", height: "6'4\"", imageName: "person.fill"),
        CABAPlayer(name: "Kyle Martinez", position: "Forward", height: "6'8\"", imageName: "person.fill")
    ]
    
    var filteredPlayers: [CABAPlayer] {
        if searchText.isEmpty {
            return players
        } else {
            return players.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.position.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color("AppBlack").ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Title
                Text("PLAYERS")
                    .font(.system(size: 34, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                    .tracking(2)
                    .shadow(color: .blue.opacity(0.5), radius: 6)
                    .padding(.top, 16)
                
                // Description
                Text("Browse the directory and connect with CABA players")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search players", text: $searchText)
                        .foregroundColor(.white)
                        .disableAutocorrection(true)
                        .focused($isSearchFocused)
                        .submitLabel(.done)
                }
                .padding()
                .background(Color.white.opacity(0.08))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Scrollable List
                ScrollView {
                    VStack(spacing: 16) {
                        if filteredPlayers.isEmpty {
                            Text("No players found")
                                .foregroundColor(.gray)
                                .padding(.top, 40)
                        } else {
                            ForEach(filteredPlayers) { player in
                                NavigationLink(destination: PlayerProfileView(player: player)) {
                                    PlayerCard(player: player)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .onTapGesture { isSearchFocused = false }
        }
    }
}

// MARK: - Player Card
struct PlayerCard: View {
    let player: CABAPlayer
    @State private var isFollowing = false
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: player.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
                .background(Color.blue.opacity(0.6))
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(player.name)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(player.position)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                Text("Height: \(player.height)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: { isFollowing.toggle() }) {
                Text(isFollowing ? "Following" : "Follow")
                    .font(.caption.bold())
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(isFollowing ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color("AppBlack").opacity(0.85))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.blue.opacity(0.7), lineWidth: 1.2)
        )
        .shadow(color: .blue.opacity(0.25), radius: 6, x: 0, y: 3)
    }
}

// MARK: - Player Profile Screen
struct PlayerProfileView: View {
    let player: CABAPlayer
    @State private var isFollowing = false
    @State private var selectedTab: ProfileTab = .stats
    
    enum ProfileTab {
        case stats, highlights
    }
    
    var body: some View {
        ZStack {
            Color("AppBlack").ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Profile Image
                Image(systemName: player.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.white)
                    .background(Color.blue.opacity(0.6))
                    .clipShape(Circle())
                    .padding(.top, 30)
                
                // Name
                Text(player.name)
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                // Followers / Following
                HStack(spacing: 40) {
                    VStack {
                        Text("1.2K")
                            .font(.headline.bold())
                            .foregroundColor(.white)
                        Text("Followers")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    VStack {
                        Text("320")
                            .font(.headline.bold())
                            .foregroundColor(.white)
                        Text("Following")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                // Follow / Following button
                Button(action: { isFollowing.toggle() }) {
                    Text(isFollowing ? "Following" : "Follow")
                        .font(.headline.bold())
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                        .background(isFollowing ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                // Tabs
                HStack {
                    Button(action: {
                        withAnimation(.easeInOut) { selectedTab = .stats }
                    }) {
                        Text("STATS")
                            .font(.headline)
                            .foregroundColor(selectedTab == .stats ? .blue : .gray)
                            .padding(.horizontal)
                    }
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut) { selectedTab = .highlights }
                    }) {
                        Text("HIGHLIGHTS / MEDIA")
                            .font(.headline)
                            .foregroundColor(selectedTab == .highlights ? .blue : .gray)
                            .padding(.horizontal)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 10)
                
                // Tab Content
                ZStack {
                    if selectedTab == .stats {
                        StatsView()
                            .transition(.move(edge: .leading))
                    } else {
                        HighlightsView()
                            .transition(.move(edge: .trailing))
                    }
                }
                .animation(.easeInOut, value: selectedTab)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Spacer()
            }
            .padding()
        }
    }
}

// MARK: - Stats Page
struct StatsView: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                StatBox(label: "PPG", value: "18.4")
                StatBox(label: "RPG", value: "7.2")
                StatBox(label: "APG", value: "5.1")
            }
            HStack(spacing: 12) {
                StatBox(label: "SPG", value: "1.3")
                StatBox(label: "BPG", value: "0.8")
                StatBox(label: "FG%", value: "47.2")
            }
            HStack(spacing: 12) {
                StatBox(label: "CABA Wins", value: "3")
                StatBox(label: "CABA MVPs", value: "1")
                StatBox(label: "Games", value: "55")
            }
        }
        .padding()
    }
}

// MARK: - Highlights Page
struct HighlightsView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Highlights Coming Soon…")
                .font(.title.bold())
                .foregroundColor(.white)
                .padding()
            Spacer()
        }
    }
}

#Preview {
    NavigationStack { PlayersView() }
}


