//
//
//import SwiftUI
//
//// MARK: - TrackMyQueueView
//
//struct TrackMyQueueView: View {
//
//    @State private var yourToken = 45
//    @State private var currentServing = 41
//    @State private var estimatedWaitMinutes = 15
//    @State private var estimatedConsultationTime = "10:35 AM"
//
//    private let visibleQueueStart = 41
//    private let queueLength = 6
//
//    var queueTokens: [Int] {
//        Array(visibleQueueStart...(visibleQueueStart + queueLength - 1))
//    }
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 20) {
//
//                // ── Hero Token Card ───────────────────────────────────────────
//                VStack(spacing: 6) {
//                    Text("Your Token Number")
//                        .font(.subheadline)
//                        .foregroundStyle(.secondary)
//                    Text("OPD – \(yourToken)")
//                        .font(.system(size: 48, weight: .bold))
//                        .foregroundStyle(.primary)
//                }
//                .frame(maxWidth: .infinity)
//                .padding(.vertical, 32)
//                .background(
//                    RoundedRectangle(cornerRadius: 16)
//                        .fill(Color(.systemBackground))
//                        .shadow(color: .black.opacity(0.05), radius: 12, y: 4)
//                )
//
//                // ── Wait Time & Consultation ──────────────────────────────────
//                HStack(spacing: 0) {
//                    VStack(spacing: 4) {
//                        Text("\(estimatedWaitMinutes) min")
//                            .font(.title3)
//                            .fontWeight(.bold)
//                            .foregroundStyle(.primary)
//                        Text("Est. Waiting Time")
//                            .font(.caption)
//                            .foregroundStyle(.secondary)
//                    }
//                    .frame(maxWidth: .infinity)
//
//                    Rectangle()
//                        .fill(Color(.separator))
//                        .frame(width: 1, height: 40)
//
//                    VStack(spacing: 4) {
//                        Text(estimatedConsultationTime)
//                            .font(.title3)
//                            .fontWeight(.bold)
//                            .foregroundStyle(.primary)
//                        Text("Est. Consult Time")
//                            .font(.caption)
//                            .foregroundStyle(.secondary)
//                    }
//                    .frame(maxWidth: .infinity)
//                }
//                .padding(.vertical, 20)
//                .background(
//                    RoundedRectangle(cornerRadius: 16)
//                        .fill(Color(.systemBackground))
//                        .shadow(color: .black.opacity(0.05), radius: 12, y: 4)
//                )
//
//                // ── Live Queue ────────────────────────────────────────────────
//                VStack(alignment: .leading, spacing: 14) {
//
//                    // Section header
//                    HStack {
//                        Text("Live Queue")
//                            .font(.headline)
//                            .fontWeight(.semibold)
//                            .foregroundStyle(.primary)
//                        Spacer()
//                        HStack(spacing: 5) {
//                            Circle()
//                                .fill(Color.green)
//                                .frame(width: 7, height: 7)
//                            Text("Updating Live")
//                                .font(.caption)
//                                .foregroundStyle(.secondary)
//                        }
//                    }
//
//                    // Queue rows inside one card
//                    VStack(spacing: 0) {
//                        ForEach(Array(queueTokens.enumerated()), id: \.element) { index, token in
//                            QueueRow(
//                                token: token,
//                                isCurrent: token == currentServing,
//                                isNext: token == currentServing + 1,
//                                isYours: token == yourToken
//                            )
//                            if index < queueTokens.count - 1 {
//                                Divider()
//                                    .padding(.leading, 16)
//                            }
//                        }
//                    }
//                    .background(
//                        RoundedRectangle(cornerRadius: 16)
//                            .fill(Color(.systemBackground))
//                            .shadow(color: .black.opacity(0.05), radius: 12, y: 4)
//                    )
//                }
//            }
//            .padding(.horizontal, 20)
//            .padding(.top, 12)
//            .padding(.bottom, 40)
//        }
//        .background(Color(.systemGroupedBackground))
//        .navigationTitle("Queue Tracking")
//        .navigationBarTitleDisplayMode(.large)
//    }
//}
//
//// MARK: - QueueRow
//
//struct QueueRow: View {
//    let token: Int
//    let isCurrent: Bool
//    let isNext: Bool
//    let isYours: Bool
//
//    var body: some View {
//        HStack(spacing: 0) {
//            Text("OPD – \(token)")
//                .font(.subheadline)
//                .fontWeight(isCurrent || isYours ? .semibold : .regular)
//                .foregroundStyle(isYours ? .blue : .primary)
//                .frame(maxWidth: .infinity, alignment: .leading)
//
//            statusBadge
//        }
//        .padding(.horizontal, 16)
//        .padding(.vertical, 14)
//        .background(isYours ? Color.blue.opacity(0.05) : Color.clear)
//    }
//
//    @ViewBuilder
//    private var statusBadge: some View {
//        if isCurrent {
//            Text("Serving")
//                .font(.caption)
//                .fontWeight(.medium)
//                .foregroundStyle(.green)
//                .padding(.horizontal, 10)
//                .padding(.vertical, 4)
//                .background(
//                    Capsule().fill(Color.green.opacity(0.12))
//                )
//        } else if isNext {
//            Text("Next")
//                .font(.caption)
//                .fontWeight(.medium)
//                .foregroundStyle(.secondary)
//                .padding(.horizontal, 10)
//                .padding(.vertical, 4)
//                .background(
//                    Capsule().fill(Color(.secondarySystemBackground))
//                )
//        } else if isYours {
//            Text("Your Token")
//                .font(.caption)
//                .fontWeight(.medium)
//                .foregroundStyle(.blue)
//                .padding(.horizontal, 10)
//                .padding(.vertical, 4)
//                .background(
//                    Capsule().fill(Color.blue.opacity(0.1))
//                )
//        } else {
//            Text("Waiting")
//                .font(.caption)
//                .foregroundStyle(.secondary)
//        }
//    }
//}
//
//#Preview {
//    NavigationStack {
//        TrackMyQueueView()
//    }
////}
//
//
//import SwiftUI
//
//// MARK: - TrackMyQueueView
//
//struct TrackMyQueueView: View {
//
//    @State private var yourToken = 45
//    @State private var currentServing = 41
//    @State private var estimatedWaitMinutes = 15
//    @State private var estimatedConsultationTime = "10:35 AM"
//
//    private let visibleQueueStart = 41
//    private let queueLength = 6
//
//    var queueTokens: [Int] {
//        Array(visibleQueueStart...(visibleQueueStart + queueLength - 1))
//    }
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 20) {
//
//                // ── Hero Token Card ───────────────────────────────────────────
//                VStack(spacing: 8) {
//                    Text("Your Token Number")
//                        .font(.subheadline)
//                        .foregroundStyle(.secondary)
//
//                    // "OPD –" blue, number primary — creates visual accent without noise
//                    HStack(alignment: .firstTextBaseline, spacing: 6) {
//                        Text("OPD –")
//                            .font(.system(size: 28, weight: .semibold))
//                            .foregroundStyle(.blue)
//                        Text("\(yourToken)")
//                            .font(.system(size: 52, weight: .bold))
//                            .foregroundStyle(.primary)
//                    }
//                }
//                .frame(maxWidth: .infinity)
//                .padding(.vertical, 32)
//                .background(
//                    RoundedRectangle(cornerRadius: 16)
//                        .fill(Color(.systemBackground))
//                        .shadow(color: .black.opacity(0.05), radius: 12, y: 4)
//                )
//
//                // ── Wait Time & Consultation ──────────────────────────────────
//                HStack(spacing: 0) {
//                    VStack(spacing: 4) {
//                        Text("\(estimatedWaitMinutes) min")
//                            .font(.title3)
//                            .fontWeight(.bold)
//                            .foregroundStyle(.primary)
//                        Text("Est. Waiting Time")
//                            .font(.caption)
//                            .foregroundStyle(.secondary)
//                    }
//                    .frame(maxWidth: .infinity)
//
//                    Rectangle()
//                        .fill(Color(.separator))
//                        .frame(width: 1, height: 40)
//
//                    VStack(spacing: 4) {
//                        Text(estimatedConsultationTime)
//                            .font(.title3)
//                            .fontWeight(.bold)
//                            .foregroundStyle(.primary)
//                        Text("Est. Consult Time")
//                            .font(.caption)
//                            .foregroundStyle(.secondary)
//                    }
//                    .frame(maxWidth: .infinity)
//                }
//                .padding(.vertical, 20)
//                .background(
//                    RoundedRectangle(cornerRadius: 16)
//                        .fill(Color(.systemBackground))
//                        .shadow(color: .black.opacity(0.05), radius: 12, y: 4)
//                )
//
//                // ── Live Queue ────────────────────────────────────────────────
//                VStack(alignment: .leading, spacing: 14) {
//
//                    HStack {
//                        Text("Live Queue")
//                            .font(.headline)
//                            .fontWeight(.semibold)
//                            .foregroundStyle(.primary)
//                        Spacer()
//                        HStack(spacing: 5) {
//                            Circle()
//                                .fill(Color.green)
//                                .frame(width: 7, height: 7)
//                            Text("Updating Live")
//                                .font(.caption)
//                                .foregroundStyle(.secondary)
//                        }
//                    }
//
//                    VStack(spacing: 0) {
//                        ForEach(Array(queueTokens.enumerated()), id: \.element) { index, token in
//                            QueueRow(
//                                token: token,
//                                isCurrent: token == currentServing,
//                                isNext: token == currentServing + 1,
//                                isYours: token == yourToken
//                            )
//                            if index < queueTokens.count - 1 {
//                                Divider().padding(.leading, 16)
//                            }
//                        }
//                    }
//                    .background(
//                        RoundedRectangle(cornerRadius: 16)
//                            .fill(Color(.systemBackground))
//                            .shadow(color: .black.opacity(0.05), radius: 12, y: 4)
//                    )
//                }
//            }
//            .padding(.horizontal, 20)
//            .padding(.top, 12)
//            .padding(.bottom, 40)
//        }
//        .background(Color(.systemGroupedBackground))
//        .navigationTitle("Queue Tracking")
//        .navigationBarTitleDisplayMode(.large)
//    }
//}
//
//// MARK: - QueueRow
//
//struct QueueRow: View {
//    let token: Int
//    let isCurrent: Bool
//    let isNext: Bool
//    let isYours: Bool
//
//    var body: some View {
//        HStack(spacing: 0) {
//            // Plain token label — no colour variance in the list
//            Text("OPD – \(token)")
//                .font(.subheadline)
//                .fontWeight(isCurrent || isYours ? .semibold : .regular)
//                .foregroundStyle(.primary)
//                .frame(maxWidth: .infinity, alignment: .leading)
//
//            statusBadge
//        }
//        .padding(.horizontal, 16)
//        .padding(.vertical, 14)
//        .background(isYours ? Color.blue.opacity(0.05) : Color.clear)
//    }
//
//    @ViewBuilder
//    private var statusBadge: some View {
//        if isCurrent {
//            Text("Serving")
//                .font(.caption)
//                .fontWeight(.medium)
//                .foregroundStyle(.green)
//                .padding(.horizontal, 10)
//                .padding(.vertical, 4)
//                .background(Capsule().fill(Color.green.opacity(0.12)))
//        } else if isNext {
//            Text("Next")
//                .font(.caption)
//                .fontWeight(.medium)
//                .foregroundStyle(.secondary)
//                .padding(.horizontal, 10)
//                .padding(.vertical, 4)
//                .background(Capsule().fill(Color(.secondarySystemBackground)))
//        } else if isYours {
//            Text("Your Token")
//                .font(.caption)
//                .fontWeight(.medium)
//                .foregroundStyle(.blue)
//                .padding(.horizontal, 10)
//                .padding(.vertical, 4)
//                .background(Capsule().fill(Color.blue.opacity(0.1)))
//        } else {
//            Text("Waiting")
//                .font(.caption)
//                .foregroundStyle(.secondary)
//        }
//    }
//}
//
//#Preview {
//    NavigationStack {
//        TrackMyQueueView()
//    }
//}

import SwiftUI

// MARK: - TrackMyQueueView

struct TrackMyQueueView: View {

    @State private var yourToken = 45
    @State private var currentServing = 41
    @State private var estimatedWaitMinutes = 15
    @State private var estimatedConsultationTime = "10:35 AM"

    private let visibleQueueStart = 41
    private let queueLength = 6

    var queueTokens: [Int] {
        Array(visibleQueueStart...(visibleQueueStart + queueLength - 1))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // ── Hero Token Card ─────────────────────────
                VStack(spacing: 8) {

                    Text("Your Token Number")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    // SAME SIZE + SAME COLOR
                    Text("OPD – \(yourToken)")
                        .font(.system(size: 52, weight: .bold))
                        .foregroundStyle(.blue)

                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 32)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.05), radius: 12, y: 4)
                )

                // ── Wait Time & Consultation ───────────────
                HStack(spacing: 0) {

                    VStack(spacing: 4) {
                        Text("\(estimatedWaitMinutes) min")
                            .font(.title3)
                            .fontWeight(.bold)

                        Text("Est. Waiting Time")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)

                    Rectangle()
                        .fill(Color(.separator))
                        .frame(width: 1, height: 40)

                    VStack(spacing: 4) {
                        Text(estimatedConsultationTime)
                            .font(.title3)
                            .fontWeight(.bold)

                        Text("Est. Consult Time")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.vertical, 20)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.05), radius: 12, y: 4)
                )

                // ── Live Queue ─────────────────────────────
                VStack(alignment: .leading, spacing: 14) {

                    HStack {
                        Text("Live Queue")
                            .font(.headline)
                            .fontWeight(.semibold)

                        Spacer()

                        HStack(spacing: 5) {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 7, height: 7)

                            Text("Updating Live")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }

                    VStack(spacing: 0) {
                        ForEach(Array(queueTokens.enumerated()), id: \.element) { index, token in
                            QueueRow(
                                token: token,
                                isCurrent: token == currentServing,
                                isNext: token == currentServing + 1,
                                isYours: token == yourToken
                            )

                            if index < queueTokens.count - 1 {
                                Divider().padding(.leading, 16)
                            }
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.05), radius: 12, y: 4)
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 40)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Queue Tracking")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: - QueueRow

struct QueueRow: View {
    let token: Int
    let isCurrent: Bool
    let isNext: Bool
    let isYours: Bool

    var body: some View {
        HStack(spacing: 0) {

            Text("OPD – \(token)")
                .font(.subheadline)
                .fontWeight(isCurrent || isYours ? .semibold : .regular)
                .frame(maxWidth: .infinity, alignment: .leading)

            statusBadge
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(isYours ? Color.blue.opacity(0.05) : Color.clear)
    }

    @ViewBuilder
    private var statusBadge: some View {

        if isCurrent {

            Text("Serving")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.green)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Capsule().fill(Color.green.opacity(0.12)))

        } else if isNext {

            Text("Next")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Capsule().fill(Color(.secondarySystemBackground)))

        } else if isYours {

            Text("Your Token")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.blue)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Capsule().fill(Color.blue.opacity(0.1)))

        } else {

            Text("Waiting")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    NavigationStack {
        TrackMyQueueView()
    }
}
