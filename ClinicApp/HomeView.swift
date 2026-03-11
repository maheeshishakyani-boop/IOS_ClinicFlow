

import SwiftUI

struct HomeView: View {
    @State private var showingProfile = false
    @State private var showingNotifications = false
   
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    
                    // Welcome Header with icons
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Welcome back,")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                           
                            Text("Tharun Perera")
                                .font(.title2)
                                .fontWeight(.semibold)
                        }
                       
                        Spacer()
                       
                        // Profile and Notification Icons
                        HStack(spacing: 12) {
                            Button {
                                showingNotifications.toggle()
                            } label: {
                                Image(systemName: "bell")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundStyle(.primary)
                                    .frame(width: 40, height: 40)
                                    .background(
                                        Circle()
                                            .fill(Color(.systemBackground))
                                            .shadow(color: .black.opacity(0.05), radius: 8, y: 2)
                                    )
                            }
                           
                            Button {
                                showingProfile.toggle()
                            } label: {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [.blue, .cyan],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        Text("TP")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundStyle(.white)
                                    )
                                    .shadow(color: .blue.opacity(0.3), radius: 8, y: 3)
                            }
                        }
                    }
                    .padding(.top, 8)
                   
                    // Live Queue Section
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
                       
                        HStack(spacing: 20) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Current token")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                HStack(alignment: .firstTextBaseline, spacing: 4) {
                                    Text("45")
                                        .font(.system(size: 38, weight: .bold))
                                        .foregroundStyle(.blue)
                                    Text("General Medicine")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                           
                            Divider().frame(height: 50)
                           
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Your token")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                HStack(alignment: .firstTextBaseline, spacing: 4) {
                                    Text("55")
                                        .font(.system(size: 38, weight: .bold))
                                        .foregroundStyle(.green)
                                    Text("10 ahead")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                       
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
                   
                    // Upcoming Appointment Section
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
                           
                            Button {} label: {
                                Text("Check In")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(
                                        LinearGradient(colors: [.blue, .cyan], startPoint: .leading, endPoint: .trailing)
                                    )
                                    .foregroundStyle(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                                    .shadow(color: .blue.opacity(0.3), radius: 8, y: 4)
                            }
                        }
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.05), radius: 15, y: 5)
                    )
                   
                    // My Services Section - NOW WITH NAVIGATION
                    VStack(alignment: .leading, spacing: 16) {
                        Text("My Services")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary)
                       
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 20),
                            GridItem(.flexible(), spacing: 20)
                        ], spacing: 20) {
                            NavigationLink(destination: TrackMyQueueView()) {
                                ServiceCard(icon: "person.3.sequence.fill", title: "Track My Queue", color: .blue)
                            }
                            ServiceCard(icon: "stethoscope", title: "Visit Progress", color: .green)
                            ServiceCard(icon: "map", title: "Hospital Navigation", color: .orange)
                            ServiceCard(icon: "book.closed", title: "Digital Clinic Book", color: .purple)
                        }
                    }
                }
                .padding(20)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color(.systemGroupedBackground), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .sheet(isPresented: $showingProfile) { ProfileView() }
        .sheet(isPresented: $showingNotifications) { NotificationsView() }
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

// MARK: - ProfileView, NotificationsView, NotificationRow
struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Circle()
                            .fill(LinearGradient(colors: [.blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 60, height: 60)
                            .overlay(Text("TP").font(.title2).fontWeight(.semibold).foregroundStyle(.white))
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Tharun Perera").font(.title3).fontWeight(.semibold)
                            Text("OPD: 12345678").font(.subheadline).foregroundStyle(.secondary)
                        }
                        .padding(.leading, 8)
                    }
                    .padding(.vertical, 8)
                }
                Section("Account Settings") {
                    Label("Personal Information", systemImage: "person")
                    Label("Medical History", systemImage: "heart.text.square")
                    Label("Payment Methods", systemImage: "creditcard")
                    Label("Notifications", systemImage: "bell")
                }
                Section("Support") {
                    Label("Help Center", systemImage: "questionmark.circle")
                    Label("Contact Us", systemImage: "envelope")
                    Label("Privacy Policy", systemImage: "lock")
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ToolbarItem(placement: .topBarTrailing) { Button("Done") { dismiss() } } }
        }
    }
}

struct NotificationsView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            List {
                Section("Today") {
                    NotificationRow(icon: "calendar", title: "Appointment Reminder", message: "You have an appointment tomorrow at 9:00 AM", time: "1h ago", color: .blue)
                    NotificationRow(icon: "checkmark.circle", title: "Check-in Successful", message: "You've successfully checked in", time: "3h ago", color: .green)
                }
                Section("Yesterday") {
                    NotificationRow(icon: "doc.text", title: "Prescription Ready", message: "Your prescription is ready for pickup", time: "1d ago", color: .orange)
                }
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ToolbarItem(placement: .topBarTrailing) { Button("Done") { dismiss() } } }
        }
    }
}

struct NotificationRow: View {
    let icon: String
    let title: String
    let message: String
    let time: String
    let color: Color
   
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .fill(color.opacity(0.12))
                .frame(width: 44, height: 44)
                .overlay(Image(systemName: icon).font(.system(size: 18)).foregroundStyle(color))
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(title).font(.subheadline).fontWeight(.semibold)
                    Spacer()
                    Text(time).font(.caption).foregroundStyle(.secondary)
                }
                Text(message).font(.caption).foregroundStyle(.secondary).lineLimit(2)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    HomeView()
}
