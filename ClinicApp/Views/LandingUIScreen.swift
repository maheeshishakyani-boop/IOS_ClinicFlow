//////////
//////////  LandingUIScreen.swift
//////////  ClinicApp
//////////
//////////  Created by BSCComp-046 on 2026-03-13.
//////////
////////
////////import SwiftUI
////////
////////struct LandingUIScreen: View {
////////    @State private var navigateToLogin  = false
////////    @State private var logoAppeared     = false
////////    @State private var titleAppeared    = false
////////    @State private var cardsAppeared    = false
////////    @State private var buttonAppeared   = false
////////
////////    var body: some View {
////////        NavigationStack {
////////            ZStack {
////////                // ── Background ──────────────────────────────────────────
////////                backgroundLayer
////////
////////                // ── Content ─────────────────────────────────────────────
////////                VStack(spacing: 0) {
////////                    Spacer()
////////
////////                    // Logo
////////                    logoSection
////////                        .opacity(logoAppeared ? 1 : 0)
////////                        .offset(y: logoAppeared ? 0 : 24)
////////
////////                    Spacer().frame(height: 36)
////////
////////                    // Headline + subtitle
////////                    headlineSection
////////                        .opacity(titleAppeared ? 1 : 0)
////////                        .offset(y: titleAppeared ? 0 : 20)
////////
////////                    Spacer().frame(height: 44)
////////
////////                    // Feature pills
////////                    featurePills
////////                        .opacity(cardsAppeared ? 1 : 0)
////////                        .offset(y: cardsAppeared ? 0 : 16)
////////
////////                    Spacer()
////////
////////                    // Bottom CTA
////////                    bottomSection
////////                        .opacity(buttonAppeared ? 1 : 0)
////////                        .offset(y: buttonAppeared ? 0 : 16)
////////                }
////////                .padding(.horizontal, 28)
////////                .padding(.bottom, 52)
////////            }
////////            .ignoresSafeArea()
////////            .navigationBarHidden(true)
////////            .navigationDestination(isPresented: $navigateToLogin) {
////////                LoginView()
////////            }
////////            .onAppear { runEntrance() }
////////        }
////////    }
////////
////////    // MARK: - Background
////////    private var backgroundLayer: some View {
////////        ZStack {
////////            // Deep gradient base
////////            LinearGradient(
////////                colors: [
////////                    Color(red: 0.04, green: 0.09, blue: 0.22),
////////                    Color(red: 0.06, green: 0.14, blue: 0.34),
////////                    Color(red: 0.08, green: 0.20, blue: 0.48)
////////                ],
////////                startPoint: .topLeading,
////////                endPoint: .bottomTrailing
////////            )
////////
////////            // Glowing orb — top right
////////            Circle()
////////                .fill(
////////                    RadialGradient(
////////                        colors: [
////////                            Color(red: 0.20, green: 0.50, blue: 1.0).opacity(0.45),
////////                            Color.clear
////////                        ],
////////                        center: .center,
////////                        startRadius: 0,
////////                        endRadius: 220
////////                    )
////////                )
////////                .frame(width: 440, height: 440)
////////                .offset(x: 140, y: -180)
////////                .blur(radius: 8)
////////
////////            // Glowing orb — bottom left
////////            Circle()
////////                .fill(
////////                    RadialGradient(
////////                        colors: [
////////                            Color(red: 0.10, green: 0.70, blue: 0.95).opacity(0.30),
////////                            Color.clear
////////                        ],
////////                        center: .center,
////////                        startRadius: 0,
////////                        endRadius: 180
////////                    )
////////                )
////////                .frame(width: 360, height: 360)
////////                .offset(x: -120, y: 260)
////////                .blur(radius: 6)
////////
////////            // Subtle grid lines
////////            gridOverlay
////////                .opacity(0.06)
////////
////////            // Glass card blur backdrop at bottom
////////            VStack {
////////                Spacer()
////////                Rectangle()
////////                    .fill(
////////                        LinearGradient(
////////                            colors: [Color.clear, Color(red: 0.04, green: 0.09, blue: 0.22).opacity(0.85)],
////////                            startPoint: .top,
////////                            endPoint: .bottom
////////                        )
////////                    )
////////                    .frame(height: 280)
////////            }
////////        }
////////    }
////////
////////    private var gridOverlay: some View {
////////        GeometryReader { geo in
////////            let w = geo.size.width
////////            let h = geo.size.height
////////            let spacing: CGFloat = 44
////////            Canvas { ctx, size in
////////                var p = Path()
////////                var x: CGFloat = 0
////////                while x <= w {
////////                    p.move(to: CGPoint(x: x, y: 0))
////////                    p.addLine(to: CGPoint(x: x, y: h))
////////                    x += spacing
////////                }
////////                var y: CGFloat = 0
////////                while y <= h {
////////                    p.move(to: CGPoint(x: 0, y: y))
////////                    p.addLine(to: CGPoint(x: w, y: y))
////////                    y += spacing
////////                }
////////                ctx.stroke(p, with: .color(.white), lineWidth: 0.5)
////////            }
////////        }
////////    }
////////
////////    // MARK: - Logo
////////    private var logoSection: some View {
////////        VStack(spacing: 0) {
////////            ZStack {
////////                // Outer glow ring
////////                Circle()
////////                    .fill(Color.white.opacity(0.08))
////////                    .frame(width: 116, height: 116)
////////
////////                Circle()
////////                    .fill(Color.white.opacity(0.12))
////////                    .frame(width: 100, height: 100)
////////
////////                // Logo
////////                Image("logo")
////////                    .resizable()
////////                    .scaledToFit()
////////                    .frame(width: 80, height: 80)
////////                    .clipShape(RoundedRectangle(cornerRadius: 22))
////////                    .shadow(color: Color.blue.opacity(0.5), radius: 20, y: 6)
////////            }
////////        }
////////    }
////////
////////    // MARK: - Headline
////////    private var headlineSection: some View {
////////        VStack(spacing: 12) {
////////            Text("Your Health,\nSimplified.")
////////                .font(.system(size: 40, weight: .bold, design: .rounded))
////////                .foregroundStyle(.white)
////////                .multilineTextAlignment(.center)
////////                .lineSpacing(2)
////////
////////            Text("Skip the queues. Track your visit.\nNavigate the hospital with ease.")
////////                .font(.system(size: 16, weight: .regular, design: .rounded))
////////                .foregroundStyle(Color.white.opacity(0.65))
////////                .multilineTextAlignment(.center)
////////                .lineSpacing(4)
////////        }
////////    }
////////
////////    // MARK: - Feature Pills
////////    private var featurePills: some View {
////////        VStack(spacing: 12) {
////////            HStack(spacing: 12) {
////////                featurePill(icon: "person.3.sequence.fill", label: "Live Queue",   color: Color(red: 0.20, green: 0.55, blue: 1.0))
////////                featurePill(icon: "stethoscope",            label: "Visit Tracker", color: Color(red: 0.10, green: 0.75, blue: 0.60))
////////            }
////////            HStack(spacing: 12) {
////////                featurePill(icon: "map.fill",               label: "Navigation",   color: Color(red: 1.0,  green: 0.55, blue: 0.15))
////////                featurePill(icon: "book.closed.fill",       label: "Clinic Book",  color: Color(red: 0.70, green: 0.30, blue: 1.0))
////////            }
////////        }
////////    }
////////
////////    private func featurePill(icon: String, label: String, color: Color) -> some View {
////////        HStack(spacing: 10) {
////////            ZStack {
////////                RoundedRectangle(cornerRadius: 9)
////////                    .fill(color.opacity(0.20))
////////                    .frame(width: 34, height: 34)
////////                Image(systemName: icon)
////////                    .font(.system(size: 14, weight: .medium))
////////                    .foregroundStyle(color)
////////            }
////////            Text(label)
////////                .font(.system(size: 14, weight: .semibold, design: .rounded))
////////                .foregroundStyle(Color.white.opacity(0.90))
////////            Spacer()
////////        }
////////        .padding(.horizontal, 14)
////////        .padding(.vertical, 12)
////////        .frame(maxWidth: .infinity)
////////        .background(
////////            RoundedRectangle(cornerRadius: 14)
////////                .fill(Color.white.opacity(0.08))
////////                .overlay(
////////                    RoundedRectangle(cornerRadius: 14)
////////                        .stroke(Color.white.opacity(0.12), lineWidth: 1)
////////                )
////////        )
////////    }
////////
////////    // MARK: - Bottom CTA
////////    private var bottomSection: some View {
////////        VStack(spacing: 20) {
////////            // Get Started button
////////            Button {
////////                navigateToLogin = true
////////            } label: {
////////                HStack(spacing: 10) {
////////                    Text("Get Started")
////////                        .font(.system(size: 17, weight: .bold, design: .rounded))
////////                        .foregroundStyle(Color(red: 0.04, green: 0.09, blue: 0.22))
////////                    Image(systemName: "arrow.right")
////////                        .font(.system(size: 15, weight: .bold))
////////                        .foregroundStyle(Color(red: 0.04, green: 0.09, blue: 0.22))
////////                }
////////                .frame(maxWidth: .infinity)
////////                .frame(height: 56)
////////                .background(
////////                    RoundedRectangle(cornerRadius: 16)
////////                        .fill(Color.white)
////////                        .shadow(color: Color.white.opacity(0.20), radius: 20, y: 8)
////////                )
////////            }
////////            .buttonStyle(.plain)
////////
////////            // Already have account
////////            Button {
////////                navigateToLogin = true
////////            } label: {
////////                Text("Already have an account? ")
////////                    .foregroundStyle(Color.white.opacity(0.50))
////////                + Text("Sign In")
////////                    .foregroundStyle(Color.white.opacity(0.90))
////////                    .bold()
////////            }
////////            .font(.system(size: 14, weight: .regular, design: .rounded))
////////        }
////////    }
////////
////////    // MARK: - Entrance Animation
////////    private func runEntrance() {
////////        withAnimation(.spring(response: 0.7, dampingFraction: 0.8).delay(0.1)) {
////////            logoAppeared = true
////////        }
////////        withAnimation(.spring(response: 0.7, dampingFraction: 0.8).delay(0.3)) {
////////            titleAppeared = true
////////        }
////////        withAnimation(.spring(response: 0.7, dampingFraction: 0.8).delay(0.5)) {
////////            cardsAppeared = true
////////        }
////////        withAnimation(.spring(response: 0.7, dampingFraction: 0.8).delay(0.65)) {
////////            buttonAppeared = true
////////        }
////////    }
////////}
////////
////////#Preview {
////////    LandingUIScreen()
////////}
//////
//////
//////import SwiftUI
//////
//////struct LandingUIScreen: View {
//////    @State private var navigateToLogin = false
//////
//////    var body: some View {
//////        NavigationStack {
//////            VStack(spacing: 0) {
//////                Spacer()
//////
//////                // Logo
//////                Image("logo")
//////                    .resizable()
//////                    .scaledToFit()
//////                    .frame(width: 100, height: 100)
//////                    .clipShape(RoundedRectangle(cornerRadius: 24))
//////                    .shadow(color: .black.opacity(0.10), radius: 16, y: 6)
//////
//////                Spacer().frame(height: 28)
//////
//////                // App Name
//////                Text("Clinic Flow")
//////                    .font(.system(size: 32, weight: .bold, design: .rounded))
//////                    .foregroundStyle(.primary)
//////
//////                Spacer().frame(height: 10)
//////
//////                // Tagline
//////                Text("Making your Clinic Visit Simple")
//////                    .font(.system(size: 16, weight: .regular, design: .rounded))
//////                    .foregroundStyle(.secondary)
//////                    .multilineTextAlignment(.center)
//////
//////                Spacer()
//////
//////                // Get Started Button
//////                Button {
//////                    navigateToLogin = true
//////                } label: {
//////                    Text("Get Started")
//////                        .font(.system(size: 17, weight: .semibold, design: .rounded))
//////                        .foregroundStyle(.white)
//////                        .frame(maxWidth: .infinity)
//////                        .frame(height: 54)
//////                        .background(
//////                            RoundedRectangle(cornerRadius: 16)
//////                                .fill(Color.blue)
//////                                .shadow(color: .blue.opacity(0.30), radius: 12, y: 5)
//////                        )
//////                }
//////                .buttonStyle(.plain)
//////                .padding(.horizontal, 28)
//////                .padding(.bottom, 16)
//////
//////                // Sign In link
//////                Button {
//////                    navigateToLogin = true
//////                } label: {
//////                    HStack(spacing: 4) {
//////                        Text("Already have an account?")
//////                            .foregroundStyle(.secondary)
//////                        Text("Sign In")
//////                            .foregroundStyle(.blue)
//////                            .fontWeight(.semibold)
//////                    }
//////                    .font(.subheadline)
//////                }
//////                .padding(.bottom, 52)
//////            }
//////            .background(Color(.systemGroupedBackground).ignoresSafeArea())
//////            .navigationBarHidden(true)
//////            .navigationDestination(isPresented: $navigateToLogin) {
//////                LoginView()
//////            }
//////        }
//////    }
//////}
//////
//////#Preview {
//////    LandingUIScreen()
//////}
////
////
////import SwiftUI
////
////struct LandingUIScreen: View {
////    @State private var navigateToLogin = false
////
////    var body: some View {
////        NavigationStack {
////            ZStack {
////                // Background
////                Color(.systemBackground).ignoresSafeArea()
////
////                VStack(spacing: 0) {
////
////                    Spacer()
////
////                    // ── Logo + Branding ──────────────────────────────────
////                    VStack(spacing: 20) {
////                        Image("logo")
////                            .resizable()
////                            .scaledToFit()
////                            .frame(width: 96, height: 96)
////                            .clipShape(RoundedRectangle(cornerRadius: 26))
////                            .shadow(color: Color(.systemBlue).opacity(0.18), radius: 24, y: 8)
////
////                        VStack(spacing: 8) {
////                            Text("Clinic Flow")
////                                .font(.system(size: 34, weight: .bold, design: .rounded))
////                                .foregroundStyle(Color(.label))
////
////                            Text("Making your Clinic Visit Simple")
////                                .font(.system(size: 15, weight: .regular))
////                                .foregroundStyle(Color(.secondaryLabel))
////                                .multilineTextAlignment(.center)
////                        }
////                    }
////
////                    Spacer().frame(height: 56)
////
////                    // ── Feature Highlights ───────────────────────────────
////                    VStack(spacing: 12) {
////                        featureRow(icon: "person.3.sequence.fill",
////                                   color: Color(.systemBlue),
////                                   title: "Live Queue Tracking",
////                                   subtitle: "Know your position in real time")
////
////                        featureRow(icon: "stethoscope",
////                                   color: Color(.systemGreen),
////                                   title: "Visit Progress",
////                                   subtitle: "Follow every step of your visit")
////
////                        featureRow(icon: "map.fill",
////                                   color: Color(.systemOrange),
////                                   title: "Hospital Navigation",
////                                   subtitle: "Find your way around with ease")
////                    }
////                    .padding(.horizontal, 24)
////
////                    Spacer()
////
////                    // ── Get Started Button ───────────────────────────────
////                    Button {
////                        navigateToLogin = true
////                    } label: {
////                        Text("Get Started")
////                            .font(.system(size: 17, weight: .semibold))
////                            .foregroundStyle(.white)
////                            .frame(maxWidth: .infinity)
////                            .frame(height: 54)
////                            .background(
////                                RoundedRectangle(cornerRadius: 16)
////                                    .fill(Color(.systemBlue))
////                                    .shadow(color: Color(.systemBlue).opacity(0.28), radius: 14, y: 6)
////                            )
////                    }
////                    .buttonStyle(.plain)
////                    .padding(.horizontal, 24)
////                    .padding(.bottom, 48)
////                }
////            }
////            .navigationBarHidden(true)
////            .navigationDestination(isPresented: $navigateToLogin) {
////                LoginView()
////            }
////        }
////    }
////
////    // MARK: - Feature Row
////    private func featureRow(icon: String, color: Color, title: String, subtitle: String) -> some View {
////        HStack(spacing: 16) {
////            ZStack {
////                RoundedRectangle(cornerRadius: 12)
////                    .fill(color.opacity(0.12))
////                    .frame(width: 48, height: 48)
////                Image(systemName: icon)
////                    .font(.system(size: 20, weight: .medium))
////                    .foregroundStyle(color)
////            }
////
////            VStack(alignment: .leading, spacing: 3) {
////                Text(title)
////                    .font(.system(size: 15, weight: .semibold))
////                    .foregroundStyle(Color(.label))
////                Text(subtitle)
////                    .font(.system(size: 13, weight: .regular))
////                    .foregroundStyle(Color(.secondaryLabel))
////            }
////
////            Spacer()
////        }
////        .padding(.horizontal, 16)
////        .padding(.vertical, 14)
////        .background(
////            RoundedRectangle(cornerRadius: 16)
////                .fill(Color(.secondarySystemBackground))
////        )
////    }
////}
////
////#Preview {
////    LandingUIScreen()
////}
//
//
//import SwiftUI
//
//struct LandingUIScreen: View {
//    @State private var navigateToLogin = false
//    @State private var animateFeatures = false
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                // ── Gradient Background ─────────────────────────────
//                LinearGradient(
//                    colors: [Color("GradientStart"), Color("GradientEnd")],
//                    startPoint: .topLeading,
//                    endPoint: .bottomTrailing
//                )
//                .ignoresSafeArea()
//
//                VStack(spacing: 0) {
//                    Spacer()
//
//                    // ── Logo + Branding ───────────────────────────────
//                    VStack(spacing: 20) {
//                        Image("logo")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 96, height: 96)
//                            .clipShape(RoundedRectangle(cornerRadius: 26))
//                            .shadow(color: Color(.systemBlue).opacity(0.18), radius: 24, y: 8)
//                            .accessibilityLabel("Clinic Flow Logo")
//
//                        VStack(spacing: 8) {
//                            Text("Clinic Flow")
//                                .font(.system(size: 34, weight: .bold, design: .rounded))
//                                .foregroundStyle(Color(.label))
//
//                            Text("Making your Clinic Visit Simple")
//                                .font(.system(size: 15, weight: .regular))
//                                .foregroundStyle(Color(.secondaryLabel))
//                                .multilineTextAlignment(.center)
//                        }
//                    }
//
//                    Spacer().frame(height: 48)
//
//                    // ── Feature Highlights ─────────────────────────────
//                    VStack(spacing: 12) {
//                        featureRow(icon: "person.3.sequence.fill",
//                                   color: Color(.systemBlue),
//                                   title: "Live Queue Tracking",
//                                   subtitle: "Know your position in real time")
//                            .opacity(animateFeatures ? 1 : 0)
//                            .offset(y: animateFeatures ? 0 : 20)
//                            .animation(.easeOut.delay(0.1), value: animateFeatures)
//
//                        featureRow(icon: "stethoscope",
//                                   color: Color(.systemGreen),
//                                   title: "Visit Progress",
//                                   subtitle: "Follow every step of your visit")
//                            .opacity(animateFeatures ? 1 : 0)
//                            .offset(y: animateFeatures ? 0 : 20)
//                            .animation(.easeOut.delay(0.2), value: animateFeatures)
//
//                        featureRow(icon: "map.fill",
//                                   color: Color(.systemOrange),
//                                   title: "Hospital Navigation",
//                                   subtitle: "Find your way around with ease")
//                            .opacity(animateFeatures ? 1 : 0)
//                            .offset(y: animateFeatures ? 0 : 20)
//                            .animation(.easeOut.delay(0.3), value: animateFeatures)
//                    }
//                    .padding(.horizontal, 24)
//
//                    Spacer()
//
//                    // ── Get Started Button ─────────────────────────────
//                    Button {
//                        navigateToLogin = true
//                    } label: {
//                        Text("Get Started")
//                            .font(.system(size: 17, weight: .semibold))
//                            .foregroundStyle(.white)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 54)
//                            .background(
//                                RoundedRectangle(cornerRadius: 16)
//                                    .fill(Color(.systemBlue))
//                                    .shadow(color: Color(.systemBlue).opacity(0.28), radius: 14, y: 6)
//                            )
//                    }
//                    .buttonStyle(.plain)
//                    .padding(.horizontal, 24)
//                    .padding(.bottom, 48)
//                    .accessibilityLabel("Get Started Button")
//
//                }
//                .frame(maxWidth: 600) // Adaptive width for iPad
//            }
//            .navigationBarHidden(true)
//            .navigationDestination(isPresented: $navigateToLogin) {
//                LoginView()
//            }
//            .onAppear {
//                animateFeatures = true
//            }
//        }
//    }
//
//    // MARK: - Feature Row
//    private func featureRow(icon: String, color: Color, title: String, subtitle: String) -> some View {
//        HStack(spacing: 16) {
//            ZStack {
//                RoundedRectangle(cornerRadius: 12)
//                    .fill(color.opacity(0.12))
//                    .frame(width: 48, height: 48)
//                Image(systemName: icon)
//                    .font(.system(size: 20, weight: .medium))
//                    .foregroundStyle(color)
//            }
//
//            VStack(alignment: .leading, spacing: 3) {
//                Text(title)
//                    .font(.system(size: 15, weight: .semibold))
//                    .foregroundStyle(Color(.label))
//                Text(subtitle)
//                    .font(.system(size: 13, weight: .regular))
//                    .foregroundStyle(Color(.secondaryLabel))
//            }
//
//            Spacer()
//        }
//        .padding(.horizontal, 16)
//        .padding(.vertical, 14)
//        .background(
//            RoundedRectangle(cornerRadius: 16)
//                .fill(Color(.secondarySystemBackground))
//        )
//    }
//}
//
//// MARK: - Preview
//struct LandingUIScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        LandingUIScreen()
//    }
//}


import SwiftUI

struct LandingUIScreen: View {
    @State private var navigateToLogin = false
    @State private var animateFeatures = false

    var body: some View {
        NavigationStack {
            ZStack {
                // ── Gradient Background ─────────────────────────────
                LinearGradient(
                    colors: [Color("GradientStart"), Color("GradientEnd")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer()

                    // ── Logo + Branding ───────────────────────────────
                    VStack(spacing: 20) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 96, height: 96)
                            .clipShape(RoundedRectangle(cornerRadius: 26))
                            .shadow(color: Color(.systemBlue).opacity(0.18), radius: 24, y: 8)
                            .accessibilityLabel("Clinic Flow Logo")

                        VStack(spacing: 8) {
                            Text("Clinic Flow")
                                .font(.system(size: 34, weight: .bold, design: .rounded))
                                .foregroundStyle(Color(.label))

                            Text("Making your Clinic Visit Simple")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundStyle(Color(.secondaryLabel))
                                .multilineTextAlignment(.center)
                        }
                    }

                    Spacer().frame(height: 48)

                    // ── Feature Highlights ─────────────────────────────
                    VStack(spacing: 12) {
                        featureRow(icon: "person.3.sequence.fill",
                                   color: Color(.systemBlue),
                                   title: "Live Queue Tracking",
                                   subtitle: "Know your position in real time")
                            .opacity(animateFeatures ? 1 : 0)
                            .offset(y: animateFeatures ? 0 : 20)
                            .animation(.easeOut.delay(0.1), value: animateFeatures)

                        featureRow(icon: "stethoscope",
                                   color: Color(.systemGreen),
                                   title: "Visit Progress",
                                   subtitle: "Follow every step of your visit")
                            .opacity(animateFeatures ? 1 : 0)
                            .offset(y: animateFeatures ? 0 : 20)
                            .animation(.easeOut.delay(0.2), value: animateFeatures)

                        featureRow(icon: "map.fill",
                                   color: Color(.systemOrange),
                                   title: "Hospital Navigation",
                                   subtitle: "Find your way around with ease")
                            .opacity(animateFeatures ? 1 : 0)
                            .offset(y: animateFeatures ? 0 : 20)
                            .animation(.easeOut.delay(0.3), value: animateFeatures)
                    }
                    .padding(.horizontal, 24)

                    Spacer()

                    // ── Get Started Button with Gradient ─────────────
                    Button {
                        navigateToLogin = true
                    } label: {
                        Text("Get Started")
                            .font(.system(size: 17, weight: .semibold))
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
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(color: .blue.opacity(0.3), radius: 14, y: 6)
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 48)
                    .accessibilityLabel("Get Started Button")

                }
                .frame(maxWidth: 600) // Adaptive width for iPad
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $navigateToLogin) {
                LoginView()
            }
            .onAppear {
                animateFeatures = true
            }
        }
    }

    // MARK: - Feature Row
    private func featureRow(icon: String, color: Color, title: String, subtitle: String) -> some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(color.opacity(0.12))
                    .frame(width: 48, height: 48)
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(color)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color(.label))
                Text(subtitle)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(Color(.secondaryLabel))
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

// MARK: - Preview
struct LandingUIScreen_Previews: PreviewProvider {
    static var previews: some View {
        LandingUIScreen()
    }
}


