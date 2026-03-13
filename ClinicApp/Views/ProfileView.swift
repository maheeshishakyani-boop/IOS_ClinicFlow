////
////  ProfileView.swift
////  ClinicApp
////
////  Created by BSCComp-046 on 2026-03-13.
////
//
////
////  ProfileView.swift
////  ClinicApp
////
////  Created by YourName on 2026-03-13.
////
//
//import SwiftUI
//
//struct ProfileView: View {
//    @Environment(\.dismiss) private var dismiss
//    @State private var showingLogoutAlert = false
//
//    var body: some View {
//        NavigationStack {
//            List {
//                // Profile Header
//                Section {
//                    HStack(spacing: 16) {
//                        Circle()
//                            .fill(
//                                LinearGradient(
//                                    colors: [.blue, .cyan],
//                                    startPoint: .topLeading,
//                                    endPoint: .bottomTrailing
//                                )
//                            )
//                            .frame(width: 64, height: 64)
//                            .overlay(
//                                Text("TP")
//                                    .font(.title2)
//                                    .fontWeight(.bold)
//                                    .foregroundStyle(.white)
//                            )
//
//                        VStack(alignment: .leading, spacing: 4) {
//                            Text("Tharun Perera")
//                                .font(.title3)
//                                .fontWeight(.semibold)
//                            Text("OPD: 12345678")
//                                .font(.subheadline)
//                                .foregroundStyle(.secondary)
//                        }
//                    }
//                    .padding(.vertical, 8)
//                }
//
//                // Contact Information
//                Section("Contact Information") {
//                    HStack {
//                        Label("Mobile Number", systemImage: "phone")
//                        Spacer()
//                        Text("071 653 7378")
//                            .font(.subheadline)
//                            .foregroundStyle(.secondary)
//                    }
//
//                    HStack {
//                        Label("Email", systemImage: "envelope")
//                        Spacer()
//                        Text("tharun@email.com")
//                            .font(.subheadline)
//                            .foregroundStyle(.secondary)
//                    }
//                }
//
//                // Account Settings
//                Section("Account Settings") {
//                    NavigationLink {
//                        OPDDetailsView()
//                    } label: {
//                        Label("OPD Registration Details", systemImage: "clipboard")
//                    }
//
//                    NavigationLink {
//                        EditProfileView()
//                    } label: {
//                        Label("Edit Profile", systemImage: "pencil")
//                    }
//
//                    NavigationLink {
//                        NotificationSettingsView()
//                    } label: {
//                        Label("Notifications", systemImage: "bell")
//                    }
//                }
//
//                // Support
//                Section("Support") {
//                    Label("Help Center", systemImage: "questionmark.circle")
//                    Label("Contact Us", systemImage: "phone.badge.waveform")
//                    Label("Privacy Policy", systemImage: "lock.shield")
//                }
//
//                // Logout
//                Section {
//                    Button(role: .destructive) {
//                        showingLogoutAlert = true
//                    } label: {
//                        HStack {
//                            Spacer()
//                            Label("Log Out", systemImage: "rectangle.portrait.and.arrow.right")
//                                .fontWeight(.semibold)
//                            Spacer()
//                        }
//                    }
//                }
//            }
//            .navigationTitle("Profile")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button("Done") { dismiss() }
//                        .fontWeight(.semibold)
//                }
//            }
//            .alert("Log Out", isPresented: $showingLogoutAlert) {
//                Button("Log Out", role: .destructive) { dismiss() }
//                Button("Cancel", role: .cancel) {}
//            } message: {
//                Text("Are you sure you want to log out?")
//            }
//        }
//    }
//}
//
//// MARK: - OPD Details View
//struct OPDDetailsView: View {
//    var body: some View {
//        List {
//            Section("Registration") {
//                detailRow(label: "OPD Number", value: "12345678")
//                detailRow(label: "Registration Date", value: "01 Mar 2026")
//                detailRow(label: "Registration Time", value: "09:15 AM")
//            }
//
//            Section("Patient Information") {
//                detailRow(label: "Full Name", value: "Tharun Perera")
//                detailRow(label: "NIC Number", value: "199912345678")
//                detailRow(label: "Date of Birth", value: "12 Jan 1999")
//                detailRow(label: "Age", value: "27 years")
//                detailRow(label: "Gender", value: "Male")
//                detailRow(label: "Address", value: "45 Galle Road, Colombo 03")
//                detailRow(label: "Mobile Number", value: "071 653 7378")
//            }
//        }
//        .navigationTitle("OPD Registration")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//
//    private func detailRow(label: String, value: String) -> some View {
//        HStack {
//            Text(label)
//                .foregroundStyle(.primary)
//            Spacer()
//            Text(value)
//                .foregroundStyle(.secondary)
//                .multilineTextAlignment(.trailing)
//        }
//    }
//}
//
//// MARK: - Edit Profile View
//struct EditProfileView: View {
//    @Environment(\.dismiss) private var dismiss
//
//    @State private var fullName = "Tharun Perera"
//    @State private var nicNumber = "199912345678"
//    @State private var dateOfBirth = Calendar.current.date(
//        from: DateComponents(year: 1999, month: 1, day: 12)
//    ) ?? Date()
//    @State private var address = "45 Galle Road, Colombo 03"
//    @State private var mobile = "071 653 7378"
//    @FocusState private var focusedField: EditField?
//
//    enum EditField { case name, nic, address, mobile }
//
//    private let gender = "Male"
//
//    private var age: Int {
//        Calendar.current.dateComponents([.year], from: dateOfBirth, to: Date()).year ?? 0
//    }
//
//    var body: some View {
//        List {
//            // Avatar
//            Section {
//                HStack {
//                    Spacer()
//                    VStack(spacing: 10) {
//                        Circle()
//                            .fill(
//                                LinearGradient(
//                                    colors: [.blue, .cyan],
//                                    startPoint: .topLeading,
//                                    endPoint: .bottomTrailing
//                                )
//                            )
//                            .frame(width: 72, height: 72)
//                            .overlay(
//                                Text("TP")
//                                    .font(.title2)
//                                    .fontWeight(.bold)
//                                    .foregroundStyle(.white)
//                            )
//                        Button("Change Photo") {}
//                            .font(.subheadline)
//                            .foregroundStyle(.blue)
//                    }
//                    Spacer()
//                }
//                .padding(.vertical, 8)
//            }
//
//            Section("Personal Information") {
//                editableField(
//                    label: "Full Name",
//                    placeholder: "Enter full name",
//                    text: $fullName,
//                    field: .name,
//                    keyboard: .default
//                )
//
//                editableField(
//                    label: "NIC Number",
//                    placeholder: "Enter NIC number",
//                    text: $nicNumber,
//                    field: .nic,
//                    keyboard: .default
//                )
//
//                DatePicker(
//                    "Date of Birth",
//                    selection: $dateOfBirth,
//                    in: ...Date(),
//                    displayedComponents: .date
//                )
//
//                HStack {
//                    Text("Age")
//                        .foregroundStyle(.primary)
//                    Spacer()
//                    Text("\(age) years")
//                        .foregroundStyle(.secondary)
//                }
//
//                HStack {
//                    Text("Gender")
//                        .foregroundStyle(.primary)
//                    Spacer()
//                    Text(gender)
//                        .foregroundStyle(.secondary)
//                }
//
//                editableField(
//                    label: "Address",
//                    placeholder: "Enter address",
//                    text: $address,
//                    field: .address,
//                    keyboard: .default
//                )
//
//                editableField(
//                    label: "Mobile Number",
//                    placeholder: "Enter mobile number",
//                    text: $mobile,
//                    field: .mobile,
//                    keyboard: .phonePad
//                )
//            }
//        }
//        .navigationTitle("Edit Profile")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                Button("Save") { dismiss() }
//                    .fontWeight(.semibold)
//            }
//        }
//    }
//
//    @ViewBuilder
//    private func editableField(
//        label: String,
//        placeholder: String,
//        text: Binding<String>,
//        field: EditField,
//        keyboard: UIKeyboardType
//    ) -> some View {
//        VStack(alignment: .leading, spacing: 4) {
//            Text(label)
//                .font(.caption)
//                .foregroundStyle(.secondary)
//            TextField(placeholder, text: text)
//                .keyboardType(keyboard)
//                .focused($focusedField, equals: field)
//        }
//        .padding(.vertical, 4)
//    }
//}
//
//// MARK: - Notification Settings View
//struct NotificationSettingsView: View {
//    @State private var queueUpdates = true
//    @State private var tokenCalled = true
//    @State private var appointmentReminders = true
//    @State private var checkInConfirmation = true
//    @State private var prescriptionReady = false
//    @State private var labResultsReady = false
//
//    var body: some View {
//        List {
//            Section("Queue & Appointments") {
//                Toggle("Queue Updates", isOn: $queueUpdates)
//                Toggle("Your Token Called", isOn: $tokenCalled)
//                Toggle("Appointment Reminders", isOn: $appointmentReminders)
//                Toggle("Check-In Confirmation", isOn: $checkInConfirmation)
//            }
//
//            Section("Clinical") {
//                Toggle("Prescription Ready", isOn: $prescriptionReady)
//                Toggle("Lab Results Ready", isOn: $labResultsReady)
//            }
//        }
//        .navigationTitle("Notifications")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}
//
//#Preview {
//    ProfileView()
//}

//
//  ProfileView.swift
//  ClinicApp
//
//  Created by YourName on 2026-03-13.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showingLogoutAlert = false
    @State private var navigateToLogin = false

    var body: some View {
        NavigationStack {
            List {
                // Profile Header
                Section {
                    HStack(spacing: 16) {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [.blue, .cyan],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 64, height: 64)
                            .overlay(
                                Text("TP")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            )

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Tharun Perera")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text("OPD: 12345678")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }

                // Contact Information
                Section("Contact Information") {
                    HStack {
                        Label("Mobile Number", systemImage: "phone")
                        Spacer()
                        Text("071 653 7378")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }

                    HStack {
                        Label("Email", systemImage: "envelope")
                        Spacer()
                        Text("tharun@email.com")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                // Account Settings
                Section("Account Settings") {
                    NavigationLink {
                        OPDDetailsView()
                    } label: {
                        Label("OPD Registration Details", systemImage: "clipboard")
                    }

                    NavigationLink {
                        EditProfileView()
                    } label: {
                        Label("Edit Profile", systemImage: "pencil")
                    }

                    NavigationLink {
                        NotificationSettingsView()
                    } label: {
                        Label("Notifications", systemImage: "bell")
                    }
                }

                // Support
                Section("Support") {
                    Label("Help Center", systemImage: "questionmark.circle")
                    Label("Contact Us", systemImage: "phone.badge.waveform")
                    Label("Privacy Policy", systemImage: "lock.shield")
                }

                // Logout
                Section {
                    Button(role: .destructive) {
                        showingLogoutAlert = true
                    } label: {
                        HStack {
                            Spacer()
                            Label("Log Out", systemImage: "rectangle.portrait.and.arrow.right")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                        .fontWeight(.semibold)
                }
            }
            .alert("Log Out", isPresented: $showingLogoutAlert) {
                Button("Log Out", role: .destructive) {
                    // Navigate to login
                    navigateToLogin = true
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure you want to log out?")
            }
            // Navigation destination to LoginView when logged out
            .fullScreenCover(isPresented: $navigateToLogin) {
                LoginView()
            }
        }
    }
}

// MARK: - OPD Details View
struct OPDDetailsView: View {
    var body: some View {
        List {
            Section("Registration") {
                detailRow(label: "OPD Number", value: "12345678")
                detailRow(label: "Registration Date", value: "01 Mar 2026")
                detailRow(label: "Registration Time", value: "09:15 AM")
            }

            Section("Patient Information") {
                detailRow(label: "Full Name", value: "Tharun Perera")
                detailRow(label: "NIC Number", value: "199912345678")
                detailRow(label: "Date of Birth", value: "12 Jan 1999")
                detailRow(label: "Age", value: "27 years")
                detailRow(label: "Gender", value: "Male")
                detailRow(label: "Address", value: "45 Galle Road, Colombo 03")
                detailRow(label: "Mobile Number", value: "071 653 7378")
            }
        }
        .navigationTitle("OPD Registration")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func detailRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .foregroundStyle(.primary)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.trailing)
        }
    }
}

// MARK: - Edit Profile View
struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var fullName = "Tharun Perera"
    @State private var nicNumber = "199912345678"
    @State private var dateOfBirth = Calendar.current.date(
        from: DateComponents(year: 1999, month: 1, day: 12)
    ) ?? Date()
    @State private var address = "45 Galle Road, Colombo 03"
    @State private var mobile = "071 653 7378"
    @FocusState private var focusedField: EditField?

    enum EditField { case name, nic, address, mobile }

    private let gender = "Male"

    private var age: Int {
        Calendar.current.dateComponents([.year], from: dateOfBirth, to: Date()).year ?? 0
    }

    var body: some View {
        List {
            // Avatar
            Section {
                HStack {
                    Spacer()
                    VStack(spacing: 10) {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [.blue, .cyan],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 72, height: 72)
                            .overlay(
                                Text("TP")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            )
                        Button("Change Photo") {}
                            .font(.subheadline)
                            .foregroundStyle(.blue)
                    }
                    Spacer()
                }
                .padding(.vertical, 8)
            }

            Section("Personal Information") {
                editableField(
                    label: "Full Name",
                    placeholder: "Enter full name",
                    text: $fullName,
                    field: .name,
                    keyboard: .default
                )

                editableField(
                    label: "NIC Number",
                    placeholder: "Enter NIC number",
                    text: $nicNumber,
                    field: .nic,
                    keyboard: .default
                )

                DatePicker(
                    "Date of Birth",
                    selection: $dateOfBirth,
                    in: ...Date(),
                    displayedComponents: .date
                )

                HStack {
                    Text("Age")
                        .foregroundStyle(.primary)
                    Spacer()
                    Text("\(age) years")
                        .foregroundStyle(.secondary)
                }

                HStack {
                    Text("Gender")
                        .foregroundStyle(.primary)
                    Spacer()
                    Text(gender)
                        .foregroundStyle(.secondary)
                }

                editableField(
                    label: "Address",
                    placeholder: "Enter address",
                    text: $address,
                    field: .address,
                    keyboard: .default
                )

                editableField(
                    label: "Mobile Number",
                    placeholder: "Enter mobile number",
                    text: $mobile,
                    field: .mobile,
                    keyboard: .phonePad
                )
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") { dismiss() }
                    .fontWeight(.semibold)
            }
        }
    }

    @ViewBuilder
    private func editableField(
        label: String,
        placeholder: String,
        text: Binding<String>,
        field: EditField,
        keyboard: UIKeyboardType
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
            TextField(placeholder, text: text)
                .keyboardType(keyboard)
                .focused($focusedField, equals: field)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Notification Settings View
struct NotificationSettingsView: View {
    @State private var queueUpdates = true
    @State private var tokenCalled = true
    @State private var appointmentReminders = true
    @State private var checkInConfirmation = true
    @State private var prescriptionReady = false
    @State private var labResultsReady = false

    var body: some View {
        List {
            Section("Queue & Appointments") {
                Toggle("Queue Updates", isOn: $queueUpdates)
                Toggle("Your Token Called", isOn: $tokenCalled)
                Toggle("Appointment Reminders", isOn: $appointmentReminders)
                Toggle("Check-In Confirmation", isOn: $checkInConfirmation)
            }

            Section("Clinical") {
                Toggle("Prescription Ready", isOn: $prescriptionReady)
                Toggle("Lab Results Ready", isOn: $labResultsReady)
            }
        }
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProfileView()
}
