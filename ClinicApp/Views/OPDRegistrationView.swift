//////
//////  OPDRegistrationView.swift
//////  ClinicApp
//////
//////  Created by BSCComp-046 on 2026-03-13.
//////
////
////import SwiftUI
////
////struct OPDRegistrationView: View {
////    @State private var fullName: String = ""
////    @State private var nicNumber: String = ""
////    @State private var mobileNumber: String = ""
////    @State private var navigateToSuccess = false
////    @State private var generatedOPDNumber = ""
////    @FocusState private var focusedField: Field?
////    @Environment(\.dismiss) private var dismiss
////
////    enum Field { case fullName, nic, mobile }
////
////    private var canContinue: Bool {
////        !fullName.isEmpty && !nicNumber.isEmpty && mobileNumber.count >= 9
////    }
////
////    var body: some View {
////        ScrollView {
////            VStack(alignment: .leading, spacing: 24) {
////                Text("Enter basic details to register")
////                    .font(.subheadline)
////                    .foregroundStyle(.secondary)
////                    .padding(.top, 4)
////
////                VStack(alignment: .leading, spacing: 0) {
////                    formField(label: "Full Name",     placeholder: "Enter your full name",  text: $fullName,     field: .fullName, keyboardType: .default)
////                    Divider().padding(.horizontal, 16)
////                    formField(label: "NIC number",    placeholder: "Enter NIC number",       text: $nicNumber,    field: .nic,      keyboardType: .default)
////                    Divider().padding(.horizontal, 16)
////                    formField(label: "Mobile Number", placeholder: "Enter mobile number",    text: $mobileNumber, field: .mobile,   keyboardType: .phonePad)
////                    Divider().padding(.horizontal, 16)
////
////                    // Continue Button with Gradient
////                    Button {
////                        focusedField = nil
////                        // Generate a random OPD number
////                        generatedOPDNumber = generateOPDNumber()
////                        navigateToSuccess = true
////                    } label: {
////                        Text("Continue")
////                            .font(.headline)
////                            .fontWeight(.semibold)
////                            .foregroundStyle(.white)
////                            .frame(maxWidth: .infinity)
////                            .frame(height: 50)
////                            .background(
////                                Group {
////                                    if canContinue {
////                                        LinearGradient(
////                                            colors: [.blue, .cyan],
////                                            startPoint: .leading,
////                                            endPoint: .trailing
////                                        )
////                                    } else {
////                                        Color(.systemGray4)
////                                    }
////                                }
////                            )
////                            .clipShape(RoundedRectangle(cornerRadius: 12))
////                            .shadow(color: canContinue ? .blue.opacity(0.3) : .clear,
////                                    radius: 8, y: 4)
////                    }
////                    .disabled(!canContinue)
////                    .padding(16)
////                    .navigationDestination(isPresented: $navigateToSuccess) {
////                        OPDRegistrationSuccessView(opdNumber: generatedOPDNumber)
////                    }
////                }
////                .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemBackground)).shadow(color: .black.opacity(0.05), radius: 12, y: 4))
////
////                Text("You can provide additional details later at the hospital help desk")
////                    .font(.caption).foregroundStyle(.secondary)
////                    .multilineTextAlignment(.center).frame(maxWidth: .infinity).padding(.horizontal, 8)
////            }
////            .padding(.horizontal, 20).padding(.top, 8).padding(.bottom, 40)
////        }
////        .background(Color(.systemGroupedBackground))
////        .navigationTitle("OPD Registration")
////        .navigationBarTitleDisplayMode(.large)
////        .onTapGesture { focusedField = nil }
////    }
////
////    @ViewBuilder
////    private func formField(label: String, placeholder: String, text: Binding<String>, field: Field, keyboardType: UIKeyboardType) -> some View {
////        VStack(alignment: .leading, spacing: 6) {
////            Text(label).font(.subheadline).fontWeight(.medium).foregroundStyle(.primary)
////            TextField(placeholder, text: text)
////                .keyboardType(keyboardType).focused($focusedField, equals: field)
////                .font(.body).foregroundStyle(.primary)
////                .padding(.vertical, 12).padding(.horizontal, 12)
////                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.secondarySystemBackground)))
////                .overlay(RoundedRectangle(cornerRadius: 10).stroke(focusedField == field ? Color.blue : Color.clear, lineWidth: 1.5))
////        }
////        .padding(.horizontal, 16).padding(.vertical, 14)
////    }
////    
////    // Helper function to generate a random OPD number
////    private func generateOPDNumber() -> String {
////        let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
////        let randomLetters = (0..<2).map { _ in letters.randomElement()! }.joined()
////        let randomNumbers = (0..<4).map { _ in String(Int.random(in: 0...9)) }.joined()
////        return "OPD-\(randomLetters)\(randomNumbers)"
////    }
////}
////
////#Preview {
////    NavigationStack {
////        OPDRegistrationView()
////    }
////}
//
//
import SwiftUI
//
//struct OPDRegistrationView: View {
//    @State private var fullName: String = ""
//    @State private var nicNumber: String = ""
//    @State private var mobileNumber: String = ""
//    @State private var generatedOPDNumber = ""
//    @FocusState private var focusedField: Field?
//    @EnvironmentObject private var navigationState: NavigationState
//    @Environment(\.dismiss) private var dismiss
//
//    enum Field { case fullName, nic, mobile }
//
//    private var canContinue: Bool {
//        !fullName.isEmpty && !nicNumber.isEmpty && mobileNumber.count >= 9
//    }
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 24) {
//                Text("Enter basic details to register")
//                    .font(.subheadline)
//                    .foregroundStyle(.secondary)
//                    .padding(.top, 4)
//
//                VStack(alignment: .leading, spacing: 0) {
//                    formField(label: "Full Name",     placeholder: "Enter your full name",  text: $fullName,     field: .fullName, keyboardType: .default)
//                    Divider().padding(.horizontal, 16)
//                    formField(label: "NIC number",    placeholder: "Enter NIC number",       text: $nicNumber,    field: .nic,      keyboardType: .default)
//                    Divider().padding(.horizontal, 16)
//                    formField(label: "Mobile Number", placeholder: "Enter mobile number",    text: $mobileNumber, field: .mobile,   keyboardType: .phonePad)
//                    Divider().padding(.horizontal, 16)
//
//                    // Continue Button with Gradient
//                    Button {
//                        focusedField = nil
//                        // Generate a random OPD number
//                        generatedOPDNumber = generateOPDNumber()
//                        // Navigate to success view
//                        navigationState.path.append("success")
//                    } label: {
//                        Text("Continue")
//                            .font(.headline)
//                            .fontWeight(.semibold)
//                            .foregroundStyle(.white)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 50)
//                            .background(
//                                Group {
//                                    if canContinue {
//                                        LinearGradient(
//                                            colors: [.blue, .cyan],
//                                            startPoint: .leading,
//                                            endPoint: .trailing
//                                        )
//                                    } else {
//                                        Color(.systemGray4)
//                                    }
//                                }
//                            )
//                            .clipShape(RoundedRectangle(cornerRadius: 12))
//                            .shadow(color: canContinue ? .blue.opacity(0.3) : .clear,
//                                    radius: 8, y: 4)
//                    }
//                    .disabled(!canContinue)
//                    .padding(16)
//                }
//                .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemBackground)).shadow(color: .black.opacity(0.05), radius: 12, y: 4))
//
//                Text("You can provide additional details later at the hospital help desk")
//                    .font(.caption).foregroundStyle(.secondary)
//                    .multilineTextAlignment(.center).frame(maxWidth: .infinity).padding(.horizontal, 8)
//            }
//            .padding(.horizontal, 20).padding(.top, 8).padding(.bottom, 40)
//        }
//        .background(Color(.systemGroupedBackground))
//        .navigationTitle("OPD Registration")
//        .navigationBarTitleDisplayMode(.large)
//        .navigationDestination(for: String.self) { destination in
//            if destination == "success" {
//                OPDRegistrationSuccessView(opdNumber: generatedOPDNumber)
//            }
//        }
//        .onTapGesture { focusedField = nil }
//    }
//
//    @ViewBuilder
//    private func formField(label: String, placeholder: String, text: Binding<String>, field: Field, keyboardType: UIKeyboardType) -> some View {
//        VStack(alignment: .leading, spacing: 6) {
//            Text(label).font(.subheadline).fontWeight(.medium).foregroundStyle(.primary)
//            TextField(placeholder, text: text)
//                .keyboardType(keyboardType).focused($focusedField, equals: field)
//                .font(.body).foregroundStyle(.primary)
//                .padding(.vertical, 12).padding(.horizontal, 12)
//                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.secondarySystemBackground)))
//                .overlay(RoundedRectangle(cornerRadius: 10).stroke(focusedField == field ? Color.blue : Color.clear, lineWidth: 1.5))
//        }
//        .padding(.horizontal, 16).padding(.vertical, 14)
//    }
//    
//    // Helper function to generate a random OPD number
//    private func generateOPDNumber() -> String {
//        let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
//        let randomLetters = (0..<2).map { _ in letters.randomElement()! }.joined()
//        let randomNumbers = (0..<4).map { _ in String(Int.random(in: 0...9)) }.joined()
//        return "OPD-\(randomLetters)\(randomNumbers)"
//    }
//}
//
//#Preview {
//    NavigationStack {
//        OPDRegistrationView()
//            .environmentObject(NavigationState())
//    }
//}
//
//
//

struct OPDRegistrationView: View {
    @State private var fullName: String = ""
    @State private var nicNumber: String = ""
    @State private var mobileNumber: String = ""
    @State private var generatedOPDNumber = ""
    @State private var navigateToSuccess = false  // Add this state variable
    @FocusState private var focusedField: Field?
    @EnvironmentObject private var navigationState: NavigationState
    @Environment(\.dismiss) private var dismiss

    enum Field { case fullName, nic, mobile }

    private var canContinue: Bool {
        !fullName.isEmpty && !nicNumber.isEmpty && mobileNumber.count >= 9
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Enter basic details to register")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)

                VStack(alignment: .leading, spacing: 0) {
                    formField(label: "Full Name",     placeholder: "Enter your full name",  text: $fullName,     field: .fullName, keyboardType: .default)
                    Divider().padding(.horizontal, 16)
                    formField(label: "NIC number",    placeholder: "Enter NIC number",       text: $nicNumber,    field: .nic,      keyboardType: .default)
                    Divider().padding(.horizontal, 16)
                    formField(label: "Mobile Number", placeholder: "Enter mobile number",    text: $mobileNumber, field: .mobile,   keyboardType: .phonePad)
                    Divider().padding(.horizontal, 16)

                    // Continue Button with Gradient
                    Button {
                        focusedField = nil
                        // Generate a random OPD number
                        generatedOPDNumber = generateOPDNumber()
                        // Navigate to success view using state variable
                        navigateToSuccess = true
                    } label: {
                        Text("Continue")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                Group {
                                    if canContinue {
                                        LinearGradient(
                                            colors: [.blue, .cyan],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    } else {
                                        Color(.systemGray4)
                                    }
                                }
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: canContinue ? .blue.opacity(0.3) : .clear,
                                    radius: 8, y: 4)
                    }
                    .disabled(!canContinue)
                    .padding(16)
                }
                .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemBackground)).shadow(color: .black.opacity(0.05), radius: 12, y: 4))

                Text("You can provide additional details later at the hospital help desk")
                    .font(.caption).foregroundStyle(.secondary)
                    .multilineTextAlignment(.center).frame(maxWidth: .infinity).padding(.horizontal, 8)
            }
            .padding(.horizontal, 20).padding(.top, 8).padding(.bottom, 40)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("OPD Registration")
        .navigationBarTitleDisplayMode(.large)
        // Use navigationDestination with isPresented binding instead
//        .navigationDestination(isPresented: $navigateToSuccess) {
//            OPDRegistrationSuccessView(opdNumber: generatedOPDNumber)
//        }
        .navigationDestination(isPresented: $navigateToSuccess) {
            OPDRegistrationSuccessView(opdNumber: generatedOPDNumber) {
                // Closure: navigate to LandingUIScreen
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController = UIHostingController(rootView: LandingUIScreen())
                    window.makeKeyAndVisible()
                }
            }
        }
        .onTapGesture { focusedField = nil }
    }

    @ViewBuilder
    private func formField(label: String, placeholder: String, text: Binding<String>, field: Field, keyboardType: UIKeyboardType) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label).font(.subheadline).fontWeight(.medium).foregroundStyle(.primary)
            TextField(placeholder, text: text)
                .keyboardType(keyboardType).focused($focusedField, equals: field)
                .font(.body).foregroundStyle(.primary)
                .padding(.vertical, 12).padding(.horizontal, 12)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.secondarySystemBackground)))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(focusedField == field ? Color.blue : Color.clear, lineWidth: 1.5))
        }
        .padding(.horizontal, 16).padding(.vertical, 14)
    }
    
    // Helper function to generate a random OPD number
    private func generateOPDNumber() -> String {
        let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        let randomLetters = (0..<2).map { _ in letters.randomElement()! }.joined()
        let randomNumbers = (0..<4).map { _ in String(Int.random(in: 0...9)) }.joined()
        return "OPD-\(randomLetters)\(randomNumbers)"
    }
}
