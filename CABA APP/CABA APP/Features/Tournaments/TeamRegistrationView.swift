//
//  TeamRegistrationView.swift
//  CABA APP
//
//  Created by Brandon Kassab on 9/15/25.
//

import SwiftUI

struct TeamRegistrationView: View {
    let tournamentName: String
    
    @State private var teamName: String = ""
    @State private var players: [TeamPlayer] = []
    @State private var showAddPlayer = false
    @State private var showError = false
    
    var body: some View {
        ZStack {
            Color("AppBlack").ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Register Team for \(tournamentName)")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                // Team Name
                TextField("Team Name", text: $teamName)
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                
                // Player List
                List {
                    ForEach(players) { player in
                        HStack {
                            Text(player.name)
                                .foregroundColor(.white)
                            Spacer()
                            Text("#\(player.number) • \(player.shirtSize)")
                                .foregroundColor(.blue)
                        }
                        .listRowBackground(Color("AppBlack"))
                    }
                    .onDelete { indexSet in
                        // Prevent removing the captain
                        let indices = indexSet.filter { players[$0].isCaptain == false }
                        players.remove(atOffsets: IndexSet(indices))
                    }
                }
                .listStyle(.insetGrouped)
                
                // Add Player Button
                Button(action: { showAddPlayer = true }) {
                    Text("Add Player")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 20)
                .disabled(players.count >= 9) // max 9 players
                .sheet(isPresented: $showAddPlayer) {
                    AddTeamPlayerView { newPlayer in
                        if players.count < 9 {
                            players.append(newPlayer)
                        }
                        showAddPlayer = false
                    }
                }
                
                // Submit
                Button(action: {
                    if teamName.isEmpty || players.count < 6 {
                        showError = true
                    } else {
                        print("✅ Submitted team:", teamName, players)
                        // TODO: Save to backend
                    }
                }) {
                    Text("Submit Team")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 20)
                .alert("Team must have 6–9 players and a team name", isPresented: $showError) {
                    Button("OK", role: .cancel) {}
                }
                
                Spacer()
            }
        }
    }
}

// MARK: - Team Player Model
struct TeamPlayer: Identifiable {
    let id = UUID()
    let name: String
    let number: String
    let shirtSize: String
    let isCaptain: Bool
}

// MARK: - Add Team Player (search users)
struct AddTeamPlayerView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText: String = ""
    @State private var selectedPlayer: CABAPlayer? = nil
    @State private var number: String = ""
    @State private var shirtSize: String = "M"
    
    let onAdd: (TeamPlayer) -> Void
    
    // Sample list of players (replace with your real player directory later)
    let allPlayers: [CABAPlayer] = [
        CABAPlayer(name: "John Doe", position: "PG", height: "6'1\"", imageName: "person.fill"),
        CABAPlayer(name: "Michael Smith", position: "SG", height: "6'3\"", imageName: "person.fill"),
        CABAPlayer(name: "David Johnson", position: "C", height: "6'9\"", imageName: "person.fill"),
        CABAPlayer(name: "Alex Williams", position: "F", height: "6'5\"", imageName: "person.fill")
    ]
    
    var filteredPlayers: [CABAPlayer] {
        if searchText.isEmpty {
            return allPlayers
        } else {
            return allPlayers.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search players", text: $searchText)
                        .foregroundColor(.white)
                        .disableAutocorrection(true)
                }
                .padding()
                .background(Color.white.opacity(0.08))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Player list
                List(filteredPlayers) { player in
                    Button(action: {
                        selectedPlayer = player
                    }) {
                        HStack {
                            Text(player.name)
                                .foregroundColor(.white)
                            Spacer()
                            Text(player.position)
                                .foregroundColor(.blue)
                        }
                    }
                    .listRowBackground(Color("AppBlack"))
                }
                .listStyle(.insetGrouped)
                
                if let player = selectedPlayer {
                    Form {
                        Section(header: Text("Assign Details")) {
                            Text("Adding \(player.name)")
                            TextField("Jersey Number", text: $number)
                                .keyboardType(.numberPad)
                            Picker("Shirt Size", selection: $shirtSize) {
                                ForEach(["S", "M", "L", "XL", "XXL"], id: \.self) { size in
                                    Text(size)
                                }
                            }
                        }
                    }
                    
                    Button("Confirm Add") {
                        if !number.isEmpty {
                            onAdd(
                                TeamPlayer(
                                    name: player.name,
                                    number: number,
                                    shirtSize: shirtSize,
                                    isCaptain: false
                                )
                            )
                            dismiss()
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                }
                
                Spacer()
            }
            .background(Color("AppBlack"))
            .navigationTitle("Add Player")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TeamRegistrationView(
            tournamentName: "Spring Invitational 2025"
        )
    }
}

