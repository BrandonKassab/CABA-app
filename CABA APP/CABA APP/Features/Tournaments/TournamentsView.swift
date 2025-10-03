//
//  TournamentsView.swift
//  CABA APP
//
//  Created by Brandon Kassab on 9/15/25.
//

import SwiftUI

struct TournamentsView: View {
    @State private var searchText: String = ""
    @FocusState private var isSearchFocused: Bool

    // Sample tournament data
    let tournaments = [
        Tournament(title: "Spring Invitational 2025", date: "March 15–17", location: "Detroit, MI"),
        Tournament(title: "Summer Classic 2025", date: "July 8–10", location: "Chicago, IL"),
        Tournament(title: "Fall Nationals 2025", date: "October 12–14", location: "San Diego, CA"),
        Tournament(title: "Winter Showdown 2025", date: "December 5–7", location: "New York, NY")
    ]

    var filteredTournaments: [Tournament] {
        if searchText.isEmpty {
            return tournaments
        } else {
            return tournaments.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        ZStack {
            Color("AppBlack")
                .ignoresSafeArea()
                .onTapGesture { isSearchFocused = false }

            VStack(spacing: 20) {
                Text("TOURNAMENTS")
                    .font(.system(size: 34, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                    .tracking(2)
                    .shadow(color: .blue.opacity(0.5), radius: 6)
                    .padding(.top, 16)

                Text("Browse and sign up for CABA tournaments")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search tournaments", text: $searchText)
                        .foregroundColor(.white)
                        .disableAutocorrection(true)
                        .focused($isSearchFocused)
                        .submitLabel(.done)
                }
                .padding()
                .background(Color.white.opacity(0.08))
                .cornerRadius(12)
                .padding(.horizontal)

                // Tournament list
                ScrollView {
                    VStack(spacing: 16) {
                        if filteredTournaments.isEmpty {
                            Text("No tournaments found")
                                .foregroundColor(.gray)
                                .padding(.top, 40)
                        } else {
                            ForEach(filteredTournaments) { tournament in
                                TournamentCard(
                                    title: tournament.title,
                                    date: tournament.date,
                                    location: tournament.location
                                )
                            }
                        }
                    }
                    .padding()
                }

                Spacer()
            }
        }
    }
}

// Tournament model
struct Tournament: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let location: String
}

// Tournament card navigates to TeamRegistrationView
struct TournamentCard: View {
    let title: String
    let date: String
    let location: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)

                Text(date)
                    .font(.subheadline)
                    .foregroundColor(.blue)

                Text(location)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            // Navigate directly to TeamRegistrationView
            NavigationLink(
                destination: TeamRegistrationView(
                    tournamentName: title
                )
            ) {
                Text("Sign Up")
                    .font(.subheadline.bold())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("AppBlack"), Color.blue.opacity(0.15)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.blue.opacity(0.8), lineWidth: 1.5)
        )
        .shadow(color: Color.blue.opacity(0.3), radius: 6, x: 0, y: 3)
    }
}

#Preview {
    NavigationStack { TournamentsView() }
}

