//
//import SwiftUI
//
//struct LoginView: View {
//    @State private var opdNumber: String = ""
//    @State private var mobileNumber: String = ""
//    @State private var navigateToOTP = false
//    @State private var navigateToRegister = false
//    @FocusState private var focusedField: Field?
//
//    enum Field { case opd, mobile }
//
//    private var canProceed: Bool {
//        !opdNumber.isEmpty && mobileNumber.count >= 9
//    }
//
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(spacing: 40) {
//
//                    // ── Brand Header ─────────────────────────────────────────
//                    VStack(spacing: 16) {
//                        ZStack {
//                            Circle()
//                                .fill(
//                                    LinearGradient(
//                                        colors: [.blue, .cyan],
//                                        startPoint: .topLeading,
//                                        endPoint: .bottomTrailing
//                                    )
//                                )
//                                .frame(width: 80, height: 80)
//                                .shadow(color: .blue.opacity(0.3), radius: 16, y: 6)
//
//                            Image(systemName: "cross.case.fill")
//                                .font(.system(size: 36, weight: .medium))
//                                .foregroundStyle(.white)
//                        }
//                        .padding(.top, 32)
//
//                        VStack(spacing: 8) {
//                            Text("HealthClinic")
//                                .font(.largeTitle)
//                                .fontWeight(.bold)
//
//                            Text("Sign in to manage your appointments\nand queue status")
//                                .font(.subheadline)
//                                .foregroundStyle(.secondary)
//                                .multilineTextAlignment(.center)
//                                .lineSpacing(3)
//                        }
//                    }
//
//                    // ── Input Fields ─────────────────────────────────────────
//                    VStack(spacing: 20) {
//
//                        // OPD Number
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("OPD Registration Number")
//                                .font(.subheadline)
//                                .fontWeight(.medium)
//                                .foregroundStyle(.primary)
//
//                            HStack(spacing: 12) {
//                                Image(systemName: "person.text.rectangle")
//                                    .font(.system(size: 17))
//                                    .foregroundStyle(.secondary)
//                                    .frame(width: 20)
//
//                                TextField("Enter your OPD number", text: $opdNumber)
//                                    .keyboardType(.numberPad)
//                                    .focused($focusedField, equals: .opd)
//                                    .font(.body)
//                            }
//                            .padding(.horizontal, 16)
//                            .padding(.vertical, 14)
//                            .background(Color(.systemBackground))
//                            .clipShape(RoundedRectangle(cornerRadius: 14))
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 14)
//                                    .stroke(
//                                        focusedField == .opd ? Color.blue : Color(.separator),
//                                        lineWidth: focusedField == .opd ? 1.5 : 1
//                                    )
//                            )
//                        }
//
//                        // Mobile Number
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("Mobile Number")
//                                .font(.subheadline)
//                                .fontWeight(.medium)
//                                .foregroundStyle(.primary)
//
//                            HStack(spacing: 12) {
//                                Image(systemName: "phone")
//                                    .font(.system(size: 17))
//                                    .foregroundStyle(.secondary)
//                                    .frame(width: 20)
//
//                                TextField("07X XXX XXXX", text: $mobileNumber)
//                                    .keyboardType(.phonePad)
//                                    .focused($focusedField, equals: .mobile)
//                                    .font(.body)
//                            }
//                            .padding(.horizontal, 16)
//                            .padding(.vertical, 14)
//                            .background(Color(.systemBackground))
//                            .clipShape(RoundedRectangle(cornerRadius: 14))
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 14)
//                                    .stroke(
//                                        focusedField == .mobile ? Color.blue : Color(.separator),
//                                        lineWidth: focusedField == .mobile ? 1.5 : 1
//                                    )
//                            )
//                        }
//                    }
//
//                    // ── Sign In + Register ────────────────────────────────────
//                    VStack(spacing: 16) {
//
//                        // Sign In button — plain Button with programmatic navigation
//                        Button {
//                            focusedField = nil
//                            navigateToOTP = true
//                        } label: {
//                            Text("Sign In")
//                                .font(.headline)
//                                .fontWeight(.semibold)
//                                .foregroundStyle(.white)
//                                .frame(maxWidth: .infinity)
//                                .frame(height: 54)
//                                .background(
//                                    Group {
//                                        if canProceed {
//                                            LinearGradient(
//                                                colors: [.blue, .cyan],
//                                                startPoint: .leading,
//                                                endPoint: .trailing
//                                            )
//                                        } else {
//                                            LinearGradient(
//                                                colors: [Color(.systemGray4), Color(.systemGray4)],
//                                                startPoint: .leading,
//                                                endPoint: .trailing
//                                            )
//                                        }
//                                    }
//                                )
//                                .clipShape(RoundedRectangle(cornerRadius: 16))
//                                .shadow(
//                                    color: canProceed ? .blue.opacity(0.35) : .clear,
//                                    radius: 12,
//                                    y: 5
//                                )
//                        }
//                        .disabled(!canProceed)
//                        .navigationDestination(isPresented: $navigateToOTP) {
//                            OTPView()
//                        }
//
//                        // Register link
//                        Button {
//                            navigateToRegister = true
//                        } label: {
//                            HStack(spacing: 4) {
//                                Text("Don't have an account?")
//                                    .foregroundStyle(.secondary)
//                                Text("Register here")
//                                    .foregroundStyle(.blue)
//                                    .fontWeight(.semibold)
//                            }
//                            .font(.subheadline)
//                        }
//                        .navigationDestination(isPresented: $navigateToRegister) {
//                            OPDRegistrationView()
//                        }
//
//                        Text("By continuing, you agree to our Terms of Service\nand Privacy Policy")
//                            .font(.caption)
//                            .foregroundStyle(.tertiary)
//                            .multilineTextAlignment(.center)
//                    }
//                }
//                .padding(.horizontal, 24)
//                .padding(.bottom, 40)
//            }
//            .background(Color(.systemGroupedBackground))
//            .navigationBarHidden(true)
//            .onTapGesture { focusedField = nil }
//        }
//    }
//}
//
//#Preview {
//    LoginView()
//}

import SwiftUI

struct LoginView: View {
    @State private var opdNumber: String = ""
    @State private var mobileNumber: String = ""
    @State private var navigateToOTP = false
    @State private var navigateToRegister = false
    @FocusState private var focusedField: Field?

    enum Field { case opd, mobile }

    private var canProceed: Bool {
        !opdNumber.isEmpty && mobileNumber.count >= 9
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {

                    // ── Brand Header ─────────────────────────────────────────
                    VStack(spacing: 20) {
                        // App icon
                        ZStack {
                            RoundedRectangle(cornerRadius: 22)
                                .fill(
                                    LinearGradient(
                                        colors: [Color(red: 0.18, green: 0.44, blue: 0.98),
                                                 Color(red: 0.10, green: 0.60, blue: 0.96)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 76, height: 76)
                                .shadow(color: .blue.opacity(0.25), radius: 20, y: 8)
                            Image(systemName: "cross.case.fill")
                                .font(.system(size: 32, weight: .medium))
                                .foregroundStyle(.white)
                        }

                        VStack(spacing: 8) {
                            Text("HealthClinic")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.primary)
                            Text("Sign in to continue")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.top, 64)
                    .padding(.bottom, 48)

                    // ── Input Fields ─────────────────────────────────────────
                    VStack(spacing: 14) {
                        inputField(
                            title: "OPD Registration Number",
                            placeholder: "Enter your OPD number",
                            icon: "person.text.rectangle",
                            text: $opdNumber,
                            field: .opd,
                            keyboard: .numberPad
                        )

                        inputField(
                            title: "Mobile Number",
                            placeholder: "07X XXX XXXX",
                            icon: "phone",
                            text: $mobileNumber,
                            field: .mobile,
                            keyboard: .phonePad
                        )
                    }
                    .padding(.bottom, 28)

                    // ── Sign In Button ────────────────────────────────────────
                    Button {
                        focusedField = nil
                        navigateToOTP = true
                    } label: {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(canProceed ? Color.blue : Color(.systemGray4))
                            )
                            .shadow(color: canProceed ? .blue.opacity(0.30) : .clear,
                                    radius: 12, y: 5)
                    }
                    .disabled(!canProceed)
                    .navigationDestination(isPresented: $navigateToOTP) { OTPView() }
                    .padding(.bottom, 20)

                    // ── Register Link ─────────────────────────────────────────
                    Button {
                        navigateToRegister = true
                    } label: {
                        HStack(spacing: 4) {
                            Text("Don't have an account?")
                                .foregroundStyle(.secondary)
                            Text("Register")
                                .foregroundStyle(.blue)
                                .fontWeight(.semibold)
                        }
                        .font(.subheadline)
                    }
                    .navigationDestination(isPresented: $navigateToRegister) {
                        OPDRegistrationView()
                    }
                    .padding(.bottom, 32)

                    // ── Terms ─────────────────────────────────────────────────
                    Text("By continuing you agree to our Terms of Service\nand Privacy Policy")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                        .multilineTextAlignment(.center)

                    Spacer(minLength: 40)
                }
                .padding(.horizontal, 24)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
            .onTapGesture { focusedField = nil }
        }
    }

    // MARK: - Input Field Builder

    @ViewBuilder
    private func inputField(
        title: String,
        placeholder: String,
        icon: String,
        text: Binding<String>,
        field: Field,
        keyboard: UIKeyboardType
    ) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundStyle(.secondary)

            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(.secondary)
                    .frame(width: 18)

                TextField(placeholder, text: text)
                    .keyboardType(keyboard)
                    .focused($focusedField, equals: field)
                    .font(.body)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 14)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        focusedField == field ? Color.blue : Color(.separator),
                        lineWidth: focusedField == field ? 1.5 : 0.8
                    )
            )
        }
    }
}

#Preview {
    LoginView()
}


