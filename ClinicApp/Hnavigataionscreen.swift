


import SwiftUI

// MARK: - Models

struct NavigationStep: Identifiable {
    let id = UUID()
    let systemIcon: String
    let isDestination: Bool
    let description: String
}

// MARK: - Design Tokens

private enum Spacing {
    static let xs:   CGFloat = 4
    static let sm:   CGFloat = 8
    static let md:   CGFloat = 12
    static let base: CGFloat = 16
    static let lg:   CGFloat = 20
    static let xl:   CGFloat = 24
    static let xxl:  CGFloat = 32
}

private enum Radius {
    static let sm: CGFloat = 10
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
}

private enum AppColor {
    static let accent       = Color(hex: "#3A7BF7")
    static let accentLight  = Color(hex: "#EBF1FF")
    static let success      = Color(hex: "#34C759")
    static let successLight = Color(hex: "#34C759").opacity(0.12)
    static let surface      = Color(.systemBackground)
    static let background   = Color(.systemGroupedBackground)
}

// MARK: - Main View

struct HNavigationScreen: View {

    @State private var navigateToQR      = false
    @State private var navigateToFullMap = false

    private let currentNumber   = 45
    private let yourNumber      = 55
    private let department      = "OPD"
    private let currentLocation = "Main Reception, Ground Floor"
    private let destination     = "Cardiology Clinic (OPD)"
    private let destinationSub  = "3rd Floor, Wing B"
    private let walkTime        = "3 min walk"

    private let steps: [NavigationStep] = [
        NavigationStep(systemIcon: "arrow.up",            isDestination: false,
                       description: "Walk straight 20 m to the central elevators"),
        NavigationStep(systemIcon: "arrow.turn.up.right", isDestination: false,
                       description: "Turn right at the Pharmacy"),
        NavigationStep(systemIcon: "arrow.up.circle",     isDestination: false,
                       description: "Take the elevator to the 3rd Floor"),
        NavigationStep(systemIcon: "mappin.circle.fill",  isDestination: true,
                       description: "Arrive at Cardiology Clinic on your left")
    ]

    var body: some View {
        ZStack {
            AppColor.background.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: Spacing.xl) {
                    liveQueueSection
                    scanQRButton
                    locationSection
                    indoorNavigationSection
                    textNavigationSection
                    Color.clear.frame(height: 20)
                }
                .padding(.horizontal, Spacing.base)
                .padding(.top, Spacing.md)
            }

            NavigationLink(destination: QRScanView(), isActive: $navigateToQR) {
                EmptyView()
            }.hidden()

            NavigationLink(destination: SimpleHospitalMapView(), isActive: $navigateToFullMap) {
                EmptyView()
            }.hidden()
        }
        .navigationTitle("Navigation")
        .navigationBarTitleDisplayMode(.large)
    }

    // MARK: - Live Queue

    private var liveQueueSection: some View {
        VStack(spacing: 0) {
            HStack(spacing: Spacing.sm) {
                pulsingDot
                Text("Live Queue Status")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(Color(.label))
                Spacer()
                badge(text: "Dept: \(department)")
            }
            .padding(.horizontal, Spacing.base)
            .padding(.vertical, Spacing.md)

            Divider().padding(.horizontal, Spacing.base)

            HStack(spacing: Spacing.md) {
                queueCell(label: "Current Number", value: "\(currentNumber)",
                          valueColor: Color(.label))
                queueCell(label: "Your Number",    value: "\(yourNumber)",
                          valueColor: AppColor.accent)
            }
            .padding(.horizontal, Spacing.base)
            .padding(.vertical, Spacing.md)
        }
        .background(AppColor.surface, in: RoundedRectangle(cornerRadius: Radius.lg))
        .cardShadow()
    }

    private var pulsingDot: some View {
        ZStack {
            Circle().fill(AppColor.success.opacity(0.22)).frame(width: 18, height: 18)
            Circle().fill(AppColor.success).frame(width: 10, height: 10)
        }
    }

    private func badge(text: String) -> some View {
        Text(text)
            .font(.caption.weight(.medium))
            .foregroundStyle(AppColor.accent)
            .padding(.horizontal, Spacing.sm + 2)
            .padding(.vertical, Spacing.xs + 1)
            .background(AppColor.accentLight, in: Capsule())
    }

    private func queueCell(label: String, value: String, valueColor: Color) -> some View {
        VStack(spacing: Spacing.xs) {
            Text(label)
                .font(.caption)
                .foregroundStyle(Color(.secondaryLabel))
            Text(value)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(valueColor)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.md)
        .background(Color(.secondarySystemGroupedBackground),
                    in: RoundedRectangle(cornerRadius: Radius.sm))
    }

    // MARK: - Scan QR

    private var scanQRButton: some View {
        Button(action: { navigateToQR = true }) {
            Label("Scan Location QR", systemImage: "qrcode.viewfinder")
                .font(.body.weight(.semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, Spacing.base)
                .background(
                    LinearGradient(colors: [Color(hex: "#4A7CF7"), Color(hex: "#2F5FD8")],
                                   startPoint: .leading, endPoint: .trailing),
                    in: RoundedRectangle(cornerRadius: Radius.md)
                )
                .shadow(color: AppColor.accent.opacity(0.30), radius: 12, x: 0, y: 6)
        }
        .buttonStyle(.plain)
        .scaleOnPress()
    }

    // MARK: - Location

    private var locationSection: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: Spacing.md) {
                locationIcon(filled: false)
                VStack(alignment: .leading, spacing: 2) {
                    Text("CURRENT LOCATION")
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(Color(.tertiaryLabel))
                        .tracking(0.5)
                    Text(currentLocation)
                        .font(.callout.weight(.semibold))
                        .foregroundStyle(Color(.label))
                }
                Spacer()
            }
            .padding(.horizontal, Spacing.base)
            .padding(.top, Spacing.base)
            .padding(.bottom, Spacing.sm)

            HStack {
                Spacer().frame(width: Spacing.base + 18 - 1)
                Rectangle()
                    .fill(Color(.separator))
                    .frame(width: 1.5, height: 22)
                Spacer()
            }

            HStack(alignment: .top, spacing: Spacing.md) {
                locationIcon(filled: true)
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text("RECOMMENDED DESTINATION")
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(Color(.tertiaryLabel))
                        .tracking(0.5)

                    HStack(spacing: Spacing.md) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(AppColor.accentLight)
                                .frame(width: 40, height: 40)
                            Image(systemName: "stethoscope")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(AppColor.accent)
                        }
                        VStack(alignment: .leading, spacing: 2) {
                            Text(destination)
                                .font(.callout.weight(.semibold))
                                .foregroundStyle(Color(.label))
                            Text(destinationSub)
                                .font(.footnote)
                                .foregroundStyle(Color(.secondaryLabel))
                        }
                        Spacer()
                    }
                    .padding(Spacing.md)
                    .background(Color(.secondarySystemGroupedBackground),
                                in: RoundedRectangle(cornerRadius: Radius.sm))
                }
            }
            .padding(.horizontal, Spacing.base)
            .padding(.top, Spacing.sm)
            .padding(.bottom, Spacing.base)
        }
        .background(AppColor.surface, in: RoundedRectangle(cornerRadius: Radius.lg))
        .cardShadow()
    }

    private func locationIcon(filled: Bool) -> some View {
        ZStack {
            Circle()
                .fill(filled ? AppColor.accentLight : Color(.secondarySystemGroupedBackground))
                .frame(width: 36, height: 36)
            Image(systemName: filled ? "mappin.circle.fill" : "location.circle")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(filled ? AppColor.accent : Color(.secondaryLabel))
        }
    }

    // MARK: - Indoor Navigation (uses real image as thumbnail)

    private var indoorNavigationSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {

            HStack(alignment: .firstTextBaseline) {
                Text("Indoor Navigation")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(Color(.label))
                Spacer()
                badge(text: walkTime)
            }

            VStack(spacing: 0) {
                // ── Thumbnail: same image as full map ──
                Button(action: { navigateToFullMap = true }) {
                    ZStack {
                        // Real image or fallback
                        if UIImage(named: "hospital_map") != nil {
                            Image("hospital_map")
                                .resizable()
                                .scaledToFill()
                                .frame(height: 160)
                                .clipped()
                        } else {
                            MiniMapFallback()
                                .frame(height: 160)
                        }

                        // Dark overlay + expand hint
                        VStack {
                            HStack {
                                Spacer()
                                Label("Tap to expand", systemImage: "arrow.up.left.and.arrow.down.right")
                                    .font(.system(size: 10, weight: .semibold))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.black.opacity(0.40), in: Capsule())
                                    .padding(10)
                            }
                            Spacer()
                        }
                    }
                    .frame(height: 160)
                }
                .buttonStyle(.plain)
                .clipShape(
                    UnevenRoundedRectangle(topLeadingRadius: Radius.lg,
                                           bottomLeadingRadius: 0,
                                           bottomTrailingRadius: 0,
                                           topTrailingRadius: Radius.lg)
                )

                Divider()

                Button(action: { navigateToFullMap = true }) {
                    HStack {
                        Text("Open Full Map View")
                            .font(.callout.weight(.semibold))
                            .foregroundStyle(AppColor.accent)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.footnote.weight(.semibold))
                            .foregroundStyle(Color(.tertiaryLabel))
                    }
                    .padding(.horizontal, Spacing.base)
                    .padding(.vertical, Spacing.md + 2)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .scaleOnPress()
                .background(AppColor.surface)
                .clipShape(
                    UnevenRoundedRectangle(topLeadingRadius: 0,
                                           bottomLeadingRadius: Radius.lg,
                                           bottomTrailingRadius: Radius.lg,
                                           topTrailingRadius: 0)
                )
            }
            .background(AppColor.surface, in: RoundedRectangle(cornerRadius: Radius.lg))
            .cardShadow()
        }
    }

    // MARK: - Text Navigation (improved)

    private var textNavigationSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {

            // Section header with distance chip
            HStack {
                Text("Step-by-Step Directions")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(Color(.label))
                Spacer()
                Text("180 m")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Color(.secondaryLabel))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(.secondarySystemGroupedBackground),
                                in: Capsule())
            }

            VStack(spacing: 0) {
                ForEach(Array(steps.enumerated()), id: \.element.id) { idx, step in
                    improvedStepRow(step: step, index: idx,
                                    isLast: idx == steps.count - 1)
                }
            }
            .background(AppColor.surface, in: RoundedRectangle(cornerRadius: Radius.lg))
            .cardShadow()
        }
    }

    @ViewBuilder
    private func improvedStepRow(step: NavigationStep, index: Int, isLast: Bool) -> some View {
        HStack(alignment: .top, spacing: 14) {
            // Icon + connector column
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .fill(isLast ? AppColor.successLight : AppColor.accentLight)
                        .frame(width: 40, height: 40)
                    Image(systemName: step.systemIcon)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(isLast ? AppColor.success : AppColor.accent)
                }
                // Connector line between steps
                if !isLast {
                    Rectangle()
                        .fill(Color(.separator))
                        .frame(width: 1, height: 24)
                }
            }

            // Text content
            VStack(alignment: .leading, spacing: 3) {
                Text("Step \(index + 1)")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(isLast ? AppColor.success : AppColor.accent)
                Text(step.description)
                    .font(.subheadline)
                    .foregroundStyle(Color(.label))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.top, 10)

            Spacer()
        }
        .padding(.horizontal, Spacing.base)
        .padding(.top, 14)
        .padding(.bottom, isLast ? 16 : 4)
    }
}

// MARK: - Mini Map Fallback (no image)

private struct MiniMapFallback: View {
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            ZStack {
                Color(hex: "#E2E8F4")
                Path { p in
                    stride(from: CGFloat(0), to: w, by: w/9).forEach { x in
                        p.move(to: .init(x: x, y: 0)); p.addLine(to: .init(x: x, y: h))
                    }
                    stride(from: CGFloat(0), to: h, by: h/7).forEach { y in
                        p.move(to: .init(x: 0, y: y)); p.addLine(to: .init(x: w, y: y))
                    }
                }
                .stroke(Color.white.opacity(0.45), lineWidth: 0.5)

                miniBlock(x: w*0.13, y: h*0.42, w: w*0.20, h: h*0.36,
                          label: "EMERGENCY", color: Color(hex: "#A4AECB"))
                miniBlock(x: w*0.50, y: h*0.32, w: w*0.18, h: h*0.26,
                          label: "SURGERY",   color: Color(hex: "#8F9EC0"))
                miniBlock(x: w*0.79, y: h*0.26, w: w*0.16, h: h*0.22,
                          label: "PHARMACY",  color: Color(hex: "#A4AECB"))
                miniBlock(x: w*0.79, y: h*0.66, w: w*0.16, h: h*0.22,
                          label: "OPD",       color: Color(hex: "#3A7BF7").opacity(0.75))

                Capsule().fill(Color(hex: "#C2CCE4")).frame(width: w*0.72, height: 12)
                    .position(x: w*0.50, y: h*0.57)

                // Route
                HospitalRouteOverlay(
                    start: CGPoint(x: 0.13, y: 0.88),
                    end:   CGPoint(x: 0.79, y: 0.51),
                    size:  CGSize(width: w, height: h)
                )

                Circle().fill(Color(hex: "#34C759")).frame(width: 9, height: 9)
                    .overlay(Circle().stroke(.white, lineWidth: 2))
                    .position(x: w*0.13, y: h*0.88)
                Image(systemName: "mappin.circle.fill").font(.system(size: 15))
                    .foregroundStyle(Color(hex: "#3A7BF7"))
                    .position(x: w*0.79, y: h*0.46)
            }
        }
    }

    private func miniBlock(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat,
                           label: String, color: Color) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3).fill(color).frame(width: w, height: h).position(x: x, y: y)
            Text(label).font(.system(size: 5.5, weight: .bold)).foregroundStyle(.white).position(x: x, y: y)
        }
    }
}

// MARK: - View Modifiers

private struct CardShadow: ViewModifier {
    func body(content: Content) -> some View {
        content.shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 4)
    }
}

private struct ScaleOnPress: ViewModifier {
    @State private var pressing = false
    func body(content: Content) -> some View {
        content
            .scaleEffect(pressing ? 0.97 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: pressing)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in pressing = true }
                    .onEnded   { _ in pressing = false }
            )
    }
}

extension View {
    func cardShadow()   -> some View { modifier(CardShadow()) }
    func scaleOnPress() -> some View { modifier(ScaleOnPress()) }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        HNavigationScreen()
    }
}
