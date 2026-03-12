
import SwiftUI

// MARK: - QR Scan View

struct QRScanView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var scanLineOffset: CGFloat = -120
    @State private var isScanning     = true
    @State private var didDetect      = false
    @State private var pulseCorners   = false
    @State private var flashEnabled   = false
    @State private var showSuccess    = false

    // Simulate a scan result after 3 seconds
    private let simulatedLocation = "Cardiology Clinic – 3rd Floor, Wing B"

    var body: some View {
        ZStack {
            // ── Camera background (simulated) ──
            Color.black.ignoresSafeArea()

            if !showSuccess {
                scannerContent
            } else {
                successOverlay
            }
        }
        .navigationTitle("Scan Location QR")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.black, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { flashEnabled.toggle() }) {
                    Image(systemName: flashEnabled ? "bolt.fill" : "bolt.slash.fill")
                        .foregroundStyle(flashEnabled ? .yellow : .white)
                        .font(.system(size: 16, weight: .medium))
                }
            }
        }
        .onAppear { startScanAnimation() }
    }

    // MARK: Scanner UI

    private var scannerContent: some View {
        ZStack {
            // Simulated blurry camera feed
            LinearGradient(
                colors: [Color(white: 0.08), Color(white: 0.14), Color(white: 0.07)],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Subtle noise texture overlay
            Rectangle()
                .fill(.white.opacity(0.02))
                .ignoresSafeArea()

            VStack(spacing: 0) {

                Spacer()

                // Instruction
                Text("Point your camera at a location QR code")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 32)

                // Viewfinder box
                ZStack {
                    // Dark overlay mask
                    GeometryReader { geo in
                        let size = min(geo.size.width, geo.size.height)
                        let boxSize: CGFloat = 260
                        let ox = (geo.size.width  - boxSize) / 2
                        let oy = (geo.size.height - boxSize) / 2

                        // Dark vignette around finder
                        Path { p in
                            p.addRect(CGRect(origin: .zero, size: geo.size))
                            p.addRoundedRect(
                                in: CGRect(x: ox, y: oy, width: boxSize, height: boxSize),
                                cornerRadii: RectangleCornerRadii(
                                    topLeading: 16, bottomLeading: 16,
                                    bottomTrailing: 16, topTrailing: 16
                                )
                            )
                        }
                        .fill(style: FillStyle(eoFill: true))
                        .foregroundStyle(.black.opacity(0.65))

                        // Scan line
                        RoundedRectangle(cornerRadius: 1)
                            .fill(
                                LinearGradient(
                                    colors: [.clear, .green.opacity(0.9), .clear],
                                    startPoint: .leading, endPoint: .trailing
                                )
                            )
                            .frame(width: boxSize - 20, height: 2)
                            .offset(x: ox + 10, y: oy + 10 + scanLineOffset + 120)
                            .opacity(isScanning ? 1 : 0)
                    }
                    .frame(height: 260)

                    // Corner brackets
                    CornerBrackets(size: 260, cornerLength: 28, color: didDetect ? .green : .white,
                                   pulse: pulseCorners)
                }
                .frame(width: 260, height: 260)

                Spacer().frame(height: 40)

                // Status pill
                statusPill

                Spacer()

                // Bottom hint
                VStack(spacing: 12) {
                    HStack(spacing: 6) {
                        Image(systemName: "info.circle")
                            .font(.caption)
                        Text("QR codes are placed at every department entrance")
                            .font(.caption)
                    }
                    .foregroundStyle(.white.opacity(0.5))

                    // Gallery fallback button
                    Button(action: simulateScan) {
                        Label("Simulate Scan (Demo)", systemImage: "qrcode")
                            .font(.footnote.weight(.semibold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(.white.opacity(0.12), in: Capsule())
                    }
                }
                .padding(.bottom, 48)
            }
        }
    }

    // MARK: Status Pill

    private var statusPill: some View {
        HStack(spacing: 8) {
            if didDetect {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
                Text("QR Code Detected!")
                    .fontWeight(.semibold)
            } else {
                ProgressView()
                    .tint(.white)
                    .scaleEffect(0.8)
                Text("Scanning…")
            }
        }
        .font(.subheadline)
        .foregroundStyle(.white)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(.white.opacity(0.12), in: Capsule())
        .animation(.easeInOut(duration: 0.3), value: didDetect)
    }

    // MARK: Success Overlay

    private var successOverlay: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()

            VStack(spacing: 32) {
                Spacer()

                // Success icon
                ZStack {
                    Circle()
                        .fill(Color.green.opacity(0.12))
                        .frame(width: 120, height: 120)
                    Circle()
                        .fill(Color.green.opacity(0.20))
                        .frame(width: 90, height: 90)
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 52))
                        .foregroundStyle(.green)
                }

                VStack(spacing: 8) {
                    Text("Location Confirmed")
                        .font(.title2.weight(.bold))
                        .foregroundStyle(Color(.label))

                    Text(simulatedLocation)
                        .font(.body)
                        .foregroundStyle(Color(.secondaryLabel))
                        .multilineTextAlignment(.center)
                }

                // Info card
                VStack(spacing: 0) {
                    infoRow(icon: "map.fill",        color: .blue,
                            label: "Department",     value: "OPD – Cardiology")
                    Divider().padding(.horizontal, 16)
                    infoRow(icon: "arrow.up.right",  color: .orange,
                            label: "Floor",          value: "3rd Floor, Wing B")
                    Divider().padding(.horizontal, 16)
                    infoRow(icon: "figure.walk",     color: .green,
                            label: "Walking Time",   value: "~3 minutes")
                }
                .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
                .shadow(color: .black.opacity(0.05), radius: 12, y: 4)
                .padding(.horizontal, 24)

                Spacer()

                // CTA
                VStack(spacing: 12) {
                    Button(action: { dismiss() }) {
                        Text("Start Navigation")
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
                            .shadow(color: Color(hex: "#3A7BF7").opacity(0.30), radius: 10, y: 5)
                    }

                    Button(action: rescan) {
                        Text("Scan Again")
                            .font(.body.weight(.medium))
                            .foregroundStyle(Color(hex: "#3A7BF7"))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
    }

    private func infoRow(icon: String, color: Color, label: String, value: String) -> some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(color.opacity(0.12))
                    .frame(width: 36, height: 36)
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(color)
            }
            Text(label)
                .font(.subheadline)
                .foregroundStyle(Color(.secondaryLabel))
            Spacer()
            Text(value)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(Color(.label))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }

    // MARK: - Helpers

    private func startScanAnimation() {
        isScanning  = true
        didDetect   = false
        showSuccess = false
        scanLineOffset = -120

        withAnimation(
            .easeInOut(duration: 1.8).repeatForever(autoreverses: true)
        ) {
            scanLineOffset = 120
        }

        // Auto-simulate detection after 3s
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            simulateScan()
        }
    }

    private func simulateScan() {
        let haptic = UINotificationFeedbackGenerator()
        haptic.notificationOccurred(.success)

        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
            didDetect     = true
            pulseCorners  = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation(.easeInOut(duration: 0.45)) {
                showSuccess = true
            }
        }
    }

    private func rescan() {
        withAnimation(.easeInOut(duration: 0.3)) {
            showSuccess = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            startScanAnimation()
        }
    }
}

// MARK: - Corner Brackets Shape

private struct CornerBrackets: View {
    let size: CGFloat
    let cornerLength: CGFloat
    let color: Color
    let pulse: Bool

    var body: some View {
        ZStack {
            // Top-left
            cornerShape(rotation: 0)
                .offset(x: -(size / 2 - cornerLength / 2 + 1),
                        y: -(size / 2 - cornerLength / 2 + 1))
            // Top-right
            cornerShape(rotation: 90)
                .offset(x:  (size / 2 - cornerLength / 2 + 1),
                        y: -(size / 2 - cornerLength / 2 + 1))
            // Bottom-left
            cornerShape(rotation: 270)
                .offset(x: -(size / 2 - cornerLength / 2 + 1),
                        y:  (size / 2 - cornerLength / 2 + 1))
            // Bottom-right
            cornerShape(rotation: 180)
                .offset(x:  (size / 2 - cornerLength / 2 + 1),
                        y:  (size / 2 - cornerLength / 2 + 1))
        }
        .scaleEffect(pulse ? 1.04 : 1.0)
        .animation(.easeInOut(duration: 0.35), value: pulse)
    }

    private func cornerShape(rotation: Double) -> some View {
        CornerBracketShape(length: cornerLength)
            .stroke(color, style: StrokeStyle(lineWidth: 3, lineCap: .round))
            .frame(width: cornerLength, height: cornerLength)
            .rotationEffect(.degrees(rotation))
    }
}

private struct CornerBracketShape: Shape {
    let length: CGFloat
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: 0, y: length))
        p.addLine(to: CGPoint(x: 0, y: 0))
        p.addLine(to: CGPoint(x: length, y: 0))
        return p
    }
}

// MARK: - Color Extension (shared — remove if already in project)



// MARK: - Preview

#Preview {
    NavigationStack { QRScanView() }
}
