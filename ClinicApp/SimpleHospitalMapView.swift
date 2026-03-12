

import SwiftUI


struct SimpleHospitalMapView: View {

    @Environment(\.dismiss) private var dismiss

    // ── Change this to match your exact asset name ──
    private let assetName = "hospital_map"

    // Pin positions as fractions of image size (0.0 – 1.0)
    // Tweak these once your image is showing
    private let userPos = CGPoint(x: 0.18, y: 0.82)
    private let destPos = CGPoint(x: 0.80, y: 0.28)

    private let accent = Color(hex: "#3A7BF7")
    private let green  = Color(hex: "#34C759")

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {

                // ── Map card ──
                GeometryReader { geo in
                    ZStack {
                        mapBackground(size: geo.size)
                        HospitalRouteOverlay(start: userPos, end: destPos, size: geo.size)
                        HospitalMapPin(pos: userPos,  color: green,  icon: "location.circle.fill", label: "You are here", size: geo.size)
                        HospitalMapPin(pos: destPos,  color: accent, icon: "heart.circle.fill",    label: "Cardiology",   size: geo.size)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.10), radius: 12, y: 5)
                }
                .frame(height: 360)
                .padding(.horizontal, 16)

                // ── From / To row ──
                HStack(spacing: 0) {
                    routeEndpoint(
                        icon: "location.circle.fill", color: green,
                        label: "FROM", name: "Main Reception", sub: "Ground Floor"
                    )

                    VStack(spacing: 4) {
                        Image(systemName: "arrow.right")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(Color(.tertiaryLabel))
                        Text("3 min")
                            .font(.caption2.weight(.semibold))
                            .foregroundStyle(accent)
                    }
                    .frame(maxWidth: .infinity)

                    routeEndpoint(
                        icon: "heart.circle.fill", color: accent,
                        label: "TO", name: "Cardiology Clinic", sub: "3rd Floor, Wing B"
                    )
                }
                .padding(16)
                .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
                .shadow(color: .black.opacity(0.05), radius: 8, y: 3)
                .padding(.horizontal, 16)

                // ── Directions ──
                VStack(alignment: .leading, spacing: 10) {
                    Text("Directions")
                        .font(.headline)
                        .padding(.horizontal, 4)

                    VStack(spacing: 0) {
                        directionStep(n: 1, text: "Walk straight 20 m to central elevators", last: false)
                        directionStep(n: 2, text: "Turn right at the Pharmacy",              last: false)
                        directionStep(n: 3, text: "Take elevator to 3rd Floor",              last: false)
                        directionStep(n: 4, text: "Cardiology Clinic is on your left",       last: true)
                    }
                    .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .black.opacity(0.05), radius: 8, y: 3)
                }
                .padding(.horizontal, 16)

                // ── CTA ──
                Button(action: { dismiss() }) {
                    Label("Start Navigation", systemImage: "arrow.triangle.turn.up.right.circle.fill")
                        .font(.body.weight(.semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            LinearGradient(
                                colors: [Color(hex: "#4A7CF7"), Color(hex: "#2F5FD8")],
                                startPoint: .leading, endPoint: .trailing
                            ),
                            in: RoundedRectangle(cornerRadius: 14)
                        )
                        .shadow(color: accent.opacity(0.30), radius: 10, y: 5)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
            }
            .padding(.top, 16)
        }
        .background(Color(.systemGroupedBackground))
        // ── Title only – NO custom back button, NavigationStack provides it ──
        .navigationTitle("Indoor Navigation")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: Map background

    @ViewBuilder
    private func mapBackground(size: CGSize) -> some View {
        if UIImage(named: assetName) != nil {
            Image(assetName)
                .resizable()
                .scaledToFill()
                .frame(width: size.width, height: size.height)
                .clipped()
        } else {
            // ── Fallback placeholder when asset is not found ──
            ZStack {
                Color(hex: "#E8EDF6")
                VStack {
                    Image(systemName: "map")
                        .font(.system(size: 40))
                        .foregroundStyle(Color(hex: "#3A7BF7").opacity(0.4))
                    Text("Add \"\(assetName)\" to Assets.xcassets")
                        .font(.caption)
                        .foregroundStyle(Color(.secondaryLabel))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
            }
            .frame(width: size.width, height: size.height)
        }
    }

    // MARK: Sub-views

    private func routeEndpoint(icon: String, color: Color,
                               label: String, name: String, sub: String) -> some View {
        HStack(spacing: 10) {
            ZStack {
                Circle().fill(color.opacity(0.12)).frame(width: 38, height: 38)
                Image(systemName: icon).font(.system(size: 18)).foregroundStyle(color)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(Color(.tertiaryLabel))
                    .tracking(0.5)
                Text(name)
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(Color(.label))
                Text(sub)
                    .font(.caption2)
                    .foregroundStyle(Color(.secondaryLabel))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    private func directionStep(n: Int, text: String, last: Bool) -> some View {
        HStack(alignment: .top, spacing: 14) {
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .fill(last ? green.opacity(0.12) : accent.opacity(0.10))
                        .frame(width: 30, height: 30)
                    if last {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 14)).foregroundStyle(green)
                    } else {
                        Text("\(n)")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(accent)
                    }
                }
                if !last {
                    Rectangle()
                        .fill(accent.opacity(0.15))
                        .frame(width: 1.5, height: 16)
                }
            }
            Text(text)
                .font(.subheadline)
                .foregroundStyle(Color(.label))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 5)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)

        if !last { Divider().padding(.leading, 60) }
    }
}

// MARK: - Route Overlay

struct HospitalRouteOverlay: View {
    let start: CGPoint
    let end:   CGPoint
    let size:  CGSize

    private let accent = Color(hex: "#3A7BF7")

    var body: some View {
        Canvas { ctx, _ in
            let s  = CGPoint(x: start.x * size.width,  y: start.y * size.height)
            let e  = CGPoint(x: end.x   * size.width,  y: end.y   * size.height)
            let midY = size.height * 0.40

            var path = Path()
            path.move(to: s)
            path.addLine(to: CGPoint(x: s.x, y: midY))
            path.addLine(to: CGPoint(x: e.x, y: midY))
            path.addLine(to: e)

            // Glow
            ctx.stroke(path, with: .color(accent.opacity(0.18)),
                       style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
            // Line
            ctx.stroke(path, with: .color(accent),
                       style: StrokeStyle(lineWidth: 3, lineCap: .round,
                                          lineJoin: .round, dash: [8, 6]))
            // Arrows
            for t: CGFloat in [0.35, 0.65] {
                let px = s.x + (e.x - s.x) * t
                var a = Path()
                a.move(to: CGPoint(x: px - 6, y: midY - 5))
                a.addLine(to: CGPoint(x: px,     y: midY))
                a.addLine(to: CGPoint(x: px - 6, y: midY + 5))
                ctx.stroke(a, with: .color(accent),
                           style: StrokeStyle(lineWidth: 2, lineCap: .round))
            }
        }
    }
}

// MARK: - Map Pin

struct HospitalMapPin: View {
    let pos:   CGPoint
    let color: Color
    let icon:  String
    let label: String
    let size:  CGSize

    var body: some View {
        VStack(spacing: 2) {
            ZStack {
                Circle().fill(color.opacity(0.20)).frame(width: 46, height: 46)
                Circle().fill(color).frame(width: 32, height: 32)
                    .shadow(color: color.opacity(0.40), radius: 5, y: 3)
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.white)
            }
            Text(label)
                .font(.system(size: 9, weight: .bold))
                .foregroundStyle(.white)
                .padding(.horizontal, 7)
                .padding(.vertical, 3)
                .background(color, in: Capsule())
                .shadow(color: color.opacity(0.35), radius: 3, y: 2)
        }
        .position(x: pos.x * size.width,
                  y: pos.y * size.height - 28)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        SimpleHospitalMapView()
    }
}
