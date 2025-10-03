//
//  MyProfileView.swift
//  CABA APP
//
//  Created by Brandon Kassab on 9/15/25.
//

import SwiftUI

struct MyProfileView: View {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    // User profile modeled with CABAPlayer
    @State private var player = CABAPlayer(
        name: "Your Name",
        position: "Your Position",
        height: "Your Height",
        imageName: "person.fill"
    )
    
    @State private var selectedTab: ProfileTab = .stats
    @State private var showEditSheet = false
    @State private var showStatsEdit = false
    @State private var showLogoutAlert = false
    
    // Editable stats
    @State private var ppg: String = "18.4"
    @State private var rpg: String = "7.2"
    @State private var apg: String = "5.1"
    @State private var spg: String = "1.3"
    @State private var bpg: String = "0.8"
    @State private var fg: String = "47.2"
    @State private var wins: String = "3"
    @State private var mvps: String = "1"
    @State private var games: String = "55"
    
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
                        Text("540")
                            .font(.headline.bold())
                            .foregroundColor(.white)
                        Text("Followers")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    VStack {
                        Text("200")
                            .font(.headline.bold())
                            .foregroundColor(.white)
                        Text("Following")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                // Edit Profile Button
                Button(action: { showEditSheet = true }) {
                    Text("Edit Profile")
                        .font(.headline.bold())
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .sheet(isPresented: $showEditSheet) {
                    EditProfileView(player: $player)
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
                        VStack(spacing: 16) {
                            // Edit Stats Button
                            Button(action: { showStatsEdit = true }) {
                                Text("Edit Stats")
                                    .font(.subheadline.bold())
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 20)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            .padding(.bottom, 10)
                            
                            // Stats Grid
                            HStack(spacing: 12) {
                                StatBox(label: "PPG", value: ppg)
                                StatBox(label: "RPG", value: rpg)
                                StatBox(label: "APG", value: apg)
                            }
                            HStack(spacing: 12) {
                                StatBox(label: "SPG", value: spg)
                                StatBox(label: "BPG", value: bpg)
                                StatBox(label: "FG%", value: fg)
                            }
                            HStack(spacing: 12) {
                                StatBox(label: "CABA Wins", value: wins)
                                StatBox(label: "CABA MVPs", value: mvps)
                                StatBox(label: "Games", value: games)
                            }
                        }
                        .padding()
                        .sheet(isPresented: $showStatsEdit) {
                            EditStatsView(
                                ppg: $ppg, rpg: $rpg, apg: $apg,
                                spg: $spg, bpg: $bpg, fg: $fg,
                                wins: $wins, mvps: $mvps, games: $games
                            )
                        }
                    } else {
                        MyHighlightsView()
                            .transition(.move(edge: .trailing))
                    }
                }
                .animation(.easeInOut, value: selectedTab)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Log Out Button (bottom)
                Button(action: { showLogoutAlert = true }) {
                    Text("Log Out")
                        .font(.headline.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 30)
                .alert(isPresented: $showLogoutAlert) {
                    Alert(
                        title: Text("Log Out"),
                        message: Text("Are you sure you want to log out?"),
                        primaryButton: .destructive(Text("Log Out")) {
                            isLoggedIn = false
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .padding()
        }
    }
}

// MARK: - Edit Profile Sheet
struct EditProfileView: View {
    @Binding var player: CABAPlayer
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Info")) {
                    TextField("Name", text: $player.name)
                    TextField("Position", text: $player.position)
                    TextField("Height", text: $player.height)
                }
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { dismiss() }
                }
            }
        }
    }
}

// MARK: - Edit Stats Sheet
struct EditStatsView: View {
    @Binding var ppg: String
    @Binding var rpg: String
    @Binding var apg: String
    @Binding var spg: String
    @Binding var bpg: String
    @Binding var fg: String
    @Binding var wins: String
    @Binding var mvps: String
    @Binding var games: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Core Stats").font(.headline).foregroundColor(.blue)) {
                    StatEditField(label: "Points Per Game (PPG)", text: $ppg)
                    StatEditField(label: "Rebounds Per Game (RPG)", text: $rpg)
                    StatEditField(label: "Assists Per Game (APG)", text: $apg)
                    StatEditField(label: "Steals Per Game (SPG)", text: $spg)
                    StatEditField(label: "Blocks Per Game (BPG)", text: $bpg)
                    StatEditField(label: "Field Goal % (FG%)", text: $fg)
                }
                Section(header: Text("CABA Achievements").font(.headline).foregroundColor(.blue)) {
                    StatEditField(label: "CABA Wins", text: $wins)
                    StatEditField(label: "CABA MVPs", text: $mvps)
                    StatEditField(label: "Games Played", text: $games)
                }
            }
            .navigationTitle("Edit Stats")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { dismiss() }
                }
            }
        }
    }
}

// MARK: - Reusable Field
struct StatEditField: View {
    var label: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.subheadline.bold())
                .foregroundColor(.blue)
            TextField("Enter \(label)", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Highlights Page
struct MyHighlightsView: View {
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
    MyProfileView()
}
