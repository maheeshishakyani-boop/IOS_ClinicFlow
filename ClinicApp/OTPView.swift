
import SwiftUI
import Combine

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
                    // Header
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color.blue.opacity(0.1))
                                .frame(width: 100, height: 100)
                            
                            Image(systemName: "envelope.badge.shield.half.filled")
                                .font(.system(size: 44))
                                .foregroundStyle(.blue)
                                .symbolRenderingMode(.hierarchical)
                        }
                        .padding(.top, 20)
                        
                        VStack(spacing: 8) {
                            Text("Check your messages")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text("Enter the 4-digit code sent to\n**071 653 7378**")
                                .font(.body)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                    // OTP Fields
                    HStack(spacing: 12) {
                        ForEach(0..<4, id: \.self) { index in
                            OTPField(text: $otp[index], isFocused: focusedIndex == index)
                                .focused($focusedIndex, equals: index)
                                .onChange(of: otp[index]) { newValue in
                                    if !newValue.isEmpty && index < 3 {
                                        focusedIndex = index + 1
                                    }
                                    
                                    // Auto-verify when all digits are entered
                                    if isComplete {
                                        verifyAndNavigate()
                                    }
                                }
                        }
                    }
                    .padding(.horizontal, 8)
                    
                    // Resend section
                    VStack(spacing: 8) {
                        if canResend {
                            Button(action: resendCode) {
                                Text("Resend Code")
                                    .font(.headline)
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
                            }
                            .font(.subheadline)
                        }
                    }
                    .padding(.top, 20)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 32)
            }
            
            // Verify Button - Fixed at bottom
            VStack {
                Button(action: verifyAndNavigate) {
                    Text("Verify & Continue")
                        .font(.headline)
                        .fontWeight(.semibold)
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
                                    Color.gray.opacity(0.3)
                                }
                            }
                        )
                        .foregroundStyle(isComplete ? .white : .gray)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: isComplete ? .blue.opacity(0.3) : .clear, radius: 10, y: 5)
                }
                .disabled(!isComplete)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
            .background(
                Rectangle()
                    .fill(Color(.systemGroupedBackground))
                    .shadow(color: .black.opacity(0.05), radius: 8, y: -4)
            )
            
            // Navigation link to MainTabView
            NavigationLink(
                destination: MainTabView(),
                isActive: $navigateToMain
            ) {
                EmptyView()
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Verification")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            focusedIndex = 0
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    private func verifyAndNavigate() {
        // Here you would typically validate the OTP with your backend
        // For demo purposes, we'll just navigate
        guard isComplete else { return }
        
        // Show loading state or haptic feedback
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        // Add a small delay for better UX
        withAnimation(.easeInOut(duration: 0.3)) {
            navigateToMain = true
        }
    }
    
    private func startTimer() {
        stopTimer() // Cancel any existing timer
        timerSubscription = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    canResend = false
                } else {
                    canResend = true
                    stopTimer() // Stop timer when done
                }
            }
    }
    
    private func stopTimer() {
        timerSubscription?.cancel()
        timerSubscription = nil
    }
    
    private func resendCode() {
        timeRemaining = 60
        canResend = false
        startTimer() // Restart timer
        
        // Clear OTP fields
        for i in 0..<4 {
            otp[i] = ""
        }
        focusedIndex = 0
        
        // Provide haptic feedback
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        // Add your resend logic here
        print("Resend code requested")
    }
}

struct OTPField: View {
    @Binding var text: String
    let isFocused: Bool
    
    var body: some View {
        TextField("", text: $text)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .font(.title)
            .fontWeight(.semibold)
            .frame(width: 70, height: 70)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.05), radius: 8, y: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isFocused ? Color.blue : Color.gray.opacity(0.2), lineWidth: isFocused ? 2 : 1)
            )
            .onChange(of: text) { newValue in
                // Filter to only numbers
                let filtered = newValue.filter { $0.isNumber }
                if filtered.count > 1 {
                    text = String(filtered.prefix(1))
                } else {
                    text = filtered
                }
            }
    }
}

#Preview {
    NavigationStack {
        OTPView()
    }
}
