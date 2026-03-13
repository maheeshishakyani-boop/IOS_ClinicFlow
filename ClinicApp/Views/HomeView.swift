


import SwiftUI

struct HomeView: View {
    @State private var showingProfile = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {

                    // Welcome Header
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

                    // Live Queue Section
                    VStack(spacing: 0) {
                        HStack {
                            HStack(spacing: 6) {
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 8, height: 8)
                                    .overlay(
                                        Circle().stroke(Color.green.opacity(0.35), lineWidth: 3)
                                    )
                                Text("Live Queue Status")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.primary)
                            }
                            Spacer()
                            Text("Dept: OPD")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Capsule().fill(Color(.secondarySystemBackground)))
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 14)
                        .padding(.bottom, 12)

                        Divider().padding(.horizontal, 16)

                        HStack(spacing: 0) {
                            VStack(spacing: 4) {
                                Text("Current Number")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Text("45")
                                    .font(.system(size: 34, weight: .bold))
                                    .foregroundStyle(.primary)
                            }
                            .frame(maxWidth: .infinity)

                            Rectangle()
                                .fill(Color(.separator))
                                .frame(width: 1, height: 48)

                            VStack(spacing: 4) {
                                Text("Your Number")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Text("55")
                                    .font(.system(size: 34, weight: .bold))
                                    .foregroundStyle(.blue)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.vertical, 14)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
                    )

                    // Upcoming Appointment
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
                                Label("22 Jun 2026", systemImage: "calendar")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Label("9:00 AM – 5:00 PM", systemImage: "clock")
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

                    // My Services
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
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showingProfile) {
            ProfileView()
        }
    }
}

// MARK: - CheckInView
struct CheckInView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                VStack(spacing: 6) {
                    Text("Your Token Number")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(.blue)
                    Text("OPD – 45")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundStyle(.blue)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 32)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue.opacity(0.08))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.blue.opacity(0.15), lineWidth: 1)
                        )
                )

                TokenCard(icon: "person.2",    label: "Current Token Going",      value: "OPD – 21")
                TokenCard(icon: "timer",        label: "Average Time per Patient", value: "15 Minutes")
                TokenCard(icon: "clock",        label: "Estimated Consultation",   value: "10:35 AM")
                TokenCard(icon: "hourglass",    label: "Remaining Waiting Time",   value: "2 hrs 15 min", highlight: true)
                TokenCard(icon: "calendar",     label: "Today's OPD Session",      value: "9:00 AM – 5:00 PM")
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 40)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Token Status")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - TokenCard
struct TokenCard: View {
    let icon: String
    let label: String
    let value: String
    var highlight: Bool = false

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(.secondary)
                .frame(width: 20)

            Text(label)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(highlight ? Color.green : Color.primary)
                .multilineTextAlignment(.trailing)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 18)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
        )
    }
}

#Preview {
    HomeView()
}
