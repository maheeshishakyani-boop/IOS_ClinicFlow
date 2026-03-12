

import SwiftUI
import Combine

// MARK: - OTPView

struct OTPView: View {
    @State private var otp: [String] = ["", "", "", ""]
    @FocusState private var focusedIndex: Int?
    @State private var timeRemaining = 60
    @State private var canResend = false
    @State private var timerSubscription: Cancellable?
    @State private var navigateToMain = false

    private var isComplete: Bool {
        otp.allSatisfy { !$0.isEmpty }
    }

    var body: some View {
        VStack(spacing: 0) {

            ScrollView {
                VStack(spacing: 40) {

                    // ── Header ───────────────────────────────────────────────
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color.blue.opacity(0.1))
                                .frame(width: 88, height: 88)

                            Image(systemName: "message.badge.filled.fill")
                                .font(.system(size: 38))
                                .foregroundStyle(.blue)
                                .symbolRenderingMode(.hierarchical)
                        }
                        .padding(.top, 32)

                        VStack(spacing: 8) {
                            Text("Verify your number")
                                .font(.title2)
                                .fontWeight(.bold)

                            Text("Enter the 4-digit code sent to\n**071 653 7378**")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                                .lineSpacing(3)
                        }
                    }

                    // ── OTP Fields ───────────────────────────────────────────
                    HStack(spacing: 14) {
                        ForEach(0..<4, id: \.self) { index in
                            OTPField(text: $otp[index], isFocused: focusedIndex == index)
                                .focused($focusedIndex, equals: index)
                                .onChange(of: otp[index]) { newValue in
                                    if !newValue.isEmpty && index < 3 {
                                        focusedIndex = index + 1
                                    }
                                    if isComplete {
                                        verifyAndNavigate()
                                    }
                                }
                        }
                    }

                    // ── Resend Section ───────────────────────────────────────
                    Group {
                        if canResend {
                            Button(action: resendCode) {
                                Text("Resend Code")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.blue)
                            }
                        } else {
                            HStack(spacing: 4) {
                                Text("Resend code in")
                                    .foregroundStyle(.secondary)
                                Text("\(timeRemaining)s")
                                    .foregroundStyle(.blue)
                                    .fontWeight(.semibold)
                                    .contentTransition(.numericText())
                                    .monospacedDigit()
                            }
                            .font(.subheadline)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }

            // ── Verify Button — pinned at bottom ─────────────────────────────
            VStack(spacing: 0) {
                Divider()

                Button(action: verifyAndNavigate) {
                    Text("Verify & Sign In")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(
                            Group {
                                if isComplete {
                                    LinearGradient(
                                        colors: [.blue, .cyan],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                } else {
                                    LinearGradient(
                                        colors: [Color(.systemGray4), Color(.systemGray4)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                }
                            }
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(
                            color: isComplete ? .blue.opacity(0.3) : .clear,
                            radius: 10,
                            y: 5
                        )
                }
                .disabled(!isComplete)
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 32)
                .navigationDestination(isPresented: $navigateToMain) {
                    MainTabView()
                        .navigationBarBackButtonHidden(true)
                }
            }
            .background(Color(.systemGroupedBackground))
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Verification")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color(.systemGroupedBackground), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            focusedIndex = 0
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }

    // MARK: - Actions

    private func verifyAndNavigate() {
        guard isComplete else { return }
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        navigateToMain = true
    }

    private func resendCode() {
        timeRemaining = 60
        canResend = false
        otp = ["", "", "", ""]
        focusedIndex = 0
        startTimer()
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }

    private func startTimer() {
        stopTimer()
        timerSubscription = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    canResend = true
                    stopTimer()
                }
            }
    }

    private func stopTimer() {
        timerSubscription?.cancel()
        timerSubscription = nil
    }
}

// MARK: - OTPField

struct OTPField: View {
    @Binding var text: String
    let isFocused: Bool

    var body: some View {
        TextField("", text: $text)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .font(.title)
            .fontWeight(.bold)
            .frame(width: 68, height: 68)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        isFocused ? Color.blue : Color(.separator),
                        lineWidth: isFocused ? 2 : 1
                    )
            )
            .onChange(of: text) { newValue in
                let filtered = newValue.filter { $0.isNumber }
                text = filtered.count > 1 ? String(filtered.prefix(1)) : filtered
            }
    }
}

#Preview {
    NavigationStack {
        OTPView()
    }
}
