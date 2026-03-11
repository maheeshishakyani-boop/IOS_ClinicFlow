
import SwiftUI

struct LoginView: View {
    @State private var opdNumber: String = ""
    @State private var mobileNumber: String = ""
    @FocusState private var focusedField: Field?
    
    enum Field {
        case opd, mobile
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    // Header with icon and branding
                    VStack(spacing: 20) {
                        // App icon with gradient
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
                            
                            Image(systemName: "cross.case.fill")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundStyle(.white)
                        }
                        .padding(.top, 20)
                        
                        VStack(spacing: 8) {
                            Text("Welcome to HealthClinic")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            
                            Text("Sign in to manage your appointments and queue")
                                .font(.body)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                    }
                    
                    // Input fields
                    VStack(spacing: 20) {
                        // OPD Number field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("OPD Registration Number")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .fontWeight(.medium)
                            
                            HStack {
                                Image(systemName: "person.text.rectangle")
                                    .foregroundStyle(.tertiary)
                                    .font(.system(size: 18))
                                
                                TextField("Enter your OPD number", text: $opdNumber)
                                    .textContentType(.username)
                                    .keyboardType(.numberPad)
                                    .focused($focusedField, equals: .opd)
                                    .font(.body)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color(.systemBackground))
                                    .shadow(color: .black.opacity(0.03), radius: 8, y: 2)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(focusedField == .opd ? Color.blue : Color.gray.opacity(0.15), lineWidth: 1.5)
                            )
                        }
                        
                        // Mobile Number field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Mobile Number")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .fontWeight(.medium)
                            
                            HStack {
                                Image(systemName: "phone")
                                    .foregroundStyle(.tertiary)
                                    .font(.system(size: 18))
                                
                                TextField("07X XXX XXXX", text: $mobileNumber)
                                    .textContentType(.telephoneNumber)
                                    .keyboardType(.phonePad)
                                    .focused($focusedField, equals: .mobile)
                                    .font(.body)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color(.systemBackground))
                                    .shadow(color: .black.opacity(0.03), radius: 8, y: 2)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(focusedField == .mobile ? Color.blue : Color.gray.opacity(0.15), lineWidth: 1.5)
                            )
                        }
                    }
                    
                    // Sign In Button
                    VStack(spacing: 16) {
                        NavigationLink(destination: OTPView()) {
                            Text("Continue")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54)
                                .background(
                                    LinearGradient(
                                        colors: opdNumber.isEmpty || mobileNumber.count < 9 ? [.gray.opacity(0.5)] : [.blue, .cyan],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .shadow(color: .blue.opacity(0.3), radius: opdNumber.isEmpty || mobileNumber.count < 9 ? 0 : 10, y: 5)
                        }
                        .disabled(opdNumber.isEmpty || mobileNumber.count < 9)
                        
                        Text("By continuing, you agree to our Terms and Privacy Policy")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 32)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
            .onTapGesture {
                focusedField = nil
            }
        }
    }
}

#Preview {
    LoginView()
}
