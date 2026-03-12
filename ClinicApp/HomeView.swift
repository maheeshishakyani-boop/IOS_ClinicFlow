


import SwiftUI

struct HomeView: View {
    @State private var showingProfile = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {

                    // ── Welcome Header ───────────────────────────────────────
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Welcome back,")
                                .font(.callout)
                                .foregroundStyle(.secondary)
                            Text("Tharun Perera")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                        }

                        Spacer()

                        HStack(spacing: 12) {
                            // Bell — NavigationLink so system provides "< Back"
                            NavigationLink(destination: NotificationsView()) {
                                ZStack(alignment: .topTrailing) {
                                    Image(systemName: "bell")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundStyle(.primary)
                                        .frame(width: 44, height: 44)
                                        .background(
                                            Circle()
                                                .fill(Color(.systemBackground))
                                                .shadow(color: .black.opacity(0.07), radius: 8, y: 2)
                                        )
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 10, height: 10)
                                        .offset(x: 2, y: -2)
                                }
                            }
                            .buttonStyle(.plain)

                            // Profile avatar
                            Button { showingProfile.toggle() } label: {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [.blue, .cyan],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 44, height: 44)
                                    .overlay(
                                        Text("TP")
                                            .font(.system(size: 15, weight: .bold))
                                            .foregroundStyle(.white)
                                    )
                                    .shadow(color: .blue.opacity(0.3), radius: 8, y: 3)
                            }
                        }
                    }
                    // No extra top padding — content starts right under status bar
                    // via the ScrollView's safeAreaInset, giving a full-bleed native feel

                    // ── Live Queue ────────────────────────────────────────────
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Label("Live Queue", systemImage: "person.3.sequence.fill")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.primary)
                            Spacer()
                            Text("Updated just now")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }

                        HStack(spacing: 0) {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Current token")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                HStack(alignment: .firstTextBaseline, spacing: 6) {
                                    Text("45")
                                        .font(.system(size: 40, weight: .bold))
                                        .foregroundStyle(.blue)
                                    Text("General Medicine")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)

                            Rectangle()
                                .fill(Color(.separator))
                                .frame(width: 1, height: 52)
                                .padding(.horizontal, 16)

                            VStack(alignment: .leading, spacing: 6) {
                                Text("Your token")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                HStack(alignment: .firstTextBaseline, spacing: 6) {
                                    Text("55")
                                        .font(.system(size: 40, weight: .bold))
                                        .foregroundStyle(.green)
                                    Text("10 ahead")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.vertical, 4)

                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Estimated wait time")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Text("~15 minutes")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.blue)
                            }
                            ProgressView(value: 0.45, total: 1.0)
                                .tint(.blue)
                                .background(Color.gray.opacity(0.1))
                                .clipShape(Capsule())
                        }
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.05), radius: 15, y: 5)
                    )

                    // ── Upcoming Appointment ──────────────────────────────────
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Label("Upcoming Appointment", systemImage: "calendar")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.primary)
                            Spacer()
                            Text("Today")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(.blue)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Capsule().fill(Color.blue.opacity(0.12)))
                        }

                        Divider()

                        VStack(alignment: .leading, spacing: 12) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("General Medicine")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                Text("Dr. John Smith")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }

                            HStack(spacing: 20) {
                                Label("22 Mar 2026", systemImage: "calendar")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Label("9:00 AM", systemImage: "clock")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }

                            NavigationLink(destination: CheckInView()) {
                                Text("Check In")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(
                                        LinearGradient(
                                            colors: [.blue, .cyan],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .foregroundStyle(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                                    .shadow(color: .blue.opacity(0.3), radius: 8, y: 4)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.05), radius: 15, y: 5)
                    )

                    // ── My Services ───────────────────────────────────────────
                    VStack(alignment: .leading, spacing: 16) {
                        Text("My Services")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary)

                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible(), spacing: 16)
                        ], spacing: 16) {

                            NavigationLink(destination: TrackMyQueueView()) {
                                ServiceCard(icon: "person.3.sequence.fill", title: "Track My Queue", color: .blue)
                            }
                            .buttonStyle(.plain)

                            NavigationLink(destination: VisitTrackerView()) {
                                ServiceCard(icon: "stethoscope", title: "Visit Progress", color: .green)
                            }
                            .buttonStyle(.plain)

                            NavigationLink(destination: HNavigationScreen()) {
                                ServiceCard(icon: "map", title: "Hospital Navigation", color: .orange)
                            }
                            .buttonStyle(.plain)

                            NavigationLink(destination: DigitalClinicBookView()) {
                                ServiceCard(icon: "book.closed", title: "Digital Clinic Book", color: .purple)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 32)
            }
            .background(Color(.systemGroupedBackground))
            // Hide the navigation bar entirely — the custom header acts as the "nav bar"
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showingProfile) {
            ProfileView()
        }
    }
}

// MARK: - ServiceCard

struct ServiceCard: View {
    let icon: String
    let title: String
    let color: Color

    var body: some View {
        VStack(spacing: 14) {
            Circle()
                .fill(color.opacity(0.12))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: icon)
                        .font(.system(size: 26, weight: .medium))
                        .foregroundStyle(color)
                )
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundStyle(.primary)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.04), radius: 12, y: 4)
        )
    }
}

// ProfileView is defined in ProfileView.swift

#Preview {
    HomeView()
}
