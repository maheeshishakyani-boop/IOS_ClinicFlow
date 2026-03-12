//
//
//import SwiftUI
//
//// MARK: - VisitTrackerView
//
//struct VisitTrackerView: View {
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 16) {
//                // ── Live Queue Status ────────────────────────────────────────
//                VStack(spacing: 0) {
//                    // Blue top accent bar
//                    Rectangle()
//                        .fill(Color.blue)
//                        .frame(height: 3)
//                        .cornerRadius(1.5)
//
//                    // Header row
//                    HStack {
//                        HStack(spacing: 6) {
//                            Circle()
//                                .fill(Color.green)
//                                .frame(width: 8, height: 8)
//                            Text("Live Queue Status")
//                                .font(.subheadline)
//                                .fontWeight(.semibold)
//                        }
//                        Spacer()
//                        Text("Dept: OPD")
//                            .font(.caption)
//                            .fontWeight(.medium)
//                            .foregroundColor(.secondary)
//                            .padding(.horizontal, 10)
//                            .padding(.vertical, 4)
//                            .background(Color(.systemGray6))
//                            .cornerRadius(12)
//                    }
//                    .padding(.horizontal, 16)
//                    .padding(.top, 12)
//                    .padding(.bottom, 8)
//
//                    Divider()
//                        .padding(.horizontal, 16)
//
//                    // Token numbers
//                    HStack(spacing: 0) {
//                        VStack(spacing: 2) {
//                            Text("Current Number")
//                                .font(.caption)
//                                .foregroundColor(.secondary)
//                            Text("45")
//                                .font(.system(size: 36, weight: .bold))
//                        }
//                        .frame(maxWidth: .infinity)
//                        .padding(.vertical, 12)
//
//                        Divider()
//                            .frame(height: 40)
//
//                        VStack(spacing: 2) {
//                            Text("Your Number")
//                                .font(.caption)
//                                .foregroundColor(.secondary)
//                            Text("55")
//                                .font(.system(size: 36, weight: .bold))
//                                .foregroundColor(.blue)
//                        }
//                        .frame(maxWidth: .infinity)
//                        .padding(.vertical, 12)
//                    }
//                }
//                .background(Color(.systemBackground))
//                .cornerRadius(16)
//                .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 2)
//
//                // ── Visit Progress Summary Card ───────────────────────────────
//                HStack {
//                    VStack(alignment: .leading, spacing: 4) {
//                        Text("VISIT PROGRESS")
//                            .font(.caption2)
//                            .fontWeight(.semibold)
//                            .foregroundColor(.secondary)
//                            .kerning(0.5)
//                        Text("Step 2 of 4")
//                            .font(.title3)
//                            .fontWeight(.bold)
//                    }
//                    Spacer()
//                    HStack(spacing: 4) {
//                        Circle()
//                            .fill(Color.blue)
//                            .frame(width: 6, height: 6)
//                        Text("In Progress")
//                            .font(.caption2)
//                            .fontWeight(.medium)
//                            .foregroundColor(.blue)
//                    }
//                    .padding(.horizontal, 10)
//                    .padding(.vertical, 4)
//                    .background(Color.blue.opacity(0.1))
//                    .cornerRadius(12)
//                }
//                .padding(.horizontal, 16)
//                .padding(.vertical, 16)
//                .background(Color(.systemBackground))
//                .cornerRadius(16)
//                .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 2)
//
//                // ── Timeline ─────────────────────────────────────────────────
//                VStack(alignment: .leading, spacing: 0) {
//                    TimelineStep(
//                        state: .completed,
//                        icon: "checkmark",
//                        title: "Registration & Triage",
//                        subtitle: "Completed • 09:15 AM",
//                        isLast: false
//                    )
//
//                    TimelineStep(
//                        state: .current,
//                        icon: "stethoscope",
//                        title: "Consultation",
//                        subtitle: "General Medicine • Dr. Sarah Mitchell",
//                        badge: "CURRENT PHASE",
//                        infoMessage: "Your queue number (OPD-45) has been called. Please proceed to Room 302.",
//                        showDirections: true,
//                        isLast: false
//                    )
//
//                    TimelineStep(
//                        state: .pending,
//                        icon: "flask",
//                        title: "Laboratory",
//                        subtitle: "Pending doctor's request",
//                        isLast: false
//                    )
//
//                    TimelineStep(
//                        state: .pending,
//                        icon: "bag",
//                        title: "Pharmacy & Checkout",
//                        subtitle: "Collect medicine & finalize",
//                        isLast: true
//                    )
//                }
//                .background(Color(.systemBackground))
//                .cornerRadius(16)
//                .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 2)
//            }
//            .padding(.horizontal, 16)
//            .padding(.top, 8)
//            .padding(.bottom, 24)
//        }
//        .background(Color(.systemGroupedBackground))
//        .navigationTitle("Visit Tracker")
//        .navigationBarTitleDisplayMode(.large)
//    }
//}
//
//// MARK: - Step State
//
//enum StepState {
//    case completed, current, pending
//}
//
//// MARK: - TimelineStep
//
//struct TimelineStep: View {
//    let state: StepState
//    let icon: String
//    let title: String
//    let subtitle: String
//    var badge: String? = nil
//    var infoMessage: String? = nil
//    var showDirections: Bool = false
//    let isLast: Bool
//
//    private var iconColor: Color {
//        switch state {
//        case .completed: return .green
//        case .current: return .blue
//        case .pending: return Color(.systemGray3)
//        }
//    }
//
//    private var iconForegroundColor: Color {
//        switch state {
//        case .completed, .current: return .white
//        case .pending: return Color(.systemGray)
//        }
//    }
//
//    private var lineColor: Color {
//        switch state {
//        case .completed: return .green.opacity(0.4)
//        case .current, .pending: return Color(.systemGray4)
//        }
//    }
//
//    var body: some View {
//        HStack(alignment: .top, spacing: 12) {
//            // Left column: icon + connecting line
//            VStack(spacing: 0) {
//                ZStack {
//                    Circle()
//                        .fill(iconColor)
//                        .frame(width: 36, height: 36)
//
//                    Image(systemName: icon)
//                        .font(.system(size: 15, weight: state == .completed ? .semibold : .medium))
//                        .foregroundColor(iconForegroundColor)
//                }
//
//                if !isLast {
//                    // Use GeometryReader to fill available vertical space dynamically
//                    GeometryReader { _ in
//                        Rectangle()
//                            .fill(lineColor)
//                            .frame(width: 2)
//                            .frame(maxHeight: .infinity)
//                    }
//                    .frame(width: 2)
//                    .padding(.top, 4)
//                }
//            }
//            .frame(width: 36)
//
//            // Right column: content
//            VStack(alignment: .leading, spacing: 8) {
//                VStack(alignment: .leading, spacing: 4) {
//                    HStack(spacing: 8) {
//                        Text(title)
//                            .font(.subheadline)
//                            .fontWeight(.semibold)
//                            .foregroundColor(state == .pending ? .secondary : .primary)
//
//                        if let badge {
//                            Text(badge)
//                                .font(.system(size: 10, weight: .bold))
//                                .foregroundColor(.blue)
//                                .padding(.horizontal, 8)
//                                .padding(.vertical, 3)
//                                .background(Color.blue.opacity(0.1))
//                                .cornerRadius(10)
//                        }
//                    }
//
//                    Text(subtitle)
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                }
//
//                if let infoMessage {
//                    HStack(alignment: .top, spacing: 8) {
//                        Image(systemName: "info.circle")
//                            .font(.system(size: 14))
//                            .foregroundColor(.blue)
//
//                        Text(infoMessage)
//                            .font(.caption)
//                            .foregroundColor(.primary)
//                            .fixedSize(horizontal: false, vertical: true)
//                    }
//                    .padding(12)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .background(Color.blue.opacity(0.05))
//                    .cornerRadius(8)
//                }
//
//                if showDirections {
//                    Button(action: {}) {
//                        HStack(spacing: 8) {
//                            Image(systemName: "map")
//                                .font(.system(size: 15, weight: .medium))
//                            Text("View Directions")
//                                .font(.subheadline)
//                                .fontWeight(.semibold)
//                        }
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 44)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                    }
//                    .padding(.top, 4)
//                }
//            }
//            .padding(.top, 8)
//            .padding(.bottom, 20)
//        }
//        .padding(.horizontal, 16)
//        .padding(.top, state == .completed ? 16 : 0)
//    }
//}
//
//#Preview {
//    NavigationStack {
//        VisitTrackerView()
//    }
//}


import SwiftUI

// MARK: - VisitTrackerView

struct VisitTrackerView: View {

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // ── Live Queue Status ────────────────────────────────────────
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

                // ── Visit Progress ────────────────────────────────────────────
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("VISIT PROGRESS")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                            .kerning(0.5)
                        Text("Step 2 of 4")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                    }
                    Spacer()
                    HStack(spacing: 5) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 7, height: 7)
                        Text("In Progress")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Capsule().fill(Color.blue.opacity(0.10)))
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
                )

                // ── Timeline ─────────────────────────────────────────────────
                // All 4 steps inside one card — same pattern as VisitRecordCard
                VStack(alignment: .leading, spacing: 0) {

                    // Step 1 — Completed
                    TimelineRow(
                        state: .completed,
                        icon: "checkmark",
                        title: "Registration & Triage",
                        subtitle: "Completed • 09:15 AM",
                        isLast: false
                    )

                    Divider().padding(.leading, 56)

                    // Step 2 — Current
                    TimelineRow(
                        state: .current,
                        icon: "stethoscope",
                        title: "Consultation",
                        subtitle: "General Medicine • Dr. Sarah Mitchell",
                        badge: "CURRENT PHASE",
                        infoMessage: "Your queue number (OPD-45) has been called. Please proceed to Room 302.",
                        showDirections: true,
                        isLast: false
                    )

                    Divider().padding(.leading, 56)

                    // Step 3 — Pending
                    TimelineRow(
                        state: .pending,
                        icon: "flask",
                        title: "Laboratory",
                        subtitle: "Pending doctor's request",
                        isLast: false
                    )

                    Divider().padding(.leading, 56)

                    // Step 4 — Pending
                    TimelineRow(
                        state: .pending,
                        icon: "bag",
                        title: "Pharmacy & Checkout",
                        subtitle: "Collect medicine & finalize",
                        isLast: true
                    )
                }
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
                )
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 32)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Visit Tracker")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - TimelineRow

struct TimelineRow: View {
    let state: StepState
    let icon: String
    let title: String
    let subtitle: String
    var badge: String? = nil
    var infoMessage: String? = nil
    var showDirections: Bool = false
    let isLast: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 0) {

            // ── Icon column ───────────────────────────────────────────────
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .fill(iconBackground)
                        .frame(width: 34, height: 34)
                    Image(systemName: icon)
                        .font(.system(size: 14, weight: state == .completed ? .bold : .medium))
                        .foregroundStyle(iconForeground)
                }
                .padding(.top, 16)

                if !isLast {
                    Rectangle()
                        .fill(state == .completed ? Color.green.opacity(0.4) : Color(.systemGray5))
                        .frame(width: 2)
                        .frame(maxHeight: .infinity)
                        .padding(.top, 4)
                }
            }
            .frame(width: 56)

            // ── Content column ────────────────────────────────────────────
            VStack(alignment: .leading, spacing: 8) {

                // Title + badge
                HStack(spacing: 8) {
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(state == .pending ? .secondary : .primary)
                    if let badge {
                        Text(badge)
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(.blue)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 3)
                            .background(Capsule().fill(Color.blue.opacity(0.10)))
                    }
                }

                // Subtitle
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                // Info message
                if let infoMessage {
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "info.circle")
                            .font(.system(size: 13))
                            .foregroundStyle(.secondary)
                            .padding(.top, 1)
                        Text(infoMessage)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.secondarySystemBackground))
                    )
                }

                // View Directions button
                if showDirections {
                    Button {} label: {
                        HStack(spacing: 6) {
                            Image(systemName: "map")
                                .font(.system(size: 14, weight: .medium))
                            Text("View Directions")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue)
                        )
                    }
                }
            }
            .padding(.top, 16)
            .padding(.trailing, 16)
            .padding(.bottom, 16)
        }
    }

    private var iconBackground: Color {
        switch state {
        case .completed: return .green
        case .current:   return .blue
        case .pending:   return Color(.systemGray5)
        }
    }

    private var iconForeground: Color {
        switch state {
        case .completed, .current: return .white
        case .pending:             return Color(.systemGray2)
        }
    }
}

// MARK: - StepState

enum StepState {
    case completed, current, pending
}

#Preview {
    NavigationStack {
        VisitTrackerView()
    }
}
