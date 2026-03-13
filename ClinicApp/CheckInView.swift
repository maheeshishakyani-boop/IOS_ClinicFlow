
import SwiftUI

// MARK: - CheckInView

struct CheckInView: View {

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                // ── Token Number Card ────────────────────────────────────────
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

                // ── Individual Info Cards ────────────────────────────────────

                TokenCard(
                    icon: "person.2",
                    label: "Current Token Going",
                    value: "OPD – 21"
                )

                TokenCard(
                    icon: "timer",
                    label: "Average Time per Patient",
                    value: "15 Minutes"
                )

                TokenCard(
                    icon: "clock",
                    label: "Estimated Consultation",
                    value: "10:35 AM"
                )

                TokenCard(
                    icon: "hourglass",
                    label: "Remaining Waiting Time",
                    value: "2 hrs 15 min",
                    highlight: true
                )

                TokenCard(
                    icon: "calendar",
                    label: "Today's OPD Session",
                    value: "8:00 AM – 8:00 PM"
                )
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
    NavigationStack {
        CheckInView()
    }
}
