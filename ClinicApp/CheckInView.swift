////
////  CheckInView.swift
////  ClinicApp
////
////  Created by COBSCCOM-45 on 2026-03-11.
////
//
//import SwiftUI
//
//// MARK: - CheckInView
//// Pushed via NavigationLink from HomeView's "Check In" button.
//// The system provides the "< Back" navigation bar button automatically.
//
//struct CheckInView: View {
//
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 24) {
//
//                // ── Main Info Card ───────────────────────────────────────────
//                VStack(spacing: 0) {
//
//                    // Token number header
//                    VStack(spacing: 8) {
//                        Text("Your Token Number")
//                            .font(.subheadline)
//                            .fontWeight(.medium)
//                            .foregroundStyle(.blue)
//
//                        Text("OPD – 45")
//                            .font(.system(size: 42, weight: .bold))
//                            .foregroundStyle(.blue)
//                    }
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical, 28)
//                    .background(
//                        RoundedRectangle(cornerRadius: 14)
//                            .fill(Color.blue.opacity(0.1))
//                    )
//                    .padding(.horizontal, 16)
//                    .padding(.top, 20)
//                    .padding(.bottom, 8)
//
//                    // ── Info Rows ────────────────────────────────────────────
//                    VStack(spacing: 0) {
//
//                        TokenInfoRow(
//                            icon: "person.2",
//                            label: "Current Token Going",
//                            value: "OPD – 21",
//                            valueColor: .primary
//                        )
//
//                        Divider().padding(.leading, 52)
//
//                        TokenInfoRow(
//                            icon: "timer",
//                            label: "Average Time per\nPatient",
//                            value: "15\nMinutes",
//                            valueColor: .primary
//                        )
//
//                        Divider().padding(.leading, 52)
//
//                        TokenInfoRow(
//                            icon: "clock",
//                            label: "Estimated Consultation",
//                            value: "10:35 AM",
//                            valueColor: .primary
//                        )
//
//                        Divider().padding(.leading, 52)
//
//                        TokenInfoRow(
//                            icon: "hourglass",
//                            label: "Remaining Waiting\nTime",
//                            value: "2 Hours 15\nMinutes",
//                            valueColor: .green
//                        )
//
//                        Divider().padding(.leading, 52)
//
//                        TokenInfoRow(
//                            icon: "calendar",
//                            label: "Today's OPD\nSession",
//                            value: "8:00 AM – 8:00\nPM",
//                            valueColor: .primary
//                        )
//                    }
//                    .padding(.top, 8)
//                    .padding(.bottom, 12)
//                }
//                .background(
//                    RoundedRectangle(cornerRadius: 20)
//                        .fill(Color(.systemBackground))
//                        .shadow(color: .black.opacity(0.05), radius: 15, y: 5)
//                )
//            }
//            .padding(.horizontal, 20)
//            .padding(.top, 12)
//            .padding(.bottom, 32)
//        }
//        .background(Color(.systemGroupedBackground))
//        .navigationTitle("Token Status")
//        .navigationBarTitleDisplayMode(.large)
//        .toolbarBackground(Color(.systemGroupedBackground), for: .navigationBar)
//        .toolbarBackground(.visible, for: .navigationBar)
//    }
//}
//
//// MARK: - TokenInfoRow
//
//struct TokenInfoRow: View {
//    let icon: String
//    let label: String
//    let value: String
//    let valueColor: Color
//
//    var body: some View {
//        HStack(alignment: .center, spacing: 14) {
//
//            // Icon
//            Image(systemName: icon)
//                .font(.system(size: 18, weight: .light))
//                .foregroundStyle(.secondary)
//                .frame(width: 24, alignment: .center)
//                .padding(.leading, 16)
//
//            // Label — supports multiline via \n
//            Text(label)
//                .font(.subheadline)
//                .foregroundStyle(.secondary)
//                .fixedSize(horizontal: false, vertical: true)
//                .frame(maxWidth: .infinity, alignment: .leading)
//
//            // Value — right aligned, supports multiline
//            Text(value)
//                .font(.subheadline)
//                .fontWeight(.bold)
//                .foregroundStyle(valueColor)
//                .multilineTextAlignment(.trailing)
//                .fixedSize(horizontal: false, vertical: true)
//                .padding(.trailing, 16)
//        }
//        .padding(.vertical, 16)
//    }
//}
//
//#Preview {
//    NavigationStack {
//        CheckInView()
//    }
//}


import SwiftUI

// MARK: - CheckInView

struct CheckInView: View {

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                // MARK: Main Card

                VStack(spacing: 0) {

                    // Token Header
                    VStack(spacing: 8) {

                        Text("Your Token Number")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.blue)

                        Text("OPD – 45")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundStyle(.blue)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 28)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.blue.opacity(0.1))
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                    .padding(.bottom, 10)


                    // MARK: Info Rows

                    VStack(spacing: 0) {

                        TokenInfoRow(
                            icon: "person.2",
                            label: "Current Token Going",
                            value: "OPD – 21",
                            valueColor: .primary
                        )

                        Divider().padding(.leading, 52)

                        TokenInfoRow(
                            icon: "timer",
                            label: "Average Time per\nPatient",
                            value: "15\nMinutes",
                            valueColor: .primary
                        )

                        Divider().padding(.leading, 52)

                        TokenInfoRow(
                            icon: "clock",
                            label: "Estimated Consultation",
                            value: "10:35 AM",
                            valueColor: .primary
                        )

                        Divider().padding(.leading, 52)

                        TokenInfoRow(
                            icon: "hourglass",
                            label: "Remaining Waiting\nTime",
                            value: "2 Hours 15\nMinutes",
                            valueColor: .green
                        )

                        Divider().padding(.leading, 52)

                        TokenInfoRow(
                            icon: "calendar",
                            label: "Today's OPD\nSession",
                            value: "8:00 AM – 8:00\nPM",
                            valueColor: .primary
                        )
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 12)

                }
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemBackground))
                        .shadow(
                            color: .black.opacity(0.05),
                            radius: 12,
                            y: 4
                        )
                )

            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .padding(.bottom, 40)

        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Token Status")

        // Inline keeps the title visible while scrolling
        .navigationBarTitleDisplayMode(.inline)

        // iOS styled background
        .toolbarBackground(
            Color(.systemGroupedBackground),
            for: .navigationBar
        )
        .toolbarBackground(.visible, for: .navigationBar)
    }
}


// MARK: - TokenInfoRow

struct TokenInfoRow: View {

    let icon: String
    let label: String
    let value: String
    let valueColor: Color

    var body: some View {

        HStack(alignment: .center, spacing: 14) {

            // Icon
            Image(systemName: icon)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(.secondary)
                .frame(width: 24)
                .padding(.leading, 16)

            // Label
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Value
            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(valueColor)
                .multilineTextAlignment(.trailing)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.trailing, 16)
        }
        .padding(.vertical, 16)
    }
}


#Preview {
    NavigationStack {
        CheckInView()
    }
}
