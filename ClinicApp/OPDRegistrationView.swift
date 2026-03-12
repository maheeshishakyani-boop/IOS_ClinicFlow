//
//  OPDRegistrationView.swift
//  ClinicApp
//
//  Created by COBSCCOM-45 on 2026-03-12.
//

import SwiftUI

// MARK: - OPDRegistrationView
// Pushed via NavigationLink from LoginView's "Register" link.
// System provides "< Back" automatically.

struct OPDRegistrationView: View {
    @State private var fullName: String = ""
    @State private var nicNumber: String = ""
    @State private var mobileNumber: String = ""
    @State private var navigateToOTP = false
    @FocusState private var focusedField: Field?

    enum Field { case fullName, nic, mobile }

    private var canContinue: Bool {
        !fullName.isEmpty && !nicNumber.isEmpty && mobileNumber.count >= 9
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                // ── Page subtitle ────────────────────────────────────────────
                Text("Enter basic details to register")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)

                // ── Form Card ────────────────────────────────────────────────
                VStack(alignment: .leading, spacing: 0) {

                    // Full Name
                    formField(
                        label: "Full Name",
                        placeholder: "Enter your full name",
                        text: $fullName,
                        field: .fullName,
                        keyboardType: .default
                    )

                    Divider().padding(.horizontal, 16)

                    // NIC Number
                    formField(
                        label: "NIC number",
                        placeholder: "Enter NIC number",
                        text: $nicNumber,
                        field: .nic,
                        keyboardType: .default
                    )

                    Divider().padding(.horizontal, 16)

                    // Mobile Number
                    formField(
                        label: "Mobile Number",
                        placeholder: "Enter mobile number",
                        text: $mobileNumber,
                        field: .mobile,
                        keyboardType: .phonePad
                    )

                    Divider().padding(.horizontal, 16)

                    // Continue Button inside the card
                    Button {
                        focusedField = nil
                        navigateToOTP = true
                    } label: {
                        Text("Continue")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(canContinue ? Color.blue : Color(.systemGray4))
                            )
                    }
                    .disabled(!canContinue)
                    .padding(16)
                    .navigationDestination(isPresented: $navigateToOTP) {
                        OTPView()
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.05), radius: 12, y: 4)
                )

                // ── Footer note ──────────────────────────────────────────────
                Text("You can provide additional details later at the hospital help desk")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 8)
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
            .padding(.bottom, 40)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("OPD Registration")
        .navigationBarTitleDisplayMode(.large)
        .toolbarBackground(Color(.systemGroupedBackground), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onTapGesture { focusedField = nil }
    }

    // MARK: - Form Field Helper

    @ViewBuilder
    private func formField(
        label: String,
        placeholder: String,
        text: Binding<String>,
        field: Field,
        keyboardType: UIKeyboardType
    ) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundStyle(.primary)

            TextField(placeholder, text: text)
                .keyboardType(keyboardType)
                .focused($focusedField, equals: field)
                .font(.body)
                .foregroundStyle(.primary)
                .padding(.vertical, 12)
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.secondarySystemBackground))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            focusedField == field ? Color.blue : Color.clear,
                            lineWidth: 1.5
                        )
                )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}

#Preview {
    NavigationStack {
        OPDRegistrationView()
    }
}
