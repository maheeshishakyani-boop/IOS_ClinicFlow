//
//  DigitalClinicBookView.swift
//  ClinicApp
//
//  Created by BSCComp-046 on 2026-03-13.
//

//
//  DigitalClinicBookView.swift
//  ClinicApp
//
//  Created by YourName on 2026-03-13.
//

import SwiftUI

struct DigitalClinicBookView: View {
    @State private var searchText = ""
    @State private var showingDateFilter = false
    @State private var records: [VisitRecord] = sampleVisitRecords

    var filteredRecords: [VisitRecord] {
        if searchText.isEmpty { return records }
        return records.filter {
            $0.doctorName.localizedCaseInsensitiveContains(searchText) ||
            $0.department.localizedCaseInsensitiveContains(searchText) ||
            $0.diagnosis.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Live Queue Status Banner
                LiveQueueBanner()

                // Filter & Search Row
                HStack(spacing: 12) {
                    Button {
                        showingDateFilter.toggle()
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "calendar")
                                .font(.system(size: 14, weight: .medium))
                            Text("Filter Date")
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.systemBackground))
                                .shadow(color: .black.opacity(0.06), radius: 6, y: 2)
                        )
                    }

                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 14))
                            .foregroundStyle(.secondary)
                        TextField("Search records...", text: $searchText)
                            .font(.subheadline)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.06), radius: 6, y: 2)
                    )
                }

                // Next Appointment Card
                NextAppointmentCard()

                // Visit History
                VStack(alignment: .leading, spacing: 12) {
                    Text("Visit History")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)

                    ForEach(Array(filteredRecords.enumerated()), id: \.element.id) { index, _ in
                        VisitRecordCard(record: $records[index])
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 32)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Digital Clinic Book")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - Live Queue Banner
struct LiveQueueBanner: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                HStack(spacing: 6) {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 8, height: 8)
                        .overlay(
                            Circle()
                                .stroke(Color.green.opacity(0.35), lineWidth: 3)
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

            Divider()
                .padding(.horizontal, 16)

            HStack(spacing: 0) {
                VStack(spacing: 4) {
                    Text("Current Number")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("45")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundStyle(.primary)
                }
                .frame(maxWidth: .infinity)

                Rectangle()
                    .fill(Color(.separator))
                    .frame(width: 1, height: 52)

                VStack(spacing: 4) {
                    Text("Your Number")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("55")
                        .font(.system(size: 36, weight: .bold))
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
    }
}

// MARK: - Next Appointment Card
struct NextAppointmentCard: View {
    var body: some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.green)
                .frame(width: 4)
                .padding(.vertical, 6)

            VStack(alignment: .leading, spacing: 6) {
                Text("NEXT APPOINTMENT")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.green)
                    .kerning(0.5)

                HStack(spacing: 10) {
                    Image(systemName: "calendar.badge.clock")
                        .font(.system(size: 20))
                        .foregroundStyle(.green)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("28 Oct 2023, 10:00 AM")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary)
                        Text("Dr. Sarah Jenkins")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(.systemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.green.opacity(0.2), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.04), radius: 8, y: 2)
        )
    }
}

// MARK: - Visit Record Card
struct VisitRecordCard: View {
    @Binding var record: VisitRecord

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            HStack(alignment: .center, spacing: 14) {
                VStack(spacing: 2) {
                    Text(record.day)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.blue)
                    Text(record.month.uppercased())
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(.blue.opacity(0.8))
                        .kerning(0.5)
                }
                .frame(width: 44, height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue.opacity(0.1))
                )

                VStack(alignment: .leading, spacing: 3) {
                    Text(record.doctorName)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                    Text(record.department)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Button {} label: {
                    Image(systemName: "arrow.down.circle")
                        .font(.system(size: 22, weight: .light))
                        .foregroundStyle(.blue.opacity(0.7))
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 12)

            // Expanded detail
            if record.isExpanded {
                Divider()
                    .padding(.horizontal, 16)

                VStack(alignment: .leading, spacing: 16) {
                    // Diagnosis banner
                    HStack(spacing: 6) {
                        Text("DIAGNOSIS:")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.blue)
                            .kerning(0.3)
                        Text(record.diagnosis)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary)
                        Spacer()
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue.opacity(0.08))
                    )

                    // Vitals grid
                    if let vitals = record.vitals {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("VITALS")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundStyle(.secondary)
                                .kerning(0.5)

                            HStack(spacing: 0) {
                                VitalItem(label: "BP", value: vitals.bp)
                                Divider().frame(height: 36)
                                VitalItem(label: "HR", value: vitals.hr, unit: "bpm")
                                Divider().frame(height: 36)
                                VitalItem(label: "TEMP", value: vitals.temp, unit: "°F")
                                Divider().frame(height: 36)
                                VitalItem(label: "SPO2", value: vitals.spo2, unit: "%")
                            }
                            .padding(.vertical, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(.secondarySystemBackground))
                            )
                        }
                    }

                    // Prescriptions
                    if !record.prescriptions.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("PRESCRIPTIONS")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundStyle(.secondary)
                                .kerning(0.5)

                            ForEach(record.prescriptions, id: \.self) { item in
                                HStack(spacing: 10) {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 6, height: 6)
                                    Text(item)
                                        .font(.subheadline)
                                        .foregroundStyle(.primary)
                                }
                            }
                        }
                    }

                    // Lab Investigations
                    if !record.labInvestigations.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("LAB INVESTIGATIONS")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundStyle(.secondary)
                                .kerning(0.5)

                            HStack(spacing: 8) {
                                ForEach(record.labInvestigations, id: \.self) { item in
                                    Text(item)
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .foregroundStyle(.primary)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color(.secondarySystemBackground))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(Color(.separator), lineWidth: 0.5)
                                                )
                                        )
                                }
                            }
                        }
                    }

                    // Hide Details button
                    Button {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                            record.isExpanded = false
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Text("Hide Details")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Image(systemName: "chevron.up")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 2)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 14)
                .padding(.bottom, 16)

            } else {
                // Collapsed row
                Divider()
                    .padding(.horizontal, 16)

                HStack {
                    Text("DIAG:")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                    Text(record.diagnosis)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)

                    Spacer()

                    Button {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                            record.isExpanded = true
                        }
                    } label: {
                        HStack(spacing: 3) {
                            Text("View")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundStyle(.blue)
                            Image(systemName: "chevron.down")
                                .font(.system(size: 10, weight: .semibold))
                                .foregroundStyle(.blue)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
        )
    }
}

// MARK: - Vital Item
struct VitalItem: View {
    let label: String
    let value: String
    var unit: String = ""

    var body: some View {
        VStack(spacing: 3) {
            Text(label)
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(.secondary)
                .kerning(0.3)
            HStack(alignment: .firstTextBaseline, spacing: 1) {
                Text(value)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.primary)
                if !unit.isEmpty {
                    Text(unit)
                        .font(.system(size: 9))
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        DigitalClinicBookView()
    }
}
