import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                // Matte black background
                Color("AppBlack")
                    .ignoresSafeArea()

                // HEADER: Logo overlay (closer to top)
                Image("CABA_Logo_Final")
                    .renderingMode(.template)       // allow tinting
                    .resizable()
                    .scaledToFit()
                    .frame(height: 280)            // keep same size
                    .foregroundColor(.white)       // tint to white so text shows on black
                    .padding(.top, -60)            // move logo up closer to notch
                    .clipped()

                // MAIN CONTENT (buttons + version)
                VStack {
                    Spacer().frame(height: 220)    // push buttons down a bit more

                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 18) {
                            NavigationLink(destination: TournamentsView()) {
                                HomeCard(
                                    title: "View Tournaments",
                                    subtitle: "Sign up and see schedules",
                                    icon: "sportscourt.fill",
                                    color: .blue
                                )
                            }
                            NavigationLink(destination: PlayersView()) {
                                HomeCard(
                                    title: "Players",
                                    subtitle: "Find and connect with players",
                                    icon: "person.3.fill",
                                    color: .blue
                                )
                            }
                            NavigationLink(destination: MyProfileView()) {
                                HomeCard(
                                    title: "My Profile",
                                    subtitle: "View and edit your profile",
                                    icon: "person.crop.circle.fill",
                                    color: .blue
                                )
                            }
                            NavigationLink(destination: MediaHighlightsView()) {
                                HomeCard(
                                    title: "Media & Highlights",
                                    subtitle: "Watch clips and replays",
                                    icon: "play.rectangle.fill",
                                    color: .blue
                                )
                            }
                            NavigationLink(destination: StandingsView()) {
                                HomeCard(
                                    title: "Standings & Stats",
                                    subtitle: "See top CABA players",
                                    icon: "chart.bar.fill",
                                    color: .blue
                                )
                            }

                            // VERSION NUMBER
                            Text("v1.0.0")
                                .font(.footnote)
                                .foregroundColor(Color.gray)
                                .padding(.top, 24)
                                .padding(.bottom, 40)
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
        }
    }
}

// 🔹 Reusable modern card component
struct HomeCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 28))
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(color)
                .clipShape(RoundedRectangle(cornerRadius: 16))

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .background(Color("AppBlack").opacity(0.88))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.28), lineWidth: 0.6)
        )
        .shadow(color: Color.black.opacity(0.35), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    HomeView()
}


