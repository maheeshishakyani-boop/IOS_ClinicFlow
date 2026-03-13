//////////////
//////////////  LoginView.swift
//////////////  ClinicApp
//////////////
//////////////  Created by BSCComp-046 on 2026-03-13.
//////////////
////////////
//////////////
//////////////  LoginView.swift
//////////////  ClinicApp
//////////////
//////////////  Created by YourName on 2026-03-13.
//////////////
////////////
////////////import SwiftUI
////////////
////////////struct LoginView: View {
////////////    @State private var opdNumber: String = ""
////////////    @State private var mobileNumber: String = ""
////////////    @State private var navigateToOTP = false
////////////    @State private var navigateToRegister = false
////////////    @FocusState private var focusedField: Field?
////////////
////////////    enum Field { case opd, mobile }
////////////
////////////    private var canProceed: Bool {
////////////        !opdNumber.isEmpty && mobileNumber.count >= 9
////////////    }
////////////
////////////    var body: some View {
////////////        NavigationStack {
////////////            ScrollView {
////////////                VStack(spacing: 0) {
////////////                    // Brand Header
////////////                    VStack(spacing: 20) {
////////////                        ZStack {
////////////                            RoundedRectangle(cornerRadius: 22)
////////////                                .fill(
////////////                                    LinearGradient(
////////////                                        colors: [Color(red: 0.18, green: 0.44, blue: 0.98),
////////////                                                 Color(red: 0.10, green: 0.60, blue: 0.96)],
////////////                                        startPoint: .topLeading,
////////////                                        endPoint: .bottomTrailing
////////////                                    )
////////////                                )
////////////                                .frame(width: 76, height: 76)
////////////                                .shadow(color: .blue.opacity(0.25), radius: 20, y: 8)
////////////                            Image(systemName: "cross.case.fill")
////////////                                .font(.system(size: 32, weight: .medium))
////////////                                .foregroundStyle(.white)
////////////                        }
////////////
////////////                        VStack(spacing: 8) {
////////////                            Text("HealthClinic")
////////////                                .font(.title)
////////////                                .fontWeight(.bold)
////////////                                .foregroundStyle(.primary)
////////////                            Text("Sign in to continue")
////////////                                .font(.subheadline)
////////////                                .foregroundStyle(.secondary)
////////////                        }
////////////                    }
////////////                    .padding(.top, 64)
////////////                    .padding(.bottom, 48)
////////////
////////////                    // Input Fields
////////////                    VStack(spacing: 14) {
////////////                        inputField(
////////////                            title: "OPD Registration Number",
////////////                            placeholder: "Enter your OPD number",
////////////                            icon: "person.text.rectangle",
////////////                            text: $opdNumber,
////////////                            field: .opd,
////////////                            keyboard: .numberPad
////////////                        )
////////////
////////////                        inputField(
////////////                            title: "Mobile Number",
////////////                            placeholder: "07X XXX XXXX",
////////////                            icon: "phone",
////////////                            text: $mobileNumber,
////////////                            field: .mobile,
////////////                            keyboard: .phonePad
////////////                        )
////////////                    }
////////////                    .padding(.bottom, 28)
////////////
////////////                    // Sign In Button
////////////                    Button {
////////////                        focusedField = nil
////////////                        navigateToOTP = true
////////////                    } label: {
////////////                        Text("Sign In")
////////////                            .font(.headline)
////////////                            .foregroundStyle(.white)
////////////                            .frame(maxWidth: .infinity)
////////////                            .frame(height: 52)
////////////                            .background(
////////////                                RoundedRectangle(cornerRadius: 14)
////////////                                    .fill(canProceed ? Color.blue : Color(.systemGray4))
////////////                            )
////////////                            .shadow(color: canProceed ? .blue.opacity(0.30) : .clear,
////////////                                    radius: 12, y: 5)
////////////                    }
////////////                    .disabled(!canProceed)
////////////                    .navigationDestination(isPresented: $navigateToOTP) { OTPView() }
////////////                    .padding(.bottom, 20)
////////////
////////////                    // Register Link
////////////                    Button {
////////////                        navigateToRegister = true
////////////                    } label: {
////////////                        HStack(spacing: 4) {
////////////                            Text("Don't have an account?")
////////////                                .foregroundStyle(.secondary)
////////////                            Text("Register")
////////////                                .foregroundStyle(.blue)
////////////                                .fontWeight(.semibold)
////////////                        }
////////////                        .font(.subheadline)
////////////                    }
////////////                    .navigationDestination(isPresented: $navigateToRegister) {
////////////                        OPDRegistrationView()
////////////                    }
////////////                    .padding(.bottom, 32)
////////////
////////////                    // Terms
////////////                    Text("By continuing you agree to our Terms of Service\nand Privacy Policy")
////////////                        .font(.caption)
////////////                        .foregroundStyle(.tertiary)
////////////                        .multilineTextAlignment(.center)
////////////
////////////                    Spacer(minLength: 40)
////////////                }
////////////                .padding(.horizontal, 24)
////////////            }
////////////            .background(Color(.systemGroupedBackground))
////////////            .navigationBarHidden(true)
////////////            .onTapGesture { focusedField = nil }
////////////        }
////////////    }
////////////
////////////    @ViewBuilder
////////////    private func inputField(
////////////        title: String,
////////////        placeholder: String,
////////////        icon: String,
////////////        text: Binding<String>,
////////////        field: Field,
////////////        keyboard: UIKeyboardType
////////////    ) -> some View {
////////////        VStack(alignment: .leading, spacing: 8) {
////////////            Text(title)
////////////                .font(.footnote)
////////////                .fontWeight(.medium)
////////////                .foregroundStyle(.secondary)
////////////
////////////            HStack(spacing: 12) {
////////////                Image(systemName: icon)
////////////                    .font(.system(size: 15, weight: .regular))
////////////                    .foregroundStyle(.secondary)
////////////                    .frame(width: 18)
////////////
////////////                TextField(placeholder, text: text)
////////////                    .keyboardType(keyboard)
////////////                    .focused($focusedField, equals: field)
////////////                    .font(.body)
////////////            }
////////////            .padding(.horizontal, 14)
////////////            .padding(.vertical, 14)
////////////            .background(Color(.systemBackground))
////////////            .clipShape(RoundedRectangle(cornerRadius: 12))
////////////            .overlay(
////////////                RoundedRectangle(cornerRadius: 12)
////////////                    .stroke(
////////////                        focusedField == field ? Color.blue : Color(.separator),
////////////                        lineWidth: focusedField == field ? 1.5 : 0.8
////////////                    )
////////////            )
////////////        }
////////////    }
////////////}
////////////
////////////// MARK: - OPDRegistrationView
////////////struct OPDRegistrationView: View {
////////////    @State private var fullName: String = ""
////////////    @State private var nicNumber: String = ""
////////////    @State private var mobileNumber: String = ""
////////////    @State private var navigateToOTP = false
////////////    @FocusState private var focusedField: Field?
////////////
////////////    enum Field { case fullName, nic, mobile }
////////////
////////////    private var canContinue: Bool {
////////////        !fullName.isEmpty && !nicNumber.isEmpty && mobileNumber.count >= 9
////////////    }
////////////
////////////    var body: some View {
////////////        ScrollView {
////////////            VStack(alignment: .leading, spacing: 24) {
////////////                Text("Enter basic details to register")
////////////                    .font(.subheadline)
////////////                    .foregroundStyle(.secondary)
////////////                    .padding(.top, 4)
////////////
////////////                // Form Card
////////////                VStack(alignment: .leading, spacing: 0) {
////////////                    // Full Name
////////////                    formField(
////////////                        label: "Full Name",
////////////                        placeholder: "Enter your full name",
////////////                        text: $fullName,
////////////                        field: .fullName,
////////////                        keyboardType: .default
////////////                    )
////////////
////////////                    Divider().padding(.horizontal, 16)
////////////
////////////                    // NIC Number
////////////                    formField(
////////////                        label: "NIC number",
////////////                        placeholder: "Enter NIC number",
////////////                        text: $nicNumber,
////////////                        field: .nic,
////////////                        keyboardType: .default
////////////                    )
////////////
////////////                    Divider().padding(.horizontal, 16)
////////////
////////////                    // Mobile Number
////////////                    formField(
////////////                        label: "Mobile Number",
////////////                        placeholder: "Enter mobile number",
////////////                        text: $mobileNumber,
////////////                        field: .mobile,
////////////                        keyboardType: .phonePad
////////////                    )
////////////
////////////                    Divider().padding(.horizontal, 16)
////////////
////////////                    // Continue Button
////////////                    Button {
////////////                        focusedField = nil
////////////                        navigateToOTP = true
////////////                    } label: {
////////////                        Text("Continue")
////////////                            .font(.headline)
////////////                            .fontWeight(.semibold)
////////////                            .foregroundStyle(.white)
////////////                            .frame(maxWidth: .infinity)
////////////                            .frame(height: 50)
////////////                            .background(
////////////                                RoundedRectangle(cornerRadius: 12)
////////////                                    .fill(canContinue ? Color.blue : Color(.systemGray4))
////////////                            )
////////////                    }
////////////                    .disabled(!canContinue)
////////////                    .padding(16)
////////////                    .navigationDestination(isPresented: $navigateToOTP) {
////////////                        OTPView()
////////////                    }
////////////                }
////////////                .background(
////////////                    RoundedRectangle(cornerRadius: 16)
////////////                        .fill(Color(.systemBackground))
////////////                        .shadow(color: .black.opacity(0.05), radius: 12, y: 4)
////////////                )
////////////
////////////                Text("You can provide additional details later at the hospital help desk")
////////////                    .font(.caption)
////////////                    .foregroundStyle(.secondary)
////////////                    .multilineTextAlignment(.center)
////////////                    .frame(maxWidth: .infinity)
////////////                    .padding(.horizontal, 8)
////////////            }
////////////            .padding(.horizontal, 20)
////////////            .padding(.top, 8)
////////////            .padding(.bottom, 40)
////////////        }
////////////        .background(Color(.systemGroupedBackground))
////////////        .navigationTitle("OPD Registration")
////////////        .navigationBarTitleDisplayMode(.large)
////////////        .toolbarBackground(Color(.systemGroupedBackground), for: .navigationBar)
////////////        .toolbarBackground(.visible, for: .navigationBar)
////////////        .onTapGesture { focusedField = nil }
////////////    }
////////////
////////////    @ViewBuilder
////////////    private func formField(
////////////        label: String,
////////////        placeholder: String,
////////////        text: Binding<String>,
////////////        field: Field,
////////////        keyboardType: UIKeyboardType
////////////    ) -> some View {
////////////        VStack(alignment: .leading, spacing: 6) {
////////////            Text(label)
////////////                .font(.subheadline)
////////////                .fontWeight(.medium)
////////////                .foregroundStyle(.primary)
////////////
////////////            TextField(placeholder, text: text)
////////////                .keyboardType(keyboardType)
////////////                .focused($focusedField, equals: field)
////////////                .font(.body)
////////////                .foregroundStyle(.primary)
////////////                .padding(.vertical, 12)
////////////                .padding(.horizontal, 12)
////////////                .background(
////////////                    RoundedRectangle(cornerRadius: 10)
////////////                        .fill(Color(.secondarySystemBackground))
////////////                )
////////////                .overlay(
////////////                    RoundedRectangle(cornerRadius: 10)
////////////                        .stroke(
////////////                            focusedField == field ? Color.blue : Color.clear,
////////////                            lineWidth: 1.5
////////////                        )
////////////                )
////////////        }
////////////        .padding(.horizontal, 16)
////////////        .padding(.vertical, 14)
////////////    }
////////////}
////////////
////////////#Preview {
////////////    LoginView()
////////////}
//////////
//////////
////////import SwiftUI
////////
////////struct LoginView: View {
////////    @State private var opdNumber: String = ""
////////    @State private var mobileNumber: String = ""
////////    @State private var navigateToOTP = false
////////    @State private var navigateToRegister = false
////////    @FocusState private var focusedField: Field?
////////
////////    enum Field { case opd, mobile }
////////
////////    private var canProceed: Bool {
////////        !opdNumber.isEmpty && mobileNumber.count >= 9
////////    }
////////
////////    var body: some View {
////////        NavigationStack {
////////            ScrollView {
////////                VStack(spacing: 0) {
////////                    // Brand Header
////////                    VStack(spacing: 20) {
////////                        // Logo image from Assets
////////                        Image("logo")
////////                            .resizable()
////////                            .scaledToFit()
////////                            .frame(width: 76, height: 76)
////////                            .clipShape(RoundedRectangle(cornerRadius: 22))
////////                            .shadow(color: .blue.opacity(0.25), radius: 20, y: 8)
////////
////////                        VStack(spacing: 8) {
////////                            Text("HealthClinic")
////////                                .font(.title)
////////                                .fontWeight(.bold)
////////                                .foregroundStyle(.primary)
////////                            Text("Sign in to continue")
////////                                .font(.subheadline)
////////                                .foregroundStyle(.secondary)
////////                        }
////////                    }
////////                    .padding(.top, 64)
////////                    .padding(.bottom, 48)
////////
////////                    // Input Fields
////////                    VStack(spacing: 14) {
////////                        inputField(
////////                            title: "OPD Registration Number",
////////                            placeholder: "Enter your OPD number",
////////                            icon: "person.text.rectangle",
////////                            text: $opdNumber,
////////                            field: .opd,
////////                            keyboard: .numberPad
////////                        )
////////
////////                        inputField(
////////                            title: "Mobile Number",
////////                            placeholder: "07X XXX XXXX",
////////                            icon: "phone",
////////                            text: $mobileNumber,
////////                            field: .mobile,
////////                            keyboard: .phonePad
////////                        )
////////                    }
////////                    .padding(.bottom, 28)
////////
////////                    // Sign In Button
////////                    Button {
////////                        focusedField = nil
////////                        navigateToOTP = true
////////                    } label: {
////////                        Text("Sign In")
////////                            .font(.headline)
////////                            .foregroundStyle(.white)
////////                            .frame(maxWidth: .infinity)
////////                            .frame(height: 52)
////////                            .background(
////////                                RoundedRectangle(cornerRadius: 14)
////////                                    .fill(canProceed ? Color.blue : Color(.systemGray4))
////////                            )
////////                            .shadow(color: canProceed ? .blue.opacity(0.30) : .clear,
////////                                    radius: 12, y: 5)
////////                    }
////////                    .disabled(!canProceed)
////////                    .navigationDestination(isPresented: $navigateToOTP) { OTPView() }
////////                    .padding(.bottom, 20)
////////
////////                    // Register Link
////////                    Button {
////////                        navigateToRegister = true
////////                    } label: {
////////                        HStack(spacing: 4) {
////////                            Text("Don't have an account?")
////////                                .foregroundStyle(.secondary)
////////                            Text("Register")
////////                                .foregroundStyle(.blue)
////////                                .fontWeight(.semibold)
////////                        }
////////                        .font(.subheadline)
////////                    }
////////                    .navigationDestination(isPresented: $navigateToRegister) {
////////                        OPDRegistrationView()
////////                    }
////////                    .padding(.bottom, 32)
////////
////////                    // Terms
////////                    Text("By continuing you agree to our Terms of Service\nand Privacy Policy")
////////                        .font(.caption)
////////                        .foregroundStyle(.tertiary)
////////                        .multilineTextAlignment(.center)
////////
////////                    Spacer(minLength: 40)
////////                }
////////                .padding(.horizontal, 24)
////////            }
////////            .background(Color(.systemGroupedBackground))
////////            .navigationBarHidden(true)
////////            .onTapGesture { focusedField = nil }
////////        }
////////    }
////////
////////    @ViewBuilder
////////    private func inputField(
////////        title: String,
////////        placeholder: String,
////////        icon: String,
////////        text: Binding<String>,
////////        field: Field,
////////        keyboard: UIKeyboardType
////////    ) -> some View {
////////        VStack(alignment: .leading, spacing: 8) {
////////            Text(title)
////////                .font(.footnote)
////////                .fontWeight(.medium)
////////                .foregroundStyle(.secondary)
////////
////////            HStack(spacing: 12) {
////////                Image(systemName: icon)
////////                    .font(.system(size: 15, weight: .regular))
////////                    .foregroundStyle(.secondary)
////////                    .frame(width: 18)
////////
////////                TextField(placeholder, text: text)
////////                    .keyboardType(keyboard)
////////                    .focused($focusedField, equals: field)
////////                    .font(.body)
////////            }
////////            .padding(.horizontal, 14)
////////            .padding(.vertical, 14)
////////            .background(Color(.systemBackground))
////////            .clipShape(RoundedRectangle(cornerRadius: 12))
////////            .overlay(
////////                RoundedRectangle(cornerRadius: 12)
////////                    .stroke(
////////                        focusedField == field ? Color.blue : Color(.separator),
////////                        lineWidth: focusedField == field ? 1.5 : 0.8
////////                    )
////////            )
////////        }
////////    }
////////}
////////
////////// MARK: - OPDRegistrationView
////////struct OPDRegistrationView: View {
////////    @State private var fullName: String = ""
////////    @State private var nicNumber: String = ""
////////    @State private var mobileNumber: String = ""
////////    @State private var navigateToOTP = false
////////    @FocusState private var focusedField: Field?
////////
////////    enum Field { case fullName, nic, mobile }
////////
////////    private var canContinue: Bool {
////////        !fullName.isEmpty && !nicNumber.isEmpty && mobileNumber.count >= 9
////////    }
////////
////////    var body: some View {
////////        ScrollView {
////////            VStack(alignment: .leading, spacing: 24) {
////////                Text("Enter basic details to register")
////////                    .font(.subheadline)
////////                    .foregroundStyle(.secondary)
////////                    .padding(.top, 4)
////////
////////                VStack(alignment: .leading, spacing: 0) {
////////                    formField(label: "Full Name",     placeholder: "Enter your full name",  text: $fullName,     field: .fullName, keyboardType: .default)
////////                    Divider().padding(.horizontal, 16)
////////                    formField(label: "NIC number",    placeholder: "Enter NIC number",       text: $nicNumber,    field: .nic,      keyboardType: .default)
////////                    Divider().padding(.horizontal, 16)
////////                    formField(label: "Mobile Number", placeholder: "Enter mobile number",    text: $mobileNumber, field: .mobile,   keyboardType: .phonePad)
////////                    Divider().padding(.horizontal, 16)
////////
////////                    Button {
////////                        focusedField = nil
////////                        navigateToOTP = true
////////                    } label: {
////////                        Text("Continue")
////////                            .font(.headline).fontWeight(.semibold)
////////                            .foregroundStyle(.white)
////////                            .frame(maxWidth: .infinity).frame(height: 50)
////////                            .background(RoundedRectangle(cornerRadius: 12).fill(canContinue ? Color.blue : Color(.systemGray4)))
////////                    }
////////                    .disabled(!canContinue)
////////                    .padding(16)
////////                    .navigationDestination(isPresented: $navigateToOTP) { OTPView() }
////////                }
////////                .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemBackground)).shadow(color: .black.opacity(0.05), radius: 12, y: 4))
////////
////////                Text("You can provide additional details later at the hospital help desk")
////////                    .font(.caption).foregroundStyle(.secondary)
////////                    .multilineTextAlignment(.center).frame(maxWidth: .infinity).padding(.horizontal, 8)
////////            }
////////            .padding(.horizontal, 20).padding(.top, 8).padding(.bottom, 40)
////////        }
////////        .background(Color(.systemGroupedBackground))
////////        .navigationTitle("OPD Registration")
////////        .navigationBarTitleDisplayMode(.large)
////////        .onTapGesture { focusedField = nil }
////////    }
////////
////////    @ViewBuilder
////////    private func formField(label: String, placeholder: String, text: Binding<String>, field: Field, keyboardType: UIKeyboardType) -> some View {
////////        VStack(alignment: .leading, spacing: 6) {
////////            Text(label).font(.subheadline).fontWeight(.medium).foregroundStyle(.primary)
////////            TextField(placeholder, text: text)
////////                .keyboardType(keyboardType).focused($focusedField, equals: field)
////////                .font(.body).foregroundStyle(.primary)
////////                .padding(.vertical, 12).padding(.horizontal, 12)
////////                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.secondarySystemBackground)))
////////                .overlay(RoundedRectangle(cornerRadius: 10).stroke(focusedField == field ? Color.blue : Color.clear, lineWidth: 1.5))
////////        }
////////        .padding(.horizontal, 16).padding(.vertical, 14)
////////    }
////////}
////////
////////#Preview { LoginView() }
////////
//////
//////
//////import SwiftUI
//////
//////struct LoginView: View {
//////    @State private var opdNumber: String = ""
//////    @State private var mobileNumber: String = ""
//////    @State private var navigateToOTP = false
//////    @State private var navigateToRegister = false
//////    @FocusState private var focusedField: Field?
//////
//////    enum Field { case opd, mobile }
//////
//////    private var canProceed: Bool {
//////        !opdNumber.isEmpty && mobileNumber.count >= 9
//////    }
//////
//////    var body: some View {
//////        NavigationStack {
//////            ScrollView {
//////                VStack(spacing: 0) {
//////                    // Brand Header
//////                    VStack(spacing: 20) {
//////                        // Logo image from Assets
//////                        Image("logo")
//////                            .resizable()
//////                            .scaledToFit()
//////                            .frame(width: 76, height: 76)
//////                            .clipShape(RoundedRectangle(cornerRadius: 22))
//////                            .shadow(color: .blue.opacity(0.25), radius: 20, y: 8)
//////
//////                        VStack(spacing: 8) {
//////                            Text("HealthClinic")
//////                                .font(.title)
//////                                .fontWeight(.bold)
//////                                .foregroundStyle(.primary)
//////                            Text("Sign in to continue")
//////                                .font(.subheadline)
//////                                .foregroundStyle(.secondary)
//////                        }
//////                    }
//////                    .padding(.top, 64)
//////                    .padding(.bottom, 48)
//////
//////                    // Input Fields
//////                    VStack(spacing: 14) {
//////                        inputField(
//////                            title: "OPD Registration Number",
//////                            placeholder: "Enter your OPD number",
//////                            icon: "person.text.rectangle",
//////                            text: $opdNumber,
//////                            field: .opd,
//////                            keyboard: .numberPad
//////                        )
//////
//////                        inputField(
//////                            title: "Mobile Number",
//////                            placeholder: "07X XXX XXXX",
//////                            icon: "phone",
//////                            text: $mobileNumber,
//////                            field: .mobile,
//////                            keyboard: .phonePad
//////                        )
//////                    }
//////                    .padding(.bottom, 28)
//////
//////                    // Sign In Button with Gradient
//////                    Button {
//////                        focusedField = nil
//////                        navigateToOTP = true
//////                    } label: {
//////                        Text("Sign In")
//////                            .font(.headline)
//////                            .foregroundStyle(.white)
//////                            .frame(maxWidth: .infinity)
//////                            .frame(height: 52)
//////                            .background(
//////                                Group {
//////                                    if canProceed {
//////                                        LinearGradient(
//////                                            colors: [.blue, .cyan],
//////                                            startPoint: .leading,
//////                                            endPoint: .trailing
//////                                        )
//////                                    } else {
//////                                        Color(.systemGray4)
//////                                    }
//////                                }
//////                            )
//////                            .clipShape(RoundedRectangle(cornerRadius: 14))
//////                            .shadow(color: canProceed ? .blue.opacity(0.3) : .clear,
//////                                    radius: 12, y: 5)
//////                    }
//////                    .disabled(!canProceed)
//////                    .navigationDestination(isPresented: $navigateToOTP) { OTPView() }
//////                    .padding(.bottom, 20)
//////
//////                    // Register Link
//////                    Button {
//////                        navigateToRegister = true
//////                    } label: {
//////                        HStack(spacing: 4) {
//////                            Text("Don't have an account?")
//////                                .foregroundStyle(.secondary)
//////                            Text("Register")
//////                                .foregroundStyle(.blue)
//////                                .fontWeight(.semibold)
//////                        }
//////                        .font(.subheadline)
//////                    }
//////                    .navigationDestination(isPresented: $navigateToRegister) {
//////                        OPDRegistrationView()
//////                    }
//////                    .padding(.bottom, 32)
//////
//////                    // Terms
//////                    Text("By continuing you agree to our Terms of Service\nand Privacy Policy")
//////                        .font(.caption)
//////                        .foregroundStyle(.tertiary)
//////                        .multilineTextAlignment(.center)
//////
//////                    Spacer(minLength: 40)
//////                }
//////                .padding(.horizontal, 24)
//////            }
//////            .background(Color(.systemGroupedBackground))
//////            .navigationBarHidden(true)
//////            .onTapGesture { focusedField = nil }
//////        }
//////    }
//////
//////    @ViewBuilder
//////    private func inputField(
//////        title: String,
//////        placeholder: String,
//////        icon: String,
//////        text: Binding<String>,
//////        field: Field,
//////        keyboard: UIKeyboardType
//////    ) -> some View {
//////        VStack(alignment: .leading, spacing: 8) {
//////            Text(title)
//////                .font(.footnote)
//////                .fontWeight(.medium)
//////                .foregroundStyle(.secondary)
//////
//////            HStack(spacing: 12) {
//////                Image(systemName: icon)
//////                    .font(.system(size: 15, weight: .regular))
//////                    .foregroundStyle(.secondary)
//////                    .frame(width: 18)
//////
//////                TextField(placeholder, text: text)
//////                    .keyboardType(keyboard)
//////                    .focused($focusedField, equals: field)
//////                    .font(.body)
//////            }
//////            .padding(.horizontal, 14)
//////            .padding(.vertical, 14)
//////            .background(Color(.systemBackground))
//////            .clipShape(RoundedRectangle(cornerRadius: 12))
//////            .overlay(
//////                RoundedRectangle(cornerRadius: 12)
//////                    .stroke(
//////                        focusedField == field ? Color.blue : Color(.separator),
//////                        lineWidth: focusedField == field ? 1.5 : 0.8
//////                    )
//////            )
//////        }
//////    }
//////}
////////
////////// MARK: - OPDRegistrationView
////////struct OPDRegistrationView: View {
////////    @State private var fullName: String = ""
////////    @State private var nicNumber: String = ""
////////    @State private var mobileNumber: String = ""
////////    @State private var navigateToOTP = false
////////    @FocusState private var focusedField: Field?
////////
////////    enum Field { case fullName, nic, mobile }
////////
////////    private var canContinue: Bool {
////////        !fullName.isEmpty && !nicNumber.isEmpty && mobileNumber.count >= 9
////////    }
////////
////////    var body: some View {
////////        ScrollView {
////////            VStack(alignment: .leading, spacing: 24) {
////////                Text("Enter basic details to register")
////////                    .font(.subheadline)
////////                    .foregroundStyle(.secondary)
////////                    .padding(.top, 4)
////////
////////                VStack(alignment: .leading, spacing: 0) {
////////                    formField(label: "Full Name",     placeholder: "Enter your full name",  text: $fullName,     field: .fullName, keyboardType: .default)
////////                    Divider().padding(.horizontal, 16)
////////                    formField(label: "NIC number",    placeholder: "Enter NIC number",       text: $nicNumber,    field: .nic,      keyboardType: .default)
////////                    Divider().padding(.horizontal, 16)
////////                    formField(label: "Mobile Number", placeholder: "Enter mobile number",    text: $mobileNumber, field: .mobile,   keyboardType: .phonePad)
////////                    Divider().padding(.horizontal, 16)
////////
////////                    // Continue Button with Gradient
////////                    Button {
////////                        focusedField = nil
////////                        navigateToOTP = true
////////                    } label: {
////////                        Text("Continue")
////////                            .font(.headline)
////////                            .fontWeight(.semibold)
////////                            .foregroundStyle(.white)
////////                            .frame(maxWidth: .infinity)
////////                            .frame(height: 50)
////////                            .background(
////////                                Group {
////////                                    if canContinue {
////////                                        LinearGradient(
////////                                            colors: [.blue, .cyan],
////////                                            startPoint: .leading,
////////                                            endPoint: .trailing
////////                                        )
////////                                    } else {
////////                                        Color(.systemGray4)
////////                                    }
////////                                }
////////                            )
////////                            .clipShape(RoundedRectangle(cornerRadius: 12))
////////                            .shadow(color: canContinue ? .blue.opacity(0.3) : .clear,
////////                                    radius: 8, y: 4)
////////                    }
////////                    .disabled(!canContinue)
////////                    .padding(16)
////////                    .navigationDestination(isPresented: $navigateToOTP) { OTPView() }
////////                }
////////                .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemBackground)).shadow(color: .black.opacity(0.05), radius: 12, y: 4))
////////
////////                Text("You can provide additional details later at the hospital help desk")
////////                    .font(.caption).foregroundStyle(.secondary)
////////                    .multilineTextAlignment(.center).frame(maxWidth: .infinity).padding(.horizontal, 8)
////////            }
////////            .padding(.horizontal, 20).padding(.top, 8).padding(.bottom, 40)
////////        }
////////        .background(Color(.systemGroupedBackground))
////////        .navigationTitle("OPD Registration")
////////        .navigationBarTitleDisplayMode(.large)
////////        .onTapGesture { focusedField = nil }
////////    }
////////
////////    @ViewBuilder
////////    private func formField(label: String, placeholder: String, text: Binding<String>, field: Field, keyboardType: UIKeyboardType) -> some View {
////////        VStack(alignment: .leading, spacing: 6) {
////////            Text(label).font(.subheadline).fontWeight(.medium).foregroundStyle(.primary)
////////            TextField(placeholder, text: text)
////////                .keyboardType(keyboardType).focused($focusedField, equals: field)
////////                .font(.body).foregroundStyle(.primary)
////////                .padding(.vertical, 12).padding(.horizontal, 12)
////////                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.secondarySystemBackground)))
////////                .overlay(RoundedRectangle(cornerRadius: 10).stroke(focusedField == field ? Color.blue : Color.clear, lineWidth: 1.5))
////////        }
////////        .padding(.horizontal, 16).padding(.vertical, 14)
////////    }
////////}
////////
////////#Preview { LoginView() }
//////
//////
////////// MARK: - OPDRegistrationView
////////struct OPDRegistrationView: View {
////////    @State private var fullName: String = ""
////////    @State private var nicNumber: String = ""
////////    @State private var mobileNumber: String = ""
////////    @State private var navigateToSuccess = false
////////    @State private var generatedOPDNumber = ""
////////    @FocusState private var focusedField: Field?
////////
////////    enum Field { case fullName, nic, mobile }
////////
////////    private var canContinue: Bool {
////////        !fullName.isEmpty && !nicNumber.isEmpty && mobileNumber.count >= 9
////////    }
////////
////////    var body: some View {
////////        ScrollView {
////////            VStack(alignment: .leading, spacing: 24) {
////////                Text("Enter basic details to register")
////////                    .font(.subheadline)
////////                    .foregroundStyle(.secondary)
////////                    .padding(.top, 4)
////////
////////                VStack(alignment: .leading, spacing: 0) {
////////                    formField(label: "Full Name",     placeholder: "Enter your full name",  text: $fullName,     field: .fullName, keyboardType: .default)
////////                    Divider().padding(.horizontal, 16)
////////                    formField(label: "NIC number",    placeholder: "Enter NIC number",       text: $nicNumber,    field: .nic,      keyboardType: .default)
////////                    Divider().padding(.horizontal, 16)
////////                    formField(label: "Mobile Number", placeholder: "Enter mobile number",    text: $mobileNumber, field: .mobile,   keyboardType: .phonePad)
////////                    Divider().padding(.horizontal, 16)
////////
////////                    // Continue Button with Gradient
////////                    Button {
////////                        focusedField = nil
////////                        // Generate a random OPD number
////////                        generatedOPDNumber = generateOPDNumber()
////////                        navigateToSuccess = true
////////                    } label: {
////////                        Text("Continue")
////////                            .font(.headline)
////////                            .fontWeight(.semibold)
////////                            .foregroundStyle(.white)
////////                            .frame(maxWidth: .infinity)
////////                            .frame(height: 50)
////////                            .background(
////////                                Group {
////////                                    if canContinue {
////////                                        LinearGradient(
////////                                            colors: [.blue, .cyan],
////////                                            startPoint: .leading,
////////                                            endPoint: .trailing
////////                                        )
////////                                    } else {
////////                                        Color(.systemGray4)
////////                                    }
////////                                }
////////                            )
////////                            .clipShape(RoundedRectangle(cornerRadius: 12))
////////                            .shadow(color: canContinue ? .blue.opacity(0.3) : .clear,
////////                                    radius: 8, y: 4)
////////                    }
////////                    .disabled(!canContinue)
////////                    .padding(16)
////////                    .navigationDestination(isPresented: $navigateToSuccess) {
////////                        OPDRegistrationSuccessView(opdNumber: generatedOPDNumber)
////////                    }
////////                }
////////                .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemBackground)).shadow(color: .black.opacity(0.05), radius: 12, y: 4))
////////
////////                Text("You can provide additional details later at the hospital help desk")
////////                    .font(.caption).foregroundStyle(.secondary)
////////                    .multilineTextAlignment(.center).frame(maxWidth: .infinity).padding(.horizontal, 8)
////////            }
////////            .padding(.horizontal, 20).padding(.top, 8).padding(.bottom, 40)
////////        }
////////        .background(Color(.systemGroupedBackground))
////////        .navigationTitle("OPD Registration")
////////        .navigationBarTitleDisplayMode(.large)
////////        .onTapGesture { focusedField = nil }
////////    }
////////
////////    @ViewBuilder
////////    private func formField(label: String, placeholder: String, text: Binding<String>, field: Field, keyboardType: UIKeyboardType) -> some View {
////////        VStack(alignment: .leading, spacing: 6) {
////////            Text(label).font(.subheadline).fontWeight(.medium).foregroundStyle(.primary)
////////            TextField(placeholder, text: text)
////////                .keyboardType(keyboardType).focused($focusedField, equals: field)
////////                .font(.body).foregroundStyle(.primary)
////////                .padding(.vertical, 12).padding(.horizontal, 12)
////////                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.secondarySystemBackground)))
////////                .overlay(RoundedRectangle(cornerRadius: 10).stroke(focusedField == field ? Color.blue : Color.clear, lineWidth: 1.5))
////////        }
////////        .padding(.horizontal, 16).padding(.vertical, 14)
////////    }
////////    
////////    // Helper function to generate a random OPD number
////////    private func generateOPDNumber() -> String {
////////        let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
////////        let randomLetters = (0..<2).map { _ in letters.randomElement()! }.joined()
////////        let randomNumbers = (0..<4).map { _ in String(Int.random(in: 0...9)) }.joined()
////////        return "OPD-\(randomLetters)\(randomNumbers)"
////////    }
////////}
//////
//////
//////
//////// MARK: - OPDRegistrationView
//////struct OPDRegistrationView: View {
//////    @State private var fullName: String = ""
//////    @State private var nicNumber: String = ""
//////    @State private var mobileNumber: String = ""
//////    @State private var navigateToSuccess = false
//////    @State private var generatedOPDNumber = ""
//////    @FocusState private var focusedField: Field?
//////
//////    enum Field { case fullName, nic, mobile }
//////
//////    private var canContinue: Bool {
//////        !fullName.isEmpty && !nicNumber.isEmpty && mobileNumber.count >= 9
//////    }
//////
//////    var body: some View {
//////        ScrollView {
//////            VStack(alignment: .leading, spacing: 24) {
//////                Text("Enter basic details to register")
//////                    .font(.subheadline)
//////                    .foregroundStyle(.secondary)
//////                    .padding(.top, 4)
//////
//////                VStack(alignment: .leading, spacing: 0) {
//////                    formField(label: "Full Name",     placeholder: "Enter your full name",  text: $fullName,     field: .fullName, keyboardType: .default)
//////                    Divider().padding(.horizontal, 16)
//////                    formField(label: "NIC number",    placeholder: "Enter NIC number",       text: $nicNumber,    field: .nic,      keyboardType: .default)
//////                    Divider().padding(.horizontal, 16)
//////                    formField(label: "Mobile Number", placeholder: "Enter mobile number",    text: $mobileNumber, field: .mobile,   keyboardType: .phonePad)
//////                    Divider().padding(.horizontal, 16)
//////
//////                    // Continue Button with Gradient
//////                    Button {
//////                        focusedField = nil
//////                        // Generate a random OPD number
//////                        generatedOPDNumber = generateOPDNumber()
//////                        navigateToSuccess = true
//////                    } label: {
//////                        Text("Continue")
//////                            .font(.headline)
//////                            .fontWeight(.semibold)
//////                            .foregroundStyle(.white)
//////                            .frame(maxWidth: .infinity)
//////                            .frame(height: 50)
//////                            .background(
//////                                Group {
//////                                    if canContinue {
//////                                        LinearGradient(
//////                                            colors: [.blue, .cyan],
//////                                            startPoint: .leading,
//////                                            endPoint: .trailing
//////                                        )
//////                                    } else {
//////                                        Color(.systemGray4)
//////                                    }
//////                                }
//////                            )
//////                            .clipShape(RoundedRectangle(cornerRadius: 12))
//////                            .shadow(color: canContinue ? .blue.opacity(0.3) : .clear,
//////                                    radius: 8, y: 4)
//////                    }
//////                    .disabled(!canContinue)
//////                    .padding(16)
//////                    .navigationDestination(isPresented: $navigateToSuccess) {
//////                        OPDRegistrationSuccessView(opdNumber: generatedOPDNumber)
//////                    }
//////                }
//////                .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemBackground)).shadow(color: .black.opacity(0.05), radius: 12, y: 4))
//////
//////                Text("You can provide additional details later at the hospital help desk")
//////                    .font(.caption).foregroundStyle(.secondary)
//////                    .multilineTextAlignment(.center).frame(maxWidth: .infinity).padding(.horizontal, 8)
//////            }
//////            .padding(.horizontal, 20).padding(.top, 8).padding(.bottom, 40)
//////        }
//////        .background(Color(.systemGroupedBackground))
//////        .navigationTitle("OPD Registration")
//////        .navigationBarTitleDisplayMode(.large)
//////        .onTapGesture { focusedField = nil }
//////    }
//////
//////    @ViewBuilder
//////    private func formField(label: String, placeholder: String, text: Binding<String>, field: Field, keyboardType: UIKeyboardType) -> some View {
//////        VStack(alignment: .leading, spacing: 6) {
//////            Text(label).font(.subheadline).fontWeight(.medium).foregroundStyle(.primary)
//////            TextField(placeholder, text: text)
//////                .keyboardType(keyboardType).focused($focusedField, equals: field)
//////                .font(.body).foregroundStyle(.primary)
//////                .padding(.vertical, 12).padding(.horizontal, 12)
//////                .background(RoundedRectangle(cornerRadius: 10).fill(Color(.secondarySystemBackground)))
//////                .overlay(RoundedRectangle(cornerRadius: 10).stroke(focusedField == field ? Color.blue : Color.clear, lineWidth: 1.5))
//////        }
//////        .padding(.horizontal, 16).padding(.vertical, 14)
//////    }
//////    
//////    // Helper function to generate a random OPD number
//////    private func generateOPDNumber() -> String {
//////        let letters = ["A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
//////        let randomLetters = (0..<2).map { _ in letters.randomElement()! }.joined()
//////        let randomNumbers = (0..<4).map { _ in String(Int.random(in: 0...9)) }.joined()
//////        return "OPD-\(randomLetters)\(randomNumbers)"
//////    }
//////}
////
////
////
////import SwiftUI
////
////struct LoginView: View {
////    @State private var opdNumber: String = ""
////    @State private var mobileNumber: String = ""
////    @State private var navigateToOTP = false
////    @State private var navigateToRegister = false
////    @FocusState private var focusedField: Field?
////
////    enum Field { case opd, mobile }
////
////    private var canProceed: Bool {
////        !opdNumber.isEmpty && mobileNumber.count >= 9
////    }
////
////    var body: some View {
////        NavigationStack {
////            ScrollView {
////                VStack(spacing: 0) {
////                    // Brand Header
////                    VStack(spacing: 20) {
////                        // Logo image from Assets
////                        Image("logo")
////                            .resizable()
////                            .scaledToFit()
////                            .frame(width: 76, height: 76)
////                            .clipShape(RoundedRectangle(cornerRadius: 22))
////                            .shadow(color: .blue.opacity(0.25), radius: 20, y: 8)
////
////                        VStack(spacing: 8) {
////                            Text("HealthClinic")
////                                .font(.title)
////                                .fontWeight(.bold)
////                                .foregroundStyle(.primary)
////                            Text("Sign in to continue")
////                                .font(.subheadline)
////                                .foregroundStyle(.secondary)
////                        }
////                    }
////                    .padding(.top, 64)
////                    .padding(.bottom, 48)
////
////                    // Input Fields
////                    VStack(spacing: 14) {
////                        inputField(
////                            title: "OPD Registration Number",
////                            placeholder: "Enter your OPD number",
////                            icon: "person.text.rectangle",
////                            text: $opdNumber,
////                            field: .opd,
////                            keyboard: .numberPad
////                        )
////
////                        inputField(
////                            title: "Mobile Number",
////                            placeholder: "07X XXX XXXX",
////                            icon: "phone",
////                            text: $mobileNumber,
////                            field: .mobile,
////                            keyboard: .phonePad
////                        )
////                    }
////                    .padding(.bottom, 28)
////
////                    // Sign In Button with Gradient
////                    Button {
////                        focusedField = nil
////                        navigateToOTP = true
////                    } label: {
////                        Text("Sign In")
////                            .font(.headline)
////                            .foregroundStyle(.white)
////                            .frame(maxWidth: .infinity)
////                            .frame(height: 52)
////                            .background(
////                                Group {
////                                    if canProceed {
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
////                            .clipShape(RoundedRectangle(cornerRadius: 14))
////                            .shadow(color: canProceed ? .blue.opacity(0.3) : .clear,
////                                    radius: 12, y: 5)
////                    }
////                    .disabled(!canProceed)
////                    .navigationDestination(isPresented: $navigateToOTP) { OTPView() }
////                    .padding(.bottom, 20)
////
////                    // Register Link
////                    Button {
////                        navigateToRegister = true
////                    } label: {
////                        HStack(spacing: 4) {
////                            Text("Don't have an account?")
////                                .foregroundStyle(.secondary)
////                            Text("Register")
////                                .foregroundStyle(.blue)
////                                .fontWeight(.semibold)
////                        }
////                        .font(.subheadline)
////                    }
////                    .navigationDestination(isPresented: $navigateToRegister) {
////                        OPDRegistrationView()
////                    }
////                    .padding(.bottom, 32)
////
////                    // Terms
////                    Text("By continuing you agree to our Terms of Service\nand Privacy Policy")
////                        .font(.caption)
////                        .foregroundStyle(.tertiary)
////                        .multilineTextAlignment(.center)
////
////                    Spacer(minLength: 40)
////                }
////                .padding(.horizontal, 24)
////            }
////            .background(Color(.systemGroupedBackground))
////            .navigationBarHidden(true)
////            .onTapGesture { focusedField = nil }
////        }
////    }
////
////    @ViewBuilder
////    private func inputField(
////        title: String,
////        placeholder: String,
////        icon: String,
////        text: Binding<String>,
////        field: Field,
////        keyboard: UIKeyboardType
////    ) -> some View {
////        VStack(alignment: .leading, spacing: 8) {
////            Text(title)
////                .font(.footnote)
////                .fontWeight(.medium)
////                .foregroundStyle(.secondary)
////
////            HStack(spacing: 12) {
////                Image(systemName: icon)
////                    .font(.system(size: 15, weight: .regular))
////                    .foregroundStyle(.secondary)
////                    .frame(width: 18)
////
////                TextField(placeholder, text: text)
////                    .keyboardType(keyboard)
////                    .focused($focusedField, equals: field)
////                    .font(.body)
////            }
////            .padding(.horizontal, 14)
////            .padding(.vertical, 14)
////            .background(Color(.systemBackground))
////            .clipShape(RoundedRectangle(cornerRadius: 12))
////            .overlay(
////                RoundedRectangle(cornerRadius: 12)
////                    .stroke(
////                        focusedField == field ? Color.blue : Color(.separator),
////                        lineWidth: focusedField == field ? 1.5 : 0.8
////                    )
////            )
////        }
////    }
////}
////
////#Preview {
////    LoginView()
////}
//
import SwiftUI

struct LoginView: View {
    @State private var opdNumber: String = ""
    @State private var mobileNumber: String = ""
    @State private var navigateToOTP = false
    @State private var navigateToRegister = false
    @FocusState private var focusedField: Field?
    @StateObject private var navigationState = NavigationState()

    enum Field { case opd, mobile }

    private var canProceed: Bool {
        !opdNumber.isEmpty && mobileNumber.count >= 9
    }

    var body: some View {
        NavigationStack(path: $navigationState.path) {
            ScrollView {
                VStack(spacing: 0) {
                    // Brand Header
                    VStack(spacing: 20) {
                        // Logo image from Assets
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 76, height: 76)
                            .clipShape(RoundedRectangle(cornerRadius: 22))
                            .shadow(color: .blue.opacity(0.25), radius: 20, y: 8)

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

                    // Input Fields
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

                    // Sign In Button with Gradient
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
                                Group {
                                    if canProceed {
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
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .shadow(color: canProceed ? .blue.opacity(0.3) : .clear,
                                    radius: 12, y: 5)
                    }
                    .disabled(!canProceed)
                    .navigationDestination(isPresented: $navigateToOTP) { OTPView() }
                    .padding(.bottom, 20)

                    // Register Link
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

                    // Terms
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
        .environmentObject(navigationState)
    }

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
