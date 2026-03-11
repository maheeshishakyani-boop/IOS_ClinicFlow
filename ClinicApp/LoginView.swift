//
//import SwiftUI
//
//struct LoginView: View {
//    @State private var opdNumber: String = ""
//    @State private var mobileNumber: String = ""
//    @FocusState private var focusedField: Field?
//    
//    enum Field {
//        case opd, mobile
//    }
//    
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(spacing: 32) {
//                    // Header with icon and branding
//                    VStack(spacing: 20) {
//                        // App icon with gradient
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
//                            
//                            Image(systemName: "cross.case.fill")
//                                .font(.system(size: 40, weight: .medium))
//                                .foregroundStyle(.white)
//                        }
//                        .padding(.top, 20)
//                        
//                        VStack(spacing: 8) {
//                            Text("Welcome to HealthClinic")
//                                .font(.largeTitle)
//                                .fontWeight(.bold)
//                                .multilineTextAlignment(.center)
//                            
//                            Text("Sign in to manage your appointments and queue")
//                                .font(.body)
//                                .foregroundStyle(.secondary)
//                                .multilineTextAlignment(.center)
//                        }
//                    }
//                    
//                    // Input fields
//                    VStack(spacing: 20) {
//                        // OPD Number field
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("OPD Registration Number")
//                                .font(.subheadline)
//                                .foregroundStyle(.secondary)
//                                .fontWeight(.medium)
//                            
//                            HStack {
//                                Image(systemName: "person.text.rectangle")
//                                    .foregroundStyle(.tertiary)
//                                    .font(.system(size: 18))
//                                
//                                TextField("Enter your OPD number", text: $opdNumber)
//                                    .textContentType(.username)
//                                    .keyboardType(.numberPad)
//                                    .focused($focusedField, equals: .opd)
//                                    .font(.body)
//                            }
//                            .padding(.horizontal, 16)
//                            .padding(.vertical, 14)
//                            .background(
//                                RoundedRectangle(cornerRadius: 14)
//                                    .fill(Color(.systemBackground))
//                                    .shadow(color: .black.opacity(0.03), radius: 8, y: 2)
//                            )
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 14)
//                                    .stroke(focusedField == .opd ? Color.blue : Color.gray.opacity(0.15), lineWidth: 1.5)
//                            )
//                        }
//                        
//                        // Mobile Number field
//                        VStack(alignment: .leading, spacing: 8) {
//                            Text("Mobile Number")
//                                .font(.subheadline)
//                                .foregroundStyle(.secondary)
//                                .fontWeight(.medium)
//                            
//                            HStack {
//                                Image(systemName: "phone")
//                                    .foregroundStyle(.tertiary)
//                                    .font(.system(size: 18))
//                                
//                                TextField("07X XXX XXXX", text: $mobileNumber)
//                                    .textContentType(.telephoneNumber)
//                                    .keyboardType(.phonePad)
//                                    .focused($focusedField, equals: .mobile)
//                                    .font(.body)
//                            }
//                            .padding(.horizontal, 16)
//                            .padding(.vertical, 14)
//                            .background(
//                                RoundedRectangle(cornerRadius: 14)
//                                    .fill(Color(.systemBackground))
//                                    .shadow(color: .black.opacity(0.03), radius: 8, y: 2)
//                            )
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 14)
//                                    .stroke(focusedField == .mobile ? Color.blue : Color.gray.opacity(0.15), lineWidth: 1.5)
//                            )
//                        }
//                    }
//                    
//                    // Sign In Button
//                    VStack(spacing: 16) {
//                        NavigationLink(destination: OTPView()) {
//                            Text("Continue")
//                                .font(.headline)
//                                .fontWeight(.semibold)
//                                .frame(maxWidth: .infinity)
//                                .frame(height: 54)
//                                .background(
//                                    LinearGradient(
//                                        colors: opdNumber.isEmpty || mobileNumber.count < 9 ? [.gray.opacity(0.5)] : [.blue, .cyan],
//                                        startPoint: .leading,
//                                        endPoint: .trailing
//                                    )
//                                )
//                                .foregroundStyle(.white)
//                                .clipShape(RoundedRectangle(cornerRadius: 16))
//                                .shadow(color: .blue.opacity(0.3), radius: opdNumber.isEmpty || mobileNumber.count < 9 ? 0 : 10, y: 5)
//                        }
//                        .disabled(opdNumber.isEmpty || mobileNumber.count < 9)
//                        
//                        Text("By continuing, you agree to our Terms and Privacy Policy")
//                            .font(.caption)
//                            .foregroundStyle(.tertiary)
//                            .multilineTextAlignment(.center)
//                            .padding(.horizontal, 32)
//                    }
//                }
//                .padding(.horizontal, 24)
//                .padding(.vertical, 32)
//            }
//            .background(Color(.systemGroupedBackground))
//            .navigationBarHidden(true)
//            .onTapGesture {
//                focusedField = nil
//            }
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
    @FocusState private var focusedField: Field?

    enum Field { case opd, mobile }

    private var canProceed: Bool {
        !opdNumber.isEmpty && mobileNumber.count >= 9
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 40) {

                    // ── Brand Header ─────────────────────────────────────────
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.blue, .cyan],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 80, height: 80)
                                .shadow(color: .blue.opacity(0.3), radius: 16, y: 6)

                            Image(systemName: "cross.case.fill")
                                .font(.system(size: 36, weight: .medium))
                                .foregroundStyle(.white)
                        }
                        .padding(.top, 32)

                        VStack(spacing: 8) {
                            Text("HealthClinic")
                                .font(.largeTitle)
                                .fontWeight(.bold)

                            Text("Sign in to manage your appointments\nand queue status")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                                .lineSpacing(3)
                        }
                    }

                    // ── Input Fields ─────────────────────────────────────────
                    VStack(spacing: 20) {

                        // OPD Number
                        VStack(alignment: .leading, spacing: 8) {
                            Text("OPD Registration Number")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(.primary)

                            HStack(spacing: 12) {
                                Image(systemName: "person.text.rectangle")
                                    .font(.system(size: 17))
                                    .foregroundStyle(.secondary)
                                    .frame(width: 20)

                                TextField("Enter your OPD number", text: $opdNumber)
                                    .keyboardType(.numberPad)
                                    .focused($focusedField, equals: .opd)
                                    .font(.body)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(
                                        focusedField == .opd ? Color.blue : Color(.separator),
                                        lineWidth: focusedField == .opd ? 1.5 : 1
                                    )
                            )
                        }

                        // Mobile Number
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Mobile Number")
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundStyle(.primary)

                            HStack(spacing: 12) {
                                Image(systemName: "phone")
                                    .font(.system(size: 17))
                                    .foregroundStyle(.secondary)
                                    .frame(width: 20)

                                TextField("07X XXX XXXX", text: $mobileNumber)
                                    .keyboardType(.phonePad)
                                    .focused($focusedField, equals: .mobile)
                                    .font(.body)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(
                                        focusedField == .mobile ? Color.blue : Color(.separator),
                                        lineWidth: focusedField == .mobile ? 1.5 : 1
                                    )
                            )
                        }
                    }

                    // ── Sign In Button + Footer ───────────────────────────────
                    VStack(spacing: 16) {

                        // Plain Button → programmatic navigation (no style bleed)
                        Button {
                            focusedField = nil
                            navigateToOTP = true
                        } label: {
                            Text("Sign In")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54)
                                .background(
                                    Group {
                                        if canProceed {
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
                                    color: canProceed ? .blue.opacity(0.35) : .clear,
                                    radius: 12,
                                    y: 5
                                )
                        }
                        .disabled(!canProceed)
                        // NavigationDestination driven by state — no link wrapping a button
                        .navigationDestination(isPresented: $navigateToOTP) {
                            OTPView()
                        }

                        Text("By continuing, you agree to our Terms of Service\nand Privacy Policy")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
            .onTapGesture { focusedField = nil }
        }
    }
}

#Preview {
    LoginView()
}
