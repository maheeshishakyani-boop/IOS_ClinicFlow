


import SwiftUI

struct TrackMyQueueView: View {
    @State private var yourToken = 45
    @State private var currentServing = 41
    @State private var estimatedWaitMinutes = 15
    @State private var estimatedConsultationTime = "10:35 AM"
    
    // Static queue showing tokens 41 through 46
    private let visibleQueueStart = 41
    private let queueLength = 6
    
    var queueTokens: [Int] {
        Array(visibleQueueStart...(visibleQueueStart + queueLength - 1))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 28) {
                    
                    // Hero Token Card
                    VStack(spacing: 8) {
                        Text("YOUR TOKEN NUMBER")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                            .tracking(1)
                        
                        Text("OPD - \(yourToken)")
                            .font(.system(size: 56, weight: .bold, design: .rounded))
                            .foregroundStyle(.blue)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 36)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.07), radius: 20, y: 8)
                    )
                    
                    // Wait + Consult Time (side by side)
                    HStack(spacing: 0) {
                        VStack(spacing: 8) {
                            Image(systemName: "clock.fill")
                                .font(.title2)
                                .foregroundStyle(.blue)
                            Text("\(estimatedWaitMinutes) Mins")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text("Est. Waiting Time")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        
                        Rectangle()
                            .fill(Color.gray.opacity(0.18))
                            .frame(width: 1, height: 80)
                        
                        VStack(spacing: 8) {
                            Image(systemName: "calendar")
                                .font(.title2)
                                .foregroundStyle(.blue)
                            Text(estimatedConsultationTime)
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text("Est. Consult Time")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(24)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.07), radius: 20, y: 8)
                    )
                    
                    // LIVE QUEUE SECTION
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("LIVE QUEUE")
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            HStack(spacing: 6) {
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 8, height: 8)
                                Text("Updating Live")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        
                        // Queue List – 41 at top as current, 45 as your token, 46 at bottom
                        VStack(spacing: 12) {
                            ForEach(queueTokens, id: \.self) { token in
                                QueueRow(
                                    token: token,
                                    isCurrent: token == currentServing,
                                    isNext: token == currentServing + 1,
                                    isYours: token == yourToken
                                )
                            }
                        }
                    }
                }
                .padding(20)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Queue Tracking")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// MARK: - Queue Row Component
struct QueueRow: View {
    let token: Int
    let isCurrent: Bool
    let isNext: Bool
    let isYours: Bool
    
    var body: some View {
        HStack {
            Text("OPD - \(token)")
                .font(.title3)
                .fontWeight(isYours ? .bold : .semibold)
                .foregroundStyle(isYours ? .blue : .primary)
            
            Spacer()
            
            if isCurrent {
                Text("Currently Serving")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Capsule().fill(Color.green.opacity(0.18)))
                    .foregroundStyle(.green)
            } else if isNext {
                Text("Next")
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .foregroundStyle(.orange)
            } else if isYours {
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Your Turn Soon")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Capsule().fill(Color.blue))
                        .foregroundStyle(.white)
                    
                    Text("Your token is here")
                        .font(.caption2)
                        .foregroundStyle(.blue.opacity(0.8))
                }
            } else {
                Text("Waiting")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(isYours ? Color.blue.opacity(0.08) : Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isYours ? Color.blue.opacity(0.4) : Color.clear, lineWidth: 1.5)
        )
    }
}

#Preview {
    NavigationStack {
        TrackMyQueueView()
    }
}
