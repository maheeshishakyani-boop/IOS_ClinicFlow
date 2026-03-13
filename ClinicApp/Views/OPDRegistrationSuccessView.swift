////////
/////////
///////////
//////////  OPDRegistrationSuccessView.swift
//////////  ClinicApp
//////////
//////////  Created by BSCComp-046 on 2026-03-13.
//////////
////////
//////////
//////////  OPDRegistrationSuccessView.swift
//////////  ClinicApp
//////////
////////
////////import SwiftUI
////////
////////struct OPDRegistrationSuccessView: View {
////////
////////    let opdNumber: String
////////
////////    // Dismiss the entire navigation stack back to LoginView
////////    @Environment(\.dismiss) private var dismiss
////////
////////    var body: some View {
////////        ZStack {
////////            Color(.systemGroupedBackground).ignoresSafeArea()
////////
////////            ScrollView {
////////                VStack(spacing: 0) {
////////
////////                    Spacer().frame(height: 48)
////////
////////                    // MARK: Success Icon
////////                    ZStack {
////////                        Circle()
////////                            .fill(Color(.systemGreen))
////////                            .frame(width: 88, height: 88)
////////
////////                        Image(systemName: "checkmark")
////////                            .font(.system(size: 38, weight: .semibold))
////////                            .foregroundStyle(.white)
////////                    }
////////                    .padding(.bottom, 24)
////////
////////                    // MARK: Title
////////                    Text("Registration Complete")
////////                        .font(.system(size: 26, weight: .bold, design: .rounded))
////////                        .foregroundStyle(.primary)
////////
////////                    Text("Your OPD registration was successful")
////////                        .font(.subheadline)
////////                        .foregroundStyle(.secondary)
////////                        .multilineTextAlignment(.center)
////////                        .padding(.top, 8)
////////                        .padding(.bottom, 32)
////////
////////                    // MARK: OPD Number Card
////////                    VStack(alignment: .leading, spacing: 16) {
////////
////////                        // Card header
////////                        HStack(spacing: 10) {
////////                            ZStack {
////////                                RoundedRectangle(cornerRadius: 10)
////////                                    .fill(Color.green.opacity(0.15))
////////                                    .frame(width: 38, height: 38)
////////                                Image(systemName: "doc.text")
////////                                    .font(.system(size: 16, weight: .medium))
////////                                    .foregroundStyle(.green)
////////                            }
////////                            Text("Your OPD Registration Number")
////////                                .font(.subheadline)
////////                                .fontWeight(.semibold)
////////                        }
////////
////////                        // Number display
////////                        Text(opdNumber)
////////                            .font(.system(size: 26, weight: .bold, design: .monospaced))
////////                            .foregroundStyle(.blue)
////////                            .frame(maxWidth: .infinity)
////////                            .padding(.vertical, 16)
////////                            .background(
////////                                RoundedRectangle(cornerRadius: 12)
////////                                    .fill(Color(.secondarySystemBackground))
////////                            )
////////
////////                        // Warning note
////////                        HStack(alignment: .top, spacing: 10) {
////////                            Image(systemName: "info.circle.fill")
////////                                .foregroundStyle(.orange)
////////                                .font(.system(size: 15))
////////                                .padding(.top, 1)
////////
////////                            Text("Keep this OPD registration number safe. You will use it together with your mobile number to log in.")
////////                                .font(.footnote)
////////                                .foregroundStyle(Color.orange.opacity(0.9))
////////                                .fixedSize(horizontal: false, vertical: true)
////////                        }
////////                        .padding(14)
////////                        .background(
////////                            RoundedRectangle(cornerRadius: 10)
////////                                .fill(Color.orange.opacity(0.08))
////////                        )
////////                    }
////////                    .padding(18)
////////                    .background(
////////                        RoundedRectangle(cornerRadius: 16)
////////                            .fill(Color(.systemBackground))
////////                    )
////////                    .padding(.horizontal, 24)
////////                    .padding(.bottom, 12)
////////
////////                    // MARK: Lock Note Card
////////                    HStack(alignment: .top, spacing: 10) {
////////                        Image(systemName: "lock.fill")
////////                            .foregroundStyle(.secondary)
////////                            .font(.system(size: 14))
////////                            .padding(.top, 1)
////////
////////                        Text("This number is only for logging in to the clinic app.")
////////                            .font(.footnote)
////////                            .foregroundStyle(.secondary)
////////                            .fixedSize(horizontal: false, vertical: true)
////////                    }
////////                    .frame(maxWidth: .infinity, alignment: .leading)
////////                    .padding(14)
////////                    .background(
////////                        RoundedRectangle(cornerRadius: 12)
////////                            .fill(Color(.systemBackground))
////////                    )
////////                    .padding(.horizontal, 24)
////////
////////                    Spacer().frame(height: 40)
////////
////////                    // MARK: Continue Button
////////                    Button {
////////                        // Pop back to root (LoginView)
////////                        dismiss()
////////                    } label: {
////////                        Text("Continue to Login")
////////                            .font(.headline)
////////                            .foregroundStyle(.white)
////////                            .frame(maxWidth: .infinity)
////////                            .frame(height: 50)
////////                            .background(
////////                                RoundedRectangle(cornerRadius: 12)
////////                                    .fill(Color.blue)
////////                            )
////////                    }
////////                    .padding(.horizontal, 24)
////////                    .padding(.bottom, 40)
////////                }
////////            }
////////        }
////////        .navigationBarHidden(true)
////////        .navigationBarBackButtonHidden(true)
////////    }
////////}
////////
////////#Preview {
////////    NavigationStack {
////////        OPDRegistrationSuccessView(opdNumber: "OPD-REG-4512")
////////    }
////////}
//////
//////
////////
////////  OPDRegistrationSuccessView.swift
////////  ClinicApp
////////
////////  Created by BSCComp-046 on 2026-03-13.
////////
//////
//////import SwiftUI
//////
//////struct OPDRegistrationSuccessView: View {
//////
//////    let opdNumber: String
//////
//////    // Dismiss the entire navigation stack back to LoginView
//////    @Environment(\.dismiss) private var dismiss
//////
//////    var body: some View {
//////        ZStack {
//////            Color(.systemGroupedBackground).ignoresSafeArea()
//////
//////            ScrollView {
//////                VStack(spacing: 0) {
//////
//////                    Spacer().frame(height: 48)
//////
//////                    // MARK: Success Icon
//////                    ZStack {
//////                        Circle()
//////                            .fill(Color.green)
//////                            .frame(width: 88, height: 88)
//////                            .shadow(color: .green.opacity(0.3), radius: 12, y: 5)
//////
//////                        Image(systemName: "checkmark")
//////                            .font(.system(size: 38, weight: .semibold))
//////                            .foregroundStyle(.white)
//////                    }
//////                    .padding(.bottom, 24)
//////
//////                    // MARK: Title
//////                    Text("Registration Complete")
//////                        .font(.system(size: 26, weight: .bold, design: .rounded))
//////                        .foregroundStyle(.primary)
//////
//////                    Text("Your OPD registration was successful")
//////                        .font(.subheadline)
//////                        .foregroundStyle(.secondary)
//////                        .multilineTextAlignment(.center)
//////                        .padding(.top, 8)
//////                        .padding(.bottom, 32)
//////
//////                    // MARK: OPD Number Card
//////                    VStack(alignment: .leading, spacing: 16) {
//////
//////                        // Card header
//////                        HStack(spacing: 10) {
//////                            ZStack {
//////                                RoundedRectangle(cornerRadius: 10)
//////                                    .fill(Color.green.opacity(0.15))
//////                                    .frame(width: 38, height: 38)
//////                                Image(systemName: "doc.text")
//////                                    .font(.system(size: 16, weight: .medium))
//////                                    .foregroundStyle(.green)
//////                            }
//////                            Text("Your OPD Registration Number")
//////                                .font(.subheadline)
//////                                .fontWeight(.semibold)
//////                        }
//////
//////                        // Number display
//////                        Text(opdNumber)
//////                            .font(.system(size: 26, weight: .bold, design: .monospaced))
//////                            .foregroundStyle(.blue)
//////                            .frame(maxWidth: .infinity)
//////                            .padding(.vertical, 16)
//////                            .background(
//////                                RoundedRectangle(cornerRadius: 12)
//////                                    .fill(Color(.secondarySystemBackground))
//////                            )
//////
//////                        // Warning note
//////                        HStack(alignment: .top, spacing: 10) {
//////                            Image(systemName: "info.circle.fill")
//////                                .foregroundStyle(.orange)
//////                                .font(.system(size: 15))
//////                                .padding(.top, 1)
//////
//////                            Text("Keep this OPD registration number safe. You will use it together with your mobile number to log in.")
//////                                .font(.footnote)
//////                                .foregroundStyle(Color.orange.opacity(0.9))
//////                                .fixedSize(horizontal: false, vertical: true)
//////                        }
//////                        .padding(14)
//////                        .background(
//////                            RoundedRectangle(cornerRadius: 10)
//////                                .fill(Color.orange.opacity(0.08))
//////                        )
//////                    }
//////                    .padding(18)
//////                    .background(
//////                        RoundedRectangle(cornerRadius: 16)
//////                            .fill(Color(.systemBackground))
//////                            .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
//////                    )
//////                    .padding(.horizontal, 24)
//////                    .padding(.bottom, 12)
//////
//////                    // MARK: Lock Note Card
//////                    HStack(alignment: .top, spacing: 10) {
//////                        Image(systemName: "lock.fill")
//////                            .foregroundStyle(.secondary)
//////                            .font(.system(size: 14))
//////                            .padding(.top, 1)
//////
//////                        Text("This number is only for logging in to the clinic app.")
//////                            .font(.footnote)
//////                            .foregroundStyle(.secondary)
//////                            .fixedSize(horizontal: false, vertical: true)
//////                    }
//////                    .frame(maxWidth: .infinity, alignment: .leading)
//////                    .padding(14)
//////                    .background(
//////                        RoundedRectangle(cornerRadius: 12)
//////                            .fill(Color(.systemBackground))
//////                            .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
//////                    )
//////                    .padding(.horizontal, 24)
//////
//////                    Spacer().frame(height: 40)
//////
//////                    // MARK: Continue to Login Button with Gradient
//////                    Button {
//////                        // Pop back to root (LoginView)
//////                        dismiss()
//////                    } label: {
//////                        Text("Continue to Login")
//////                            .font(.headline)
//////                            .fontWeight(.semibold)
//////                            .foregroundStyle(.white)
//////                            .frame(maxWidth: .infinity)
//////                            .frame(height: 54)
//////                            .background(
//////                                LinearGradient(
//////                                    colors: [.blue, .cyan],
//////                                    startPoint: .leading,
//////                                    endPoint: .trailing
//////                                )
//////                            )
//////                            .clipShape(RoundedRectangle(cornerRadius: 14))
//////                            .shadow(color: .blue.opacity(0.3), radius: 10, y: 5)
//////                    }
//////                    .padding(.horizontal, 24)
//////                    .padding(.bottom, 40)
//////                }
//////            }
//////        }
//////        .navigationBarHidden(true)
//////        .navigationBarBackButtonHidden(true)
//////    }
//////}
//////
//////#Preview {
//////    NavigationStack {
//////        OPDRegistrationSuccessView(opdNumber: "OPD-REG-4512")
//////    }
//////}
////
////
//////
//////  OPDRegistrationSuccessView.swift
//////  ClinicApp
//////
//////  Created by BSCComp-046 on 2026-03-13.
//////
////
////import SwiftUI
////
////struct OPDRegistrationSuccessView: View {
////
////    let opdNumber: String
////    @Environment(\.dismiss) private var dismiss
////    @Environment(\.presentationMode) private var presentationMode
////
////    var body: some View {
////        ZStack {
////            Color(.systemGroupedBackground).ignoresSafeArea()
////
////            ScrollView {
////                VStack(spacing: 0) {
////
////                    Spacer().frame(height: 48)
////
////                    // MARK: Success Icon
////                    ZStack {
////                        Circle()
////                            .fill(Color.green)
////                            .frame(width: 88, height: 88)
////                            .shadow(color: .green.opacity(0.3), radius: 12, y: 5)
////
////                        Image(systemName: "checkmark")
////                            .font(.system(size: 38, weight: .semibold))
////                            .foregroundStyle(.white)
////                    }
////                    .padding(.bottom, 24)
////
////                    // MARK: Title
////                    Text("Registration Complete")
////                        .font(.system(size: 26, weight: .bold, design: .rounded))
////                        .foregroundStyle(.primary)
////
////                    Text("Your OPD registration was successful")
////                        .font(.subheadline)
////                        .foregroundStyle(.secondary)
////                        .multilineTextAlignment(.center)
////                        .padding(.top, 8)
////                        .padding(.bottom, 32)
////
////                    // MARK: OPD Number Card
////                    VStack(alignment: .leading, spacing: 16) {
////
////                        // Card header
////                        HStack(spacing: 10) {
////                            ZStack {
////                                RoundedRectangle(cornerRadius: 10)
////                                    .fill(Color.green.opacity(0.15))
////                                    .frame(width: 38, height: 38)
////                                Image(systemName: "doc.text")
////                                    .font(.system(size: 16, weight: .medium))
////                                    .foregroundStyle(.green)
////                            }
////                            Text("Your OPD Registration Number")
////                                .font(.subheadline)
////                                .fontWeight(.semibold)
////                        }
////
////                        // Number display
////                        Text(opdNumber)
////                            .font(.system(size: 26, weight: .bold, design: .monospaced))
////                            .foregroundStyle(.blue)
////                            .frame(maxWidth: .infinity)
////                            .padding(.vertical, 16)
////                            .background(
////                                RoundedRectangle(cornerRadius: 12)
////                                    .fill(Color(.secondarySystemBackground))
////                            )
////
////                        // Warning note
////                        HStack(alignment: .top, spacing: 10) {
////                            Image(systemName: "info.circle.fill")
////                                .foregroundStyle(.orange)
////                                .font(.system(size: 15))
////                                .padding(.top, 1)
////
////                            Text("Keep this OPD registration number safe. You will use it together with your mobile number to log in.")
////                                .font(.footnote)
////                                .foregroundStyle(Color.orange.opacity(0.9))
////                                .fixedSize(horizontal: false, vertical: true)
////                        }
////                        .padding(14)
////                        .background(
////                            RoundedRectangle(cornerRadius: 10)
////                                .fill(Color.orange.opacity(0.08))
////                        )
////                    }
////                    .padding(18)
////                    .background(
////                        RoundedRectangle(cornerRadius: 16)
////                            .fill(Color(.systemBackground))
////                            .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
////                    )
////                    .padding(.horizontal, 24)
////                    .padding(.bottom, 12)
////
////                    // MARK: Lock Note Card
////                    HStack(alignment: .top, spacing: 10) {
////                        Image(systemName: "lock.fill")
////                            .foregroundStyle(.secondary)
////                            .font(.system(size: 14))
////                            .padding(.top, 1)
////
////                        Text("This number is only for logging in to the clinic app.")
////                            .font(.footnote)
////                            .foregroundStyle(.secondary)
////                            .fixedSize(horizontal: false, vertical: true)
////                    }
////                    .frame(maxWidth: .infinity, alignment: .leading)
////                    .padding(14)
////                    .background(
////                        RoundedRectangle(cornerRadius: 12)
////                            .fill(Color(.systemBackground))
////                            .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
////                    )
////                    .padding(.horizontal, 24)
////
////                    Spacer().frame(height: 40)
////
////                    // MARK: Continue to Login Button with Gradient
////                    Button {
////                        // Dismiss all the way back to LoginView
////                        // This will pop to the root of the navigation stack
////                        presentationMode.wrappedValue.dismiss()
////                    } label: {
////                        Text("Continue to Login")
////                            .font(.headline)
////                            .fontWeight(.semibold)
////                            .foregroundStyle(.white)
////                            .frame(maxWidth: .infinity)
////                            .frame(height: 54)
////                            .background(
////                                LinearGradient(
////                                    colors: [.blue, .cyan],
////                                    startPoint: .leading,
////                                    endPoint: .trailing
////                                )
////                            )
////                            .clipShape(RoundedRectangle(cornerRadius: 14))
////                            .shadow(color: .blue.opacity(0.3), radius: 10, y: 5)
////                    }
////                    .padding(.horizontal, 24)
////                    .padding(.bottom, 40)
////                }
////            }
////        }
////        .navigationBarHidden(true)
////        .navigationBarBackButtonHidden(true)
////    }
////}
////
////#Preview {
////    NavigationStack {
////        OPDRegistrationSuccessView(opdNumber: "OPD-REG-4512")
////    }
////}
//
//import SwiftUI
//
//struct OPDRegistrationSuccessView: View {
//
//    let opdNumber: String
//    @Environment(\.dismiss) private var dismiss
//
//    var body: some View {
//        ZStack {
//            Color(.systemGroupedBackground).ignoresSafeArea()
//
//            ScrollView {
//                VStack(spacing: 0) {
//
//                    Spacer().frame(height: 48)
//
//                    // MARK: Success Icon
//                    ZStack {
//                        Circle()
//                            .fill(Color.green)
//                            .frame(width: 88, height: 88)
//                            .shadow(color: .green.opacity(0.3), radius: 12, y: 5)
//
//                        Image(systemName: "checkmark")
//                            .font(.system(size: 38, weight: .semibold))
//                            .foregroundStyle(.white)
//                    }
//                    .padding(.bottom, 24)
//
//                    // MARK: Title
//                    Text("Registration Complete")
//                        .font(.system(size: 26, weight: .bold, design: .rounded))
//                        .foregroundStyle(.primary)
//
//                    Text("Your OPD registration was successful")
//                        .font(.subheadline)
//                        .foregroundStyle(.secondary)
//                        .multilineTextAlignment(.center)
//                        .padding(.top, 8)
//                        .padding(.bottom, 32)
//
//                    // MARK: OPD Number Card
//                    VStack(alignment: .leading, spacing: 16) {
//
//                        // Card header
//                        HStack(spacing: 10) {
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 10)
//                                    .fill(Color.green.opacity(0.15))
//                                    .frame(width: 38, height: 38)
//                                Image(systemName: "doc.text")
//                                    .font(.system(size: 16, weight: .medium))
//                                    .foregroundStyle(.green)
//                            }
//                            Text("Your OPD Registration Number")
//                                .font(.subheadline)
//                                .fontWeight(.semibold)
//                        }
//
//                        // Number display
//                        Text(opdNumber)
//                            .font(.system(size: 26, weight: .bold, design: .monospaced))
//                            .foregroundStyle(.blue)
//                            .frame(maxWidth: .infinity)
//                            .padding(.vertical, 16)
//                            .background(
//                                RoundedRectangle(cornerRadius: 12)
//                                    .fill(Color(.secondarySystemBackground))
//                            )
//
//                        // Warning note
//                        HStack(alignment: .top, spacing: 10) {
//                            Image(systemName: "info.circle.fill")
//                                .foregroundStyle(.orange)
//                                .font(.system(size: 15))
//                                .padding(.top, 1)
//
//                            Text("Keep this OPD registration number safe. You will use it together with your mobile number to log in.")
//                                .font(.footnote)
//                                .foregroundStyle(Color.orange.opacity(0.9))
//                                .fixedSize(horizontal: false, vertical: true)
//                        }
//                        .padding(14)
//                        .background(
//                            RoundedRectangle(cornerRadius: 10)
//                                .fill(Color.orange.opacity(0.08))
//                        )
//                    }
//                    .padding(18)
//                    .background(
//                        RoundedRectangle(cornerRadius: 16)
//                            .fill(Color(.systemBackground))
//                            .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
//                    )
//                    .padding(.horizontal, 24)
//                    .padding(.bottom, 12)
//
//                    // MARK: Lock Note Card
//                    HStack(alignment: .top, spacing: 10) {
//                        Image(systemName: "lock.fill")
//                            .foregroundStyle(.secondary)
//                            .font(.system(size: 14))
//                            .padding(.top, 1)
//
//                        Text("This number is only for logging in to the clinic app.")
//                            .font(.footnote)
//                            .foregroundStyle(.secondary)
//                            .fixedSize(horizontal: false, vertical: true)
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(14)
//                    .background(
//                        RoundedRectangle(cornerRadius: 12)
//                            .fill(Color(.systemBackground))
//                            .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
//                    )
//                    .padding(.horizontal, 24)
//
//                    Spacer().frame(height: 40)
//
//                    // MARK: Continue to Login Button with Gradient
//                    Button {
//                        // Dismiss all the way back to LoginView
//                        // This will pop to the root of the navigation stack
//                        dismiss()
//                    } label: {
//                        Text("Continue to Login")
//                            .font(.headline)
//                            .fontWeight(.semibold)
//                            .foregroundStyle(.white)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 54)
//                            .background(
//                                LinearGradient(
//                                    colors: [.blue, .cyan],
//                                    startPoint: .leading,
//                                    endPoint: .trailing
//                                )
//                            )
//                            .clipShape(RoundedRectangle(cornerRadius: 14))
//                            .shadow(color: .blue.opacity(0.3), radius: 10, y: 5)
//                    }
//                    .padding(.horizontal, 24)
//                    .padding(.bottom, 40)
//                }
//            }
//        }
//        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
//#Preview {
//    NavigationStack {
//        OPDRegistrationSuccessView(opdNumber: "OPD-REG-4512")
//    }
////}
//
////
//import SwiftUI
//
//struct OPDRegistrationSuccessView: View {
//    let opdNumber: String
//    @EnvironmentObject private var navigationState: NavigationState
//    @Environment(\.dismiss) private var dismiss
//
//    var body: some View {
//        ZStack {
//            Color(.systemGroupedBackground).ignoresSafeArea()
//
//            ScrollView {
//                VStack(spacing: 0) {
//
//                    Spacer().frame(height: 48)
//
//                    // MARK: Success Icon
//                    ZStack {
//                        Circle()
//                            .fill(Color.green)
//                            .frame(width: 88, height: 88)
//                            .shadow(color: .green.opacity(0.3), radius: 12, y: 5)
//
//                        Image(systemName: "checkmark")
//                            .font(.system(size: 38, weight: .semibold))
//                            .foregroundStyle(.white)
//                    }
//                    .padding(.bottom, 24)
//
//                    // MARK: Title
//                    Text("Registration Complete")
//                        .font(.system(size: 26, weight: .bold, design: .rounded))
//                        .foregroundStyle(.primary)
//
//                    Text("Your OPD registration was successful")
//                        .font(.subheadline)
//                        .foregroundStyle(.secondary)
//                        .multilineTextAlignment(.center)
//                        .padding(.top, 8)
//                        .padding(.bottom, 32)
//
//                    // MARK: OPD Number Card
//                    VStack(alignment: .leading, spacing: 16) {
//
//                        // Card header
//                        HStack(spacing: 10) {
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 10)
//                                    .fill(Color.green.opacity(0.15))
//                                    .frame(width: 38, height: 38)
//                                Image(systemName: "doc.text")
//                                    .font(.system(size: 16, weight: .medium))
//                                    .foregroundStyle(.green)
//                            }
//                            Text("Your OPD Registration Number")
//                                .font(.subheadline)
//                                .fontWeight(.semibold)
//                        }
//
//                        // Number display
//                        Text(opdNumber)
//                            .font(.system(size: 26, weight: .bold, design: .monospaced))
//                            .foregroundStyle(.blue)
//                            .frame(maxWidth: .infinity)
//                            .padding(.vertical, 16)
//                            .background(
//                                RoundedRectangle(cornerRadius: 12)
//                                    .fill(Color(.secondarySystemBackground))
//                            )
//
//                        // Warning note
//                        HStack(alignment: .top, spacing: 10) {
//                            Image(systemName: "info.circle.fill")
//                                .foregroundStyle(.orange)
//                                .font(.system(size: 15))
//                                .padding(.top, 1)
//
//                            Text("Keep this OPD registration number safe. You will use it together with your mobile number to log in.")
//                                .font(.footnote)
//                                .foregroundStyle(Color.orange.opacity(0.9))
//                                .fixedSize(horizontal: false, vertical: true)
//                        }
//                        .padding(14)
//                        .background(
//                            RoundedRectangle(cornerRadius: 10)
//                                .fill(Color.orange.opacity(0.08))
//                        )
//                    }
//                    .padding(18)
//                    .background(
//                        RoundedRectangle(cornerRadius: 16)
//                            .fill(Color(.systemBackground))
//                            .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
//                    )
//                    .padding(.horizontal, 24)
//                    .padding(.bottom, 12)
//
//                    // MARK: Lock Note Card
//                    HStack(alignment: .top, spacing: 10) {
//                        Image(systemName: "lock.fill")
//                            .foregroundStyle(.secondary)
//                            .font(.system(size: 14))
//                            .padding(.top, 1)
//
//                        Text("This number is only for logging in to the clinic app.")
//                            .font(.footnote)
//                            .foregroundStyle(.secondary)
//                            .fixedSize(horizontal: false, vertical: true)
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(14)
//                    .background(
//                        RoundedRectangle(cornerRadius: 12)
//                            .fill(Color(.systemBackground))
//                            .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
//                    )
//                    .padding(.horizontal, 24)
//
//                    Spacer().frame(height: 40)
//
//                    // MARK: Continue to Login Button with Gradient
//                    Button {
//                        // Navigate back to login by popping to root
//                        navigationState.popToRoot()
//                    } label: {
//                        Text("Continue to Login")
//                            .font(.headline)
//                            .fontWeight(.semibold)
//                            .foregroundStyle(.white)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 54)
//                            .background(
//                                LinearGradient(
//                                    colors: [.blue, .cyan],
//                                    startPoint: .leading,
//                                    endPoint: .trailing
//                                )
//                            )
//                            .clipShape(RoundedRectangle(cornerRadius: 14))
//                            .shadow(color: .blue.opacity(0.3), radius: 10, y: 5)
//                    }
//                    .padding(.horizontal, 24)
//                    .padding(.bottom, 40)
//                }
//            }
//        }
//        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
//#Preview {
//    NavigationStack {
//        OPDRegistrationSuccessView(opdNumber: "OPD-REG-4512")
//            .environmentObject(NavigationState())
//    }
//}
//
//
//
//import SwiftUI
//
//struct OPDRegistrationSuccessView: View {
//    
//    let opdNumber: String
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//        ZStack {
//            Color(.systemGroupedBackground).ignoresSafeArea()
//
//            ScrollView {
//                VStack(spacing: 0) {
//
//                    Spacer().frame(height: 48)
//
//                    // MARK: Success Icon
//                    ZStack {
//                        Circle()
//                            .fill(Color.green)
//                            .frame(width: 88, height: 88)
//                            .shadow(color: .green.opacity(0.3), radius: 12, y: 5)
//
//                        Image(systemName: "checkmark")
//                            .font(.system(size: 38, weight: .semibold))
//                            .foregroundStyle(.white)
//                    }
//                    .padding(.bottom, 24)
//
//                    // MARK: Title
//                    Text("Registration Complete")
//                        .font(.system(size: 26, weight: .bold, design: .rounded))
//                        .foregroundStyle(.primary)
//
//                    Text("Your OPD registration was successful")
//                        .font(.subheadline)
//                        .foregroundStyle(.secondary)
//                        .multilineTextAlignment(.center)
//                        .padding(.top, 8)
//                        .padding(.bottom, 32)
//
//                    // MARK: OPD Number Card
//                    VStack(alignment: .leading, spacing: 16) {
//
//                        HStack(spacing: 10) {
//                            ZStack {
//                                RoundedRectangle(cornerRadius: 10)
//                                    .fill(Color.green.opacity(0.15))
//                                    .frame(width: 38, height: 38)
//
//                                Image(systemName: "doc.text")
//                                    .font(.system(size: 16, weight: .medium))
//                                    .foregroundStyle(.green)
//                            }
//
//                            Text("Your OPD Registration Number")
//                                .font(.subheadline)
//                                .fontWeight(.semibold)
//                        }
//
//                        Text(opdNumber)
//                            .font(.system(size: 26, weight: .bold, design: .monospaced))
//                            .foregroundStyle(.blue)
//                            .frame(maxWidth: .infinity)
//                            .padding(.vertical, 16)
//                            .background(
//                                RoundedRectangle(cornerRadius: 12)
//                                    .fill(Color(.secondarySystemBackground))
//                            )
//
//                        HStack(alignment: .top, spacing: 10) {
//                            Image(systemName: "info.circle.fill")
//                                .foregroundStyle(.orange)
//
//                            Text("Keep this OPD registration number safe. You will use it together with your mobile number to log in.")
//                                .font(.footnote)
//                                .foregroundStyle(.orange)
//                        }
//                        .padding(14)
//                        .background(
//                            RoundedRectangle(cornerRadius: 10)
//                                .fill(Color.orange.opacity(0.08))
//                        )
//                    }
//                    .padding(18)
//                    .background(
//                        RoundedRectangle(cornerRadius: 16)
//                            .fill(Color(.systemBackground))
//                            .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
//                    )
//                    .padding(.horizontal, 24)
//
//                    Spacer().frame(height: 40)
//
//                    // MARK: Continue Button
//                    Button {
//                        dismiss()
//                    } label: {
//                        Text("Continue to Login")
//                            .font(.headline)
//                            .foregroundStyle(.white)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 54)
//                            .background(
//                                LinearGradient(
//                                    colors: [.blue, .cyan],
//                                    startPoint: .leading,
//                                    endPoint: .trailing
//                                )
//                            )
//                            .clipShape(RoundedRectangle(cornerRadius: 14))
//                    }
//                    .padding(.horizontal, 24)
//                    .padding(.bottom, 40)
//
//                }
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//        .navigationBarHidden(true)
//    }
//}
//
//#Preview {
//    NavigationStack {
//        OPDRegistrationSuccessView(opdNumber: "OPD-REG-4512")
//    }
//}


import SwiftUI

struct OPDRegistrationSuccessView: View {
    
    let opdNumber: String
    var goToLanding: () -> Void   // Closure to navigate to landing
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {

                    Spacer().frame(height: 48)

                    // MARK: Success Icon
                    ZStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 88, height: 88)
                            .shadow(color: .green.opacity(0.3), radius: 12, y: 5)

                        Image(systemName: "checkmark")
                            .font(.system(size: 38, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    .padding(.bottom, 24)

                    // MARK: Title
                    Text("Registration Complete")
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                        .foregroundStyle(.primary)

                    Text("Your OPD registration was successful")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                        .padding(.bottom, 32)

                    // MARK: OPD Number Card
                    VStack(alignment: .leading, spacing: 16) {

                        HStack(spacing: 10) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.green.opacity(0.15))
                                    .frame(width: 38, height: 38)

                                Image(systemName: "doc.text")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.green)
                            }

                            Text("Your OPD Registration Number")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }

                        Text(opdNumber)
                            .font(.system(size: 26, weight: .bold, design: .monospaced))
                            .foregroundStyle(.blue)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.secondarySystemBackground))
                            )

                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "info.circle.fill")
                                .foregroundStyle(.orange)

                            Text("Keep this OPD registration number safe. You will use it together with your mobile number to log in.")
                                .font(.footnote)
                                .foregroundStyle(.orange)
                        }
                        .padding(14)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.orange.opacity(0.08))
                        )
                    }
                    .padding(18)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
                    )
                    .padding(.horizontal, 24)

                    Spacer().frame(height: 40)

                    // MARK: Continue Button → Go to Landing UI
                    Button {
                        goToLanding()  // Trigger closure to show LandingUIScreen
                    } label: {
                        Text("Continue to App")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54)
                            .background(
                                LinearGradient(
                                    colors: [.blue, .cyan],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)

                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}
