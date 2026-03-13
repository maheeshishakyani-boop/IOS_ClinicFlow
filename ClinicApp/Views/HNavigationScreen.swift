////
////
////import SwiftUI
////
////// NOTE: HospitalDestination, NavigationStep, and allDestinations are defined
////// in your existing project file — do not redeclare them here.
////
////struct HNavigationScreen: View {
////    @State private var navigateToQR      = false
////    @State private var navigateToFullMap = false
////    @State private var selectedDestID    = 0
////    @State private var isDropdownOpen    = false  // ← lifted here, prevents state reset
////
////    private let currentNumber   = 45
////    private let yourNumber      = 55
////    private let department      = "OPD"
////    private let currentLocation = "Main Reception, Ground Floor"
////    private let walkTime        = "3 min walk"
////
////    private var selectedDest: HospitalDestination {
////        allDestinations.first { $0.id == selectedDestID } ?? allDestinations[0]
////    }
////
////    var body: some View {
////        ZStack {
////            Color(.systemGroupedBackground).ignoresSafeArea()
////
////            ScrollView(showsIndicators: false) {
////                VStack(alignment: .leading, spacing: 24) {
////                    liveQueueSection
////                    scanQRButton
////                    locationSection
////                    indoorNavigationSection
////                    textNavigationSection
////                    Color.clear.frame(height: 20)
////                }
////                .padding(.horizontal, 16)
////                .padding(.top, 12)
////            }
////
////            NavigationLink(destination: QRScanView(), isActive: $navigateToQR) {
////                EmptyView()
////            }.hidden()
////
////            NavigationLink(destination: SimpleHospitalMapView(), isActive: $navigateToFullMap) {
////                EmptyView()
////            }.hidden()
////        }
////        .navigationTitle("Navigation")
////        .navigationBarTitleDisplayMode(.large)
////    }
////
////    // MARK: - Live Queue
////    private var liveQueueSection: some View {
////        VStack(spacing: 0) {
////            HStack {
////                HStack(spacing: 6) {
////                    Circle()
////                        .fill(Color.green)
////                        .frame(width: 8, height: 8)
////                        .overlay(Circle().stroke(Color.green.opacity(0.35), lineWidth: 3))
////                    Text("Live Queue Status")
////                        .font(.subheadline)
////                        .fontWeight(.semibold)
////                        .foregroundStyle(.primary)
////                }
////                Spacer()
////                Text("Dept: \(department)")
////                    .font(.caption)
////                    .fontWeight(.medium)
////                    .foregroundStyle(.secondary)
////                    .padding(.horizontal, 10)
////                    .padding(.vertical, 5)
////                    .background(Capsule().fill(Color(.secondarySystemBackground)))
////            }
////            .padding(.horizontal, 16)
////            .padding(.top, 14)
////            .padding(.bottom, 12)
////
////            Divider().padding(.horizontal, 16)
////
////            HStack(spacing: 0) {
////                VStack(spacing: 4) {
////                    Text("Current Number")
////                        .font(.caption)
////                        .foregroundStyle(.secondary)
////                    Text("\(currentNumber)")
////                        .font(.system(size: 34, weight: .bold))
////                        .foregroundStyle(.primary)
////                }
////                .frame(maxWidth: .infinity)
////
////                Rectangle()
////                    .fill(Color(.separator))
////                    .frame(width: 1, height: 48)
////
////                VStack(spacing: 4) {
////                    Text("Your Number")
////                        .font(.caption)
////                        .foregroundStyle(.secondary)
////                    Text("\(yourNumber)")
////                        .font(.system(size: 34, weight: .bold))
////                        .foregroundStyle(.blue)
////                }
////                .frame(maxWidth: .infinity)
////            }
////            .padding(.vertical, 14)
////        }
////        .background(
////            RoundedRectangle(cornerRadius: 16)
////                .fill(Color(.systemBackground))
////                .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
////        )
////    }
////
////    // MARK: - Scan QR
////    private var scanQRButton: some View {
////        Button(action: { navigateToQR = true }) {
////            Label("Scan Location QR", systemImage: "qrcode.viewfinder")
////                .font(.body.weight(.semibold))
////                .foregroundStyle(.white)
////                .frame(maxWidth: .infinity)
////                .padding(.vertical, 16)
////                .background(
////                    LinearGradient(colors: [Color(hex: "#4A7CF7"), Color(hex: "#2F5FD8")],
////                                   startPoint: .leading, endPoint: .trailing),
////                    in: RoundedRectangle(cornerRadius: 12)
////                )
////                .shadow(color: Color.blue.opacity(0.30), radius: 12, x: 0, y: 6)
////        }
////        .buttonStyle(.plain)
////        .scaleOnPress()
////    }
////
////    // MARK: - Location Section
////    private var locationSection: some View {
////        VStack(spacing: 0) {
////            // Current Location row
////            HStack(alignment: .center, spacing: 12) {
////                locationIcon(filled: false)
////                VStack(alignment: .leading, spacing: 2) {
////                    Text("CURRENT LOCATION")
////                        .font(.caption2.weight(.semibold))
////                        .foregroundStyle(Color(.tertiaryLabel))
////                        .tracking(0.5)
////                    Text(currentLocation)
////                        .font(.callout.weight(.semibold))
////                        .foregroundStyle(Color(.label))
////                }
////                Spacer()
////            }
////            .padding(.horizontal, 16)
////            .padding(.top, 16)
////            .padding(.bottom, 8)
////
////            // Connector line
////            HStack {
////                Spacer().frame(width: 34)
////                Rectangle()
////                    .fill(Color(.separator))
////                    .frame(width: 1.5, height: 22)
////                Spacer()
////            }
////
////            // Destination row
////            HStack(alignment: .top, spacing: 12) {
////                locationIcon(filled: true)
////                    .padding(.top, 2)
////
////                VStack(alignment: .leading, spacing: 8) {
////                    Text("SELECT DESTINATION")
////                        .font(.caption2.weight(.semibold))
////                        .foregroundStyle(Color(.tertiaryLabel))
////                        .tracking(0.5)
////
////                    // ── Inline dropdown (state owned by parent) ──
////                    VStack(spacing: 0) {
////
////                        // Header — always visible, tap to toggle
////                        Button {
////                            withAnimation(.easeInOut(duration: 0.25)) {
////                                isDropdownOpen.toggle()
////                            }
////                        } label: {
////                            HStack(spacing: 12) {
////                                ZStack {
////                                    RoundedRectangle(cornerRadius: 8)
////                                        .fill(Color.blue.opacity(0.10))
////                                        .frame(width: 38, height: 38)
////                                    Image(systemName: selectedDest.icon)
////                                        .font(.system(size: 17, weight: .medium))
////                                        .foregroundStyle(.blue)
////                                }
////                                VStack(alignment: .leading, spacing: 2) {
////                                    Text(selectedDest.name)
////                                        .font(.callout.weight(.semibold))
////                                        .foregroundStyle(Color(.label))
////                                        .lineLimit(1)
////                                    Text(selectedDest.sub)
////                                        .font(.caption)
////                                        .foregroundStyle(Color(.secondaryLabel))
////                                }
////                                Spacer()
////                                Image(systemName: "chevron.down")
////                                    .font(.system(size: 13, weight: .semibold))
////                                    .foregroundStyle(Color(.secondaryLabel))
////                                    .rotationEffect(.degrees(isDropdownOpen ? 180 : 0))
////                                    .animation(.easeInOut(duration: 0.25), value: isDropdownOpen)
////                            }
////                            .padding(.horizontal, 12)
////                            .padding(.vertical, 12)
////                            .contentShape(Rectangle())
////                        }
////                        .buttonStyle(.plain)
////
////                        // Expanded list — shown/hidden based on isDropdownOpen
////                        if isDropdownOpen {
////                            Divider().padding(.horizontal, 12)
////
////                            VStack(spacing: 0) {
////                                ForEach(allDestinations) { dest in
////                                    Button {
////                                        withAnimation(.easeInOut(duration: 0.2)) {
////                                            selectedDestID = dest.id
////                                            isDropdownOpen = false
////                                        }
////                                    } label: {
////                                        HStack(spacing: 12) {
////                                            ZStack {
////                                                RoundedRectangle(cornerRadius: 6)
////                                                    .fill(selectedDestID == dest.id
////                                                          ? Color.blue.opacity(0.12)
////                                                          : Color(.tertiarySystemGroupedBackground))
////                                                    .frame(width: 32, height: 32)
////                                                Image(systemName: dest.icon)
////                                                    .font(.system(size: 14, weight: .medium))
////                                                    .foregroundStyle(selectedDestID == dest.id
////                                                                     ? .blue : Color(.secondaryLabel))
////                                            }
////                                            VStack(alignment: .leading, spacing: 1) {
////                                                Text(dest.name)
////                                                    .font(.subheadline)
////                                                    .fontWeight(selectedDestID == dest.id ? .semibold : .regular)
////                                                    .foregroundStyle(Color(.label))
////                                                Text(dest.sub)
////                                                    .font(.caption2)
////                                                    .foregroundStyle(Color(.secondaryLabel))
////                                            }
////                                            Spacer()
////                                            if selectedDestID == dest.id {
////                                                Image(systemName: "checkmark.circle.fill")
////                                                    .font(.system(size: 16))
////                                                    .foregroundStyle(.blue)
////                                            }
////                                        }
////                                        .padding(.horizontal, 12)
////                                        .padding(.vertical, 10)
////                                        .background(selectedDestID == dest.id
////                                                    ? Color.blue.opacity(0.05) : Color.clear)
////                                        .contentShape(Rectangle())
////                                    }
////                                    .buttonStyle(.plain)
////
////                                    if dest.id != allDestinations.last?.id {
////                                        Divider().padding(.horizontal, 12)
////                                    }
////                                }
////                            }
////                            .transition(.opacity)
////                        }
////                    }
////                    .background(Color(.secondarySystemGroupedBackground))
////                    .clipShape(RoundedRectangle(cornerRadius: 12))
////                    .overlay(
////                        RoundedRectangle(cornerRadius: 12)
////                            .stroke(Color(.separator).opacity(0.4), lineWidth: 0.5)
////                    )
////                }
////            }
////            .padding(.horizontal, 16)
////            .padding(.top, 8)
////            .padding(.bottom, 16)
////        }
////        .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
////        .cardShadow()
////    }
////
////    private func locationIcon(filled: Bool) -> some View {
////        ZStack {
////            Circle()
////                .fill(filled ? Color.blue.opacity(0.1) : Color(.secondarySystemGroupedBackground))
////                .frame(width: 36, height: 36)
////            Image(systemName: filled ? "mappin.circle.fill" : "location.circle")
////                .font(.system(size: 18, weight: .medium))
////                .foregroundStyle(filled ? .blue : Color(.secondaryLabel))
////        }
////    }
////
////    // MARK: - Indoor Navigation Thumbnail
////    private var indoorNavigationSection: some View {
////        VStack(alignment: .leading, spacing: 12) {
////            HStack(alignment: .firstTextBaseline) {
////                Text("Indoor Navigation")
////                    .font(.title3.weight(.bold))
////                    .foregroundStyle(Color(.label))
////                Spacer()
////                Text(walkTime)
////                    .font(.caption)
////                    .fontWeight(.medium)
////                    .foregroundStyle(.blue)
////                    .padding(.horizontal, 10)
////                    .padding(.vertical, 5)
////                    .background(Color.blue.opacity(0.1), in: Capsule())
////            }
////
////            VStack(spacing: 0) {
////                Button(action: { navigateToFullMap = true }) {
////                    ZStack {
////                        if UIImage(named: "hospital_map") != nil {
////                            Image("hospital_map")
////                                .resizable().scaledToFill().frame(height: 160).clipped()
////                        } else {
////                            MiniMapFallback().frame(height: 160)
////                        }
////                        VStack {
////                            HStack {
////                                Spacer()
////                                Label("Tap to expand", systemImage: "arrow.up.left.and.arrow.down.right")
////                                    .font(.system(size: 10, weight: .semibold))
////                                    .foregroundStyle(.white)
////                                    .padding(.horizontal, 8).padding(.vertical, 4)
////                                    .background(Color.black.opacity(0.40), in: Capsule())
////                                    .padding(10)
////                            }
////                            Spacer()
////                        }
////                    }
////                    .frame(height: 160)
////                }
////                .buttonStyle(.plain)
////                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 16, bottomLeadingRadius: 0,
////                                                  bottomTrailingRadius: 0, topTrailingRadius: 16))
////
////                Divider()
////
////                Button(action: { navigateToFullMap = true }) {
////                    HStack {
////                        Text("Open Full Map View").font(.callout.weight(.semibold)).foregroundStyle(.blue)
////                        Spacer()
////                        Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(Color(.tertiaryLabel))
////                    }
////                    .padding(.horizontal, 16).padding(.vertical, 14).contentShape(Rectangle())
////                }
////                .buttonStyle(.plain).scaleOnPress()
////                .background(Color(.systemBackground))
////                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 16,
////                                                  bottomTrailingRadius: 16, topTrailingRadius: 0))
////            }
////            .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
////            .cardShadow()
////        }
////    }
////
////    // MARK: - Step-by-Step Directions
////    private var textNavigationSection: some View {
////        VStack(alignment: .leading, spacing: 12) {
////            HStack {
////                Text("Step-by-Step Directions").font(.title3.weight(.bold)).foregroundStyle(Color(.label))
////                Spacer()
////                Text("180 m").font(.caption.weight(.semibold)).foregroundStyle(Color(.secondaryLabel))
////                    .padding(.horizontal, 10).padding(.vertical, 5)
////                    .background(Color(.secondarySystemGroupedBackground), in: Capsule())
////            }
////            VStack(spacing: 0) {
////                directionStep(n: 1, text: "Walk straight 20 m to central elevators", last: false)
////                directionStep(n: 2, text: "Turn right at the Pharmacy",               last: false)
////                directionStep(n: 3, text: "Take elevator to 3rd Floor",               last: false)
////                directionStep(n: 4, text: "Cardiology Clinic is on your left",        last: true)
////            }
////            .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
////            .cardShadow()
////        }
////    }
////
////    @ViewBuilder
////    private func directionStep(n: Int, text: String, last: Bool) -> some View {
////        HStack(alignment: .top, spacing: 14) {
////            VStack(spacing: 0) {
////                ZStack {
////                    Circle().fill(last ? Color.green.opacity(0.12) : Color.blue.opacity(0.1)).frame(width: 36, height: 36)
////                    if last {
////                        Image(systemName: "checkmark.circle.fill").font(.system(size: 16, weight: .semibold)).foregroundStyle(.green)
////                    } else {
////                        Text("\(n)").font(.system(size: 13, weight: .bold)).foregroundStyle(.blue)
////                    }
////                }
////                if !last { Rectangle().fill(Color(.separator)).frame(width: 1.5, height: 20) }
////            }
////            VStack(alignment: .leading, spacing: 3) {
////                Text(last ? "Arrived" : "Step \(n)").font(.caption.weight(.semibold)).foregroundStyle(last ? .green : .blue)
////                Text(text).font(.subheadline).foregroundStyle(Color(.label)).fixedSize(horizontal: false, vertical: true)
////            }.padding(.top, 8)
////            Spacer()
////        }
////        .padding(.horizontal, 16).padding(.top, 14).padding(.bottom, last ? 16 : 4)
////        if !last { Divider().padding(.leading, 66) }
////    }
////}
////
////// MARK: - Mini Map Fallback
////private struct MiniMapFallback: View {
////    var body: some View {
////        GeometryReader { geo in
////            let w = geo.size.width; let h = geo.size.height
////            ZStack {
////                Color(hex: "#E2E8F4")
////                Path { p in
////                    stride(from: CGFloat(0), to: w, by: w/9).forEach { x in
////                        p.move(to: .init(x: x, y: 0)); p.addLine(to: .init(x: x, y: h))
////                    }
////                    stride(from: CGFloat(0), to: h, by: h/7).forEach { y in
////                        p.move(to: .init(x: 0, y: y)); p.addLine(to: .init(x: w, y: y))
////                    }
////                }.stroke(Color.white.opacity(0.45), lineWidth: 0.5)
////                miniBlock(x: w*0.13, y: h*0.42, w: w*0.20, h: h*0.36, label: "EMERGENCY", color: Color(hex: "#A4AECB"))
////                miniBlock(x: w*0.50, y: h*0.32, w: w*0.18, h: h*0.26, label: "SURGERY",   color: Color(hex: "#8F9EC0"))
////                miniBlock(x: w*0.79, y: h*0.26, w: w*0.16, h: h*0.22, label: "PHARMACY",  color: Color(hex: "#A4AECB"))
////                miniBlock(x: w*0.79, y: h*0.66, w: w*0.16, h: h*0.22, label: "OPD",       color: Color(hex: "#3A7BF7").opacity(0.75))
////                Capsule().fill(Color(hex: "#C2CCE4")).frame(width: w*0.72, height: 12).position(x: w*0.50, y: h*0.57)
////                HospitalRouteOverlay(start: CGPoint(x: 0.13, y: 0.88), end: CGPoint(x: 0.79, y: 0.51),
////                                     size: CGSize(width: w, height: h))
////                Circle().fill(Color(hex: "#34C759")).frame(width: 9, height: 9)
////                    .overlay(Circle().stroke(.white, lineWidth: 2)).position(x: w*0.13, y: h*0.88)
////                Image(systemName: "mappin.circle.fill").font(.system(size: 15))
////                    .foregroundStyle(Color(hex: "#3A7BF7")).position(x: w*0.79, y: h*0.46)
////            }
////        }
////    }
////    private func miniBlock(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, label: String, color: Color) -> some View {
////        ZStack {
////            RoundedRectangle(cornerRadius: 3).fill(color).frame(width: w, height: h).position(x: x, y: y)
////            Text(label).font(.system(size: 5.5, weight: .bold)).foregroundStyle(.white).position(x: x, y: y)
////        }
////    }
////}
////
////// MARK: - Route Overlay
////struct HospitalRouteOverlay: View {
////    let start: CGPoint; let end: CGPoint; let size: CGSize
////    private let accent = Color.blue
////    var body: some View {
////        Canvas { ctx, _ in
////            let s = CGPoint(x: start.x * size.width, y: start.y * size.height)
////            let e = CGPoint(x: end.x * size.width, y: end.y * size.height)
////            let midY = size.height * 0.40
////            var path = Path()
////            path.move(to: s)
////            path.addLine(to: CGPoint(x: s.x, y: midY))
////            path.addLine(to: CGPoint(x: e.x, y: midY))
////            path.addLine(to: e)
////            ctx.stroke(path, with: .color(accent.opacity(0.18)),
////                       style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
////            ctx.stroke(path, with: .color(accent),
////                       style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round, dash: [8, 6]))
////            for t: CGFloat in [0.35, 0.65] {
////                let px = s.x + (e.x - s.x) * t
////                var a = Path()
////                a.move(to: CGPoint(x: px - 6, y: midY - 5))
////                a.addLine(to: CGPoint(x: px, y: midY))
////                a.addLine(to: CGPoint(x: px - 6, y: midY + 5))
////                ctx.stroke(a, with: .color(accent), style: StrokeStyle(lineWidth: 2, lineCap: .round))
////            }
////        }
////    }
////}
////
////// MARK: - QR Scan View
////struct QRScanView: View {
////    @Environment(\.dismiss) private var dismiss
////    @State private var scanLineOffset: CGFloat = -120
////    @State private var isScanning   = true
////    @State private var didDetect    = false
////    @State private var pulseCorners = false
////    @State private var flashEnabled = false
////    @State private var showSuccess  = false
////    private let simulatedLocation = "Cardiology Clinic – 3rd Floor, Wing B"
////
////    var body: some View {
////        ZStack {
////            Color.black.ignoresSafeArea()
////            if !showSuccess { scannerContent } else { successOverlay }
////        }
////        .navigationTitle("Scan Location QR")
////        .navigationBarTitleDisplayMode(.inline)
////        .toolbarBackground(.black, for: .navigationBar)
////        .toolbarBackground(.visible, for: .navigationBar)
////        .toolbarColorScheme(.dark, for: .navigationBar)
////        .toolbar {
////            ToolbarItem(placement: .navigationBarTrailing) {
////                Button(action: { flashEnabled.toggle() }) {
////                    Image(systemName: flashEnabled ? "bolt.fill" : "bolt.slash.fill")
////                        .foregroundStyle(flashEnabled ? .yellow : .white)
////                        .font(.system(size: 16, weight: .medium))
////                }
////            }
////        }
////        .onAppear { startScanAnimation() }
////    }
////
////    private var scannerContent: some View {
////        ZStack {
////            LinearGradient(colors: [Color(white: 0.08), Color(white: 0.14), Color(white: 0.07)],
////                           startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
////            VStack(spacing: 0) {
////                Spacer()
////                Text("Point your camera at a location QR code")
////                    .font(.subheadline).foregroundStyle(.white.opacity(0.85))
////                    .multilineTextAlignment(.center).padding(.horizontal, 40).padding(.bottom, 32)
////                ZStack {
////                    GeometryReader { geo in
////                        let boxSize: CGFloat = 260
////                        let ox = (geo.size.width - boxSize) / 2
////                        let oy = (geo.size.height - boxSize) / 2
////                        Path { p in
////                            p.addRect(CGRect(origin: .zero, size: geo.size))
////                            p.addRoundedRect(in: CGRect(x: ox, y: oy, width: boxSize, height: boxSize),
////                                             cornerRadii: RectangleCornerRadii(topLeading: 16, bottomLeading: 16,
////                                                                               bottomTrailing: 16, topTrailing: 16))
////                        }
////                        .fill(style: FillStyle(eoFill: true)).foregroundStyle(.black.opacity(0.65))
////                        RoundedRectangle(cornerRadius: 1)
////                            .fill(LinearGradient(colors: [.clear, .green.opacity(0.9), .clear],
////                                                 startPoint: .leading, endPoint: .trailing))
////                            .frame(width: boxSize - 20, height: 2)
////                            .offset(x: ox + 10, y: oy + 10 + scanLineOffset + 120)
////                            .opacity(isScanning ? 1 : 0)
////                    }.frame(height: 260)
////                    CornerBrackets(size: 260, cornerLength: 28, color: didDetect ? .green : .white, pulse: pulseCorners)
////                }.frame(width: 260, height: 260)
////                Spacer().frame(height: 40)
////                statusPill
////                Spacer()
////                VStack(spacing: 12) {
////                    HStack(spacing: 6) {
////                        Image(systemName: "info.circle").font(.caption)
////                        Text("QR codes are placed at every department entrance").font(.caption)
////                    }.foregroundStyle(.white.opacity(0.5))
////                    Button(action: simulateScan) {
////                        Label("Simulate Scan (Demo)", systemImage: "qrcode")
////                            .font(.footnote.weight(.semibold)).foregroundStyle(.white)
////                            .padding(.horizontal, 20).padding(.vertical, 10)
////                            .background(.white.opacity(0.12), in: Capsule())
////                    }
////                }.padding(.bottom, 48)
////            }
////        }
////    }
////
////    private var statusPill: some View {
////        HStack(spacing: 8) {
////            if didDetect {
////                Image(systemName: "checkmark.circle.fill").foregroundStyle(.green)
////                Text("QR Code Detected!").fontWeight(.semibold)
////            } else {
////                ProgressView().tint(.white).scaleEffect(0.8)
////                Text("Scanning…")
////            }
////        }
////        .font(.subheadline).foregroundStyle(.white)
////        .padding(.horizontal, 20).padding(.vertical, 10)
////        .background(.white.opacity(0.12), in: Capsule())
////        .animation(.easeInOut(duration: 0.3), value: didDetect)
////    }
////
////    private var successOverlay: some View {
////        ZStack {
////            Color(.systemGroupedBackground).ignoresSafeArea()
////            VStack(spacing: 32) {
////                Spacer()
////                ZStack {
////                    Circle().fill(Color.green.opacity(0.12)).frame(width: 120, height: 120)
////                    Circle().fill(Color.green.opacity(0.20)).frame(width: 90, height: 90)
////                    Image(systemName: "checkmark.circle.fill").font(.system(size: 52)).foregroundStyle(.green)
////                }
////                VStack(spacing: 8) {
////                    Text("Location Confirmed").font(.title2.weight(.bold)).foregroundStyle(Color(.label))
////                    Text(simulatedLocation).font(.body).foregroundStyle(Color(.secondaryLabel)).multilineTextAlignment(.center)
////                }
////                VStack(spacing: 0) {
////                    infoRow(icon: "map.fill",       color: .blue,   label: "Department",  value: "OPD – Cardiology")
////                    Divider().padding(.horizontal, 16)
////                    infoRow(icon: "arrow.up.right", color: .orange, label: "Floor",        value: "3rd Floor, Wing B")
////                    Divider().padding(.horizontal, 16)
////                    infoRow(icon: "figure.walk",    color: .green,  label: "Walking Time", value: "~3 minutes")
////                }
////                .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
////                .shadow(color: .black.opacity(0.05), radius: 12, y: 4).padding(.horizontal, 24)
////                Spacer()
////                VStack(spacing: 12) {
////                    Button(action: { dismiss() }) {
////                        Text("Start Navigation").font(.body.weight(.semibold)).foregroundStyle(.white)
////                            .frame(maxWidth: .infinity).padding(.vertical, 16)
////                            .background(LinearGradient(colors: [Color(hex: "#4A7CF7"), Color(hex: "#2F5FD8")],
////                                                       startPoint: .leading, endPoint: .trailing),
////                                        in: RoundedRectangle(cornerRadius: 14))
////                            .shadow(color: Color.blue.opacity(0.30), radius: 10, y: 5)
////                    }
////                    Button(action: rescan) {
////                        Text("Scan Again").font(.body.weight(.medium)).foregroundStyle(.blue)
////                    }
////                }.padding(.horizontal, 24).padding(.bottom, 40)
////            }
////        }
////    }
////
////    private func infoRow(icon: String, color: Color, label: String, value: String) -> some View {
////        HStack(spacing: 14) {
////            ZStack {
////                RoundedRectangle(cornerRadius: 8).fill(color.opacity(0.12)).frame(width: 36, height: 36)
////                Image(systemName: icon).font(.system(size: 15, weight: .medium)).foregroundStyle(color)
////            }
////            Text(label).font(.subheadline).foregroundStyle(Color(.secondaryLabel))
////            Spacer()
////            Text(value).font(.subheadline.weight(.semibold)).foregroundStyle(Color(.label))
////        }
////        .padding(.horizontal, 16).padding(.vertical, 14)
////    }
////
////    private func startScanAnimation() {
////        isScanning = true; didDetect = false; showSuccess = false; scanLineOffset = -120
////        withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) { scanLineOffset = 120 }
////        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { simulateScan() }
////    }
////    private func simulateScan() {
////        UINotificationFeedbackGenerator().notificationOccurred(.success)
////        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) { didDetect = true; pulseCorners = true }
////        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
////            withAnimation(.easeInOut(duration: 0.45)) { showSuccess = true }
////        }
////    }
////    private func rescan() {
////        withAnimation(.easeInOut(duration: 0.3)) { showSuccess = false }
////        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { startScanAnimation() }
////    }
////}
////
////// MARK: - SimpleHospitalMapView
////struct SimpleHospitalMapView: View {
////    @Environment(\.dismiss) private var dismiss
////    private let assetName = "hospital_map"
////    private let userPos = CGPoint(x: 0.18, y: 0.82)
////    private let destPos = CGPoint(x: 0.80, y: 0.28)
////
////    var body: some View {
////        ScrollView(showsIndicators: false) {
////            VStack(alignment: .leading, spacing: 20) {
////                GeometryReader { geo in
////                    ZStack {
////                        mapBackground(size: geo.size)
////                        HospitalRouteOverlay(start: userPos, end: destPos, size: geo.size)
////                        HospitalMapPin(pos: userPos, color: .green, icon: "location.circle.fill", label: "You are here", size: geo.size)
////                        HospitalMapPin(pos: destPos, color: .blue,  icon: "heart.circle.fill",    label: "Cardiology",   size: geo.size)
////                    }
////                    .clipShape(RoundedRectangle(cornerRadius: 20))
////                    .shadow(color: .black.opacity(0.10), radius: 12, y: 5)
////                }
////                .frame(height: 340).padding(.horizontal, 16)
////
////                HStack(spacing: 0) {
////                    routeEndpoint(icon: "location.circle.fill", color: .green, label: "FROM", name: "Main Reception",   sub: "Ground Floor")
////                    VStack(spacing: 4) {
////                        Image(systemName: "arrow.right").font(.system(size: 13, weight: .semibold)).foregroundStyle(Color(.tertiaryLabel))
////                        Text("3 min").font(.caption2.weight(.semibold)).foregroundStyle(.blue)
////                    }.frame(maxWidth: .infinity)
////                    routeEndpoint(icon: "heart.circle.fill",    color: .blue,  label: "TO",   name: "Cardiology Clinic", sub: "3rd Floor, Wing B")
////                }
////                .padding(16)
////                .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
////                .shadow(color: .black.opacity(0.05), radius: 8, y: 3).padding(.horizontal, 16)
////
////                VStack(alignment: .leading, spacing: 12) {
////                    HStack {
////                        Text("Directions").font(.headline)
////                        Spacer()
////                        Text("180 m").font(.caption.weight(.semibold)).foregroundStyle(Color(.secondaryLabel))
////                            .padding(.horizontal, 10).padding(.vertical, 5)
////                            .background(Color(.secondarySystemGroupedBackground), in: Capsule())
////                    }.padding(.horizontal, 4)
////                    VStack(spacing: 0) {
////                        directionStep(n: 1, text: "Walk straight 20 m to central elevators", last: false)
////                        directionStep(n: 2, text: "Turn right at the Pharmacy",               last: false)
////                        directionStep(n: 3, text: "Take elevator to 3rd Floor",               last: false)
////                        directionStep(n: 4, text: "Cardiology Clinic is on your left",        last: true)
////                    }
////                    .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
////                    .shadow(color: .black.opacity(0.05), radius: 8, y: 3)
////                }.padding(.horizontal, 16)
////                
////                // "Start Navigation" button removed here as requested.
////            }.padding(.top, 16)
////        }
////        .background(Color(.systemGroupedBackground))
////        .navigationTitle("Indoor Navigation")
////        .navigationBarTitleDisplayMode(.large)
////    }
////
////    @ViewBuilder
////    private func mapBackground(size: CGSize) -> some View {
////        if UIImage(named: assetName) != nil {
////            Image(assetName).resizable().scaledToFill().frame(width: size.width, height: size.height).clipped()
////        } else {
////            ZStack {
////                Color(hex: "#E8EDF6")
////                VStack(spacing: 8) {
////                    Image(systemName: "map").font(.system(size: 44)).foregroundStyle(Color.blue.opacity(0.4))
////                    Text("Add \"\(assetName)\" to Assets.xcassets")
////                        .font(.caption).foregroundStyle(Color(.secondaryLabel))
////                        .multilineTextAlignment(.center).padding(.horizontal, 20)
////                }
////            }.frame(width: size.width, height: size.height)
////        }
////    }
////
////    private func routeEndpoint(icon: String, color: Color, label: String, name: String, sub: String) -> some View {
////        HStack(spacing: 10) {
////            ZStack {
////                Circle().fill(color.opacity(0.12)).frame(width: 38, height: 38)
////                Image(systemName: icon).font(.system(size: 18)).foregroundStyle(color)
////            }
////            VStack(alignment: .leading, spacing: 2) {
////                Text(label).font(.caption2.weight(.semibold)).foregroundStyle(Color(.tertiaryLabel)).tracking(0.5)
////                Text(name).font(.footnote.weight(.semibold)).foregroundStyle(Color(.label))
////                Text(sub).font(.caption2).foregroundStyle(Color(.secondaryLabel))
////            }
////        }.frame(maxWidth: .infinity, alignment: .leading)
////    }
////
////    @ViewBuilder
////    private func directionStep(n: Int, text: String, last: Bool) -> some View {
////        HStack(alignment: .top, spacing: 14) {
////            VStack(spacing: 0) {
////                ZStack {
////                    Circle().fill(last ? Color.green.opacity(0.12) : Color.blue.opacity(0.10)).frame(width: 36, height: 36)
////                    if last {
////                        Image(systemName: "checkmark.circle.fill").font(.system(size: 16, weight: .semibold)).foregroundStyle(.green)
////                    } else {
////                        Text("\(n)").font(.system(size: 13, weight: .bold)).foregroundStyle(.blue)
////                    }
////                }
////                if !last { Rectangle().fill(Color.blue.opacity(0.20)).frame(width: 1.5, height: 20) }
////            }
////            VStack(alignment: .leading, spacing: 3) {
////                Text(last ? "Arrived" : "Step \(n)").font(.caption.weight(.semibold)).foregroundStyle(last ? .green : .blue)
////                Text(text).font(.subheadline).foregroundStyle(Color(.label)).fixedSize(horizontal: false, vertical: true)
////            }.padding(.top, 8)
////            Spacer()
////        }
////        .padding(.horizontal, 16).padding(.top, 14).padding(.bottom, last ? 16 : 4)
////        if !last { Divider().padding(.leading, 66) }
////    }
////}
////
////struct HospitalMapPin: View {
////    let pos: CGPoint; let color: Color; let icon: String; let label: String; let size: CGSize
////    var body: some View {
////        VStack(spacing: 2) {
////            ZStack {
////                Circle().fill(color.opacity(0.20)).frame(width: 46, height: 46)
////                Circle().fill(color).frame(width: 32, height: 32).shadow(color: color.opacity(0.40), radius: 5, y: 3)
////                Image(systemName: icon).font(.system(size: 15, weight: .medium)).foregroundStyle(.white)
////            }
////            Text(label).font(.system(size: 9, weight: .bold)).foregroundStyle(.white)
////                .padding(.horizontal, 7).padding(.vertical, 3)
////                .background(color, in: Capsule())
////                .shadow(color: color.opacity(0.35), radius: 3, y: 2)
////        }
////        .position(x: pos.x * size.width, y: pos.y * size.height - 28)
////    }
////}
////
////// MARK: - Corner Brackets
////private struct CornerBrackets: View {
////    let size: CGFloat; let cornerLength: CGFloat; let color: Color; let pulse: Bool
////    var body: some View {
////        ZStack {
////            cornerShape(rotation: 0).offset(x: -(size/2 - cornerLength/2 + 1), y: -(size/2 - cornerLength/2 + 1))
////            cornerShape(rotation: 90).offset(x:  (size/2 - cornerLength/2 + 1), y: -(size/2 - cornerLength/2 + 1))
////            cornerShape(rotation: 270).offset(x: -(size/2 - cornerLength/2 + 1), y:  (size/2 - cornerLength/2 + 1))
////            cornerShape(rotation: 180).offset(x:  (size/2 - cornerLength/2 + 1), y:  (size/2 - cornerLength/2 + 1))
////        }
////        .scaleEffect(pulse ? 1.04 : 1.0)
////        .animation(.easeInOut(duration: 0.35), value: pulse)
////    }
////    private func cornerShape(rotation: Double) -> some View {
////        CornerBracketShape(length: cornerLength)
////            .stroke(color, style: StrokeStyle(lineWidth: 3, lineCap: .round))
////            .frame(width: cornerLength, height: cornerLength)
////            .rotationEffect(.degrees(rotation))
////    }
////}
////
////private struct CornerBracketShape: Shape {
////    let length: CGFloat
////    func path(in rect: CGRect) -> Path {
////        var p = Path()
////        p.move(to: CGPoint(x: 0, y: length))
////        p.addLine(to: CGPoint(x: 0, y: 0))
////        p.addLine(to: CGPoint(x: length, y: 0))
////        return p
////    }
////}
////
////// MARK: - View Modifiers
////private struct CardShadow: ViewModifier {
////    func body(content: Content) -> some View {
////        content.shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 4)
////    }
////}
////
////private struct ScaleOnPress: ViewModifier {
////    @State private var pressing = false
////    func body(content: Content) -> some View {
////        content
////            .scaleEffect(pressing ? 0.97 : 1.0)
////            .animation(.easeInOut(duration: 0.1), value: pressing)
////            .simultaneousGesture(
////                DragGesture(minimumDistance: 0)
////                    .onChanged { _ in pressing = true }
////                    .onEnded   { _ in pressing = false }
////            )
////    }
////}
////
////extension View {
////    func cardShadow() -> some View   { modifier(CardShadow()) }
////    func scaleOnPress() -> some View { modifier(ScaleOnPress()) }
////}
////
////// Color(hex:) is already defined elsewhere in your project.
////
////#Preview {
////    NavigationStack { HNavigationScreen() }
////}
//
//
//import SwiftUI
//
//// NOTE: HospitalDestination, NavigationStep, and allDestinations are defined
//// in your existing project file — do not redeclare them here.
//
//struct HNavigationScreen: View {
//    @State private var navigateToQR      = false
//    @State private var navigateToFullMap = false
//    @State private var selectedDestID    = 0
//    @State private var isDropdownOpen    = false  // ← lifted here, prevents state reset
//
//    private let currentNumber   = 45
//    private let yourNumber      = 55
//    private let department      = "OPD"
//    private let currentLocation = "Main Reception, Ground Floor"
//    private let walkTime        = "3 min walk"
//
//    private var selectedDest: HospitalDestination {
//        allDestinations.first { $0.id == selectedDestID } ?? allDestinations[0]
//    }
//
//    var body: some View {
//        ZStack {
//            Color(.systemGroupedBackground).ignoresSafeArea()
//
//            ScrollView(showsIndicators: false) {
//                VStack(alignment: .leading, spacing: 24) {
//                    liveQueueSection
//                    scanQRButton
//                    locationSection
//                    indoorNavigationSection
//                    textNavigationSection
//                    Color.clear.frame(height: 20)
//                }
//                .padding(.horizontal, 16)
//                .padding(.top, 12)
//            }
//
//            NavigationLink(destination: QRScanView(), isActive: $navigateToQR) {
//                EmptyView()
//            }.hidden()
//
//            NavigationLink(destination: SimpleHospitalMapView(), isActive: $navigateToFullMap) {
//                EmptyView()
//            }.hidden()
//        }
//        .navigationTitle("Navigation")
//        .navigationBarTitleDisplayMode(.large)
//    }
//
//    // MARK: - Live Queue
//    private var liveQueueSection: some View {
//        VStack(spacing: 0) {
//            HStack {
//                HStack(spacing: 6) {
//                    Circle()
//                        .fill(Color.green)
//                        .frame(width: 8, height: 8)
//                        .overlay(Circle().stroke(Color.green.opacity(0.35), lineWidth: 3))
//                    Text("Live Queue Status")
//                        .font(.subheadline)
//                        .fontWeight(.semibold)
//                        .foregroundStyle(.primary)
//                }
//                Spacer()
//                Text("Dept: \(department)")
//                    .font(.caption)
//                    .fontWeight(.medium)
//                    .foregroundStyle(.secondary)
//                    .padding(.horizontal, 10)
//                    .padding(.vertical, 5)
//                    .background(Capsule().fill(Color(.secondarySystemBackground)))
//            }
//            .padding(.horizontal, 16)
//            .padding(.top, 14)
//            .padding(.bottom, 12)
//
//            Divider().padding(.horizontal, 16)
//
//            HStack(spacing: 0) {
//                VStack(spacing: 4) {
//                    Text("Current Number")
//                        .font(.caption)
//                        .foregroundStyle(.secondary)
//                    Text("\(currentNumber)")
//                        .font(.system(size: 34, weight: .bold))
//                        .foregroundStyle(.primary)
//                }
//                .frame(maxWidth: .infinity)
//
//                Rectangle()
//                    .fill(Color(.separator))
//                    .frame(width: 1, height: 48)
//
//                VStack(spacing: 4) {
//                    Text("Your Number")
//                        .font(.caption)
//                        .foregroundStyle(.secondary)
//                    Text("\(yourNumber)")
//                        .font(.system(size: 34, weight: .bold))
//                        .foregroundStyle(.blue)
//                }
//                .frame(maxWidth: .infinity)
//            }
//            .padding(.vertical, 14)
//        }
//        .background(
//            RoundedRectangle(cornerRadius: 16)
//                .fill(Color(.systemBackground))
//                .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
//        )
//    }
//
//    // MARK: - Scan QR Button with Gradient
//    private var scanQRButton: some View {
//        Button(action: { navigateToQR = true }) {
//            Label("Scan Location QR", systemImage: "qrcode.viewfinder")
//                .font(.body.weight(.semibold))
//                .foregroundStyle(.white)
//                .frame(maxWidth: .infinity)
//                .padding(.vertical, 16)
//                .background(
//                    LinearGradient(
//                        colors: [.blue, .cyan],
//                        startPoint: .leading,
//                        endPoint: .trailing
//                    )
//                )
//                .clipShape(RoundedRectangle(cornerRadius: 12))
//                .shadow(color: .blue.opacity(0.3), radius: 12, x: 0, y: 6)
//        }
//        .buttonStyle(.plain)
//        .scaleOnPress()
//    }
//
//    // MARK: - Location Section
//    private var locationSection: some View {
//        VStack(spacing: 0) {
//            // Current Location row
//            HStack(alignment: .center, spacing: 12) {
//                locationIcon(filled: false)
//                VStack(alignment: .leading, spacing: 2) {
//                    Text("CURRENT LOCATION")
//                        .font(.caption2.weight(.semibold))
//                        .foregroundStyle(Color(.tertiaryLabel))
//                        .tracking(0.5)
//                    Text(currentLocation)
//                        .font(.callout.weight(.semibold))
//                        .foregroundStyle(Color(.label))
//                }
//                Spacer()
//            }
//            .padding(.horizontal, 16)
//            .padding(.top, 16)
//            .padding(.bottom, 8)
//
//            // Connector line
//            HStack {
//                Spacer().frame(width: 34)
//                Rectangle()
//                    .fill(Color(.separator))
//                    .frame(width: 1.5, height: 22)
//                Spacer()
//            }
//
//            // Destination row
//            HStack(alignment: .top, spacing: 12) {
//                locationIcon(filled: true)
//                    .padding(.top, 2)
//
//                VStack(alignment: .leading, spacing: 8) {
//                    Text("SELECT DESTINATION")
//                        .font(.caption2.weight(.semibold))
//                        .foregroundStyle(Color(.tertiaryLabel))
//                        .tracking(0.5)
//
//                    // ── Inline dropdown (state owned by parent) ──
//                    VStack(spacing: 0) {
//
//                        // Header — always visible, tap to toggle
//                        Button {
//                            withAnimation(.easeInOut(duration: 0.25)) {
//                                isDropdownOpen.toggle()
//                            }
//                        } label: {
//                            HStack(spacing: 12) {
//                                ZStack {
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .fill(Color.blue.opacity(0.10))
//                                        .frame(width: 38, height: 38)
//                                    Image(systemName: selectedDest.icon)
//                                        .font(.system(size: 17, weight: .medium))
//                                        .foregroundStyle(.blue)
//                                }
//                                VStack(alignment: .leading, spacing: 2) {
//                                    Text(selectedDest.name)
//                                        .font(.callout.weight(.semibold))
//                                        .foregroundStyle(Color(.label))
//                                        .lineLimit(1)
//                                    Text(selectedDest.sub)
//                                        .font(.caption)
//                                        .foregroundStyle(Color(.secondaryLabel))
//                                }
//                                Spacer()
//                                Image(systemName: "chevron.down")
//                                    .font(.system(size: 13, weight: .semibold))
//                                    .foregroundStyle(Color(.secondaryLabel))
//                                    .rotationEffect(.degrees(isDropdownOpen ? 180 : 0))
//                                    .animation(.easeInOut(duration: 0.25), value: isDropdownOpen)
//                            }
//                            .padding(.horizontal, 12)
//                            .padding(.vertical, 12)
//                            .contentShape(Rectangle())
//                        }
//                        .buttonStyle(.plain)
//
//                        // Expanded list — shown/hidden based on isDropdownOpen
//                        if isDropdownOpen {
//                            Divider().padding(.horizontal, 12)
//
//                            VStack(spacing: 0) {
//                                ForEach(allDestinations) { dest in
//                                    Button {
//                                        withAnimation(.easeInOut(duration: 0.2)) {
//                                            selectedDestID = dest.id
//                                            isDropdownOpen = false
//                                        }
//                                    } label: {
//                                        HStack(spacing: 12) {
//                                            ZStack {
//                                                RoundedRectangle(cornerRadius: 6)
//                                                    .fill(selectedDestID == dest.id
//                                                          ? Color.blue.opacity(0.12)
//                                                          : Color(.tertiarySystemGroupedBackground))
//                                                    .frame(width: 32, height: 32)
//                                                Image(systemName: dest.icon)
//                                                    .font(.system(size: 14, weight: .medium))
//                                                    .foregroundStyle(selectedDestID == dest.id
//                                                                     ? .blue : Color(.secondaryLabel))
//                                            }
//                                            VStack(alignment: .leading, spacing: 1) {
//                                                Text(dest.name)
//                                                    .font(.subheadline)
//                                                    .fontWeight(selectedDestID == dest.id ? .semibold : .regular)
//                                                    .foregroundStyle(Color(.label))
//                                                Text(dest.sub)
//                                                    .font(.caption2)
//                                                    .foregroundStyle(Color(.secondaryLabel))
//                                            }
//                                            Spacer()
//                                            if selectedDestID == dest.id {
//                                                Image(systemName: "checkmark.circle.fill")
//                                                    .font(.system(size: 16))
//                                                    .foregroundStyle(.blue)
//                                            }
//                                        }
//                                        .padding(.horizontal, 12)
//                                        .padding(.vertical, 10)
//                                        .background(selectedDestID == dest.id
//                                                    ? Color.blue.opacity(0.05) : Color.clear)
//                                        .contentShape(Rectangle())
//                                    }
//                                    .buttonStyle(.plain)
//
//                                    if dest.id != allDestinations.last?.id {
//                                        Divider().padding(.horizontal, 12)
//                                    }
//                                }
//                            }
//                            .transition(.opacity)
//                        }
//                    }
//                    .background(Color(.secondarySystemGroupedBackground))
//                    .clipShape(RoundedRectangle(cornerRadius: 12))
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 12)
//                            .stroke(Color(.separator).opacity(0.4), lineWidth: 0.5)
//                    )
//                }
//            }
//            .padding(.horizontal, 16)
//            .padding(.top, 8)
//            .padding(.bottom, 16)
//        }
//        .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
//        .cardShadow()
//    }
//
//    private func locationIcon(filled: Bool) -> some View {
//        ZStack {
//            Circle()
//                .fill(filled ? Color.blue.opacity(0.1) : Color(.secondarySystemGroupedBackground))
//                .frame(width: 36, height: 36)
//            Image(systemName: filled ? "mappin.circle.fill" : "location.circle")
//                .font(.system(size: 18, weight: .medium))
//                .foregroundStyle(filled ? .blue : Color(.secondaryLabel))
//        }
//    }
//
//    // MARK: - Indoor Navigation Thumbnail
//    private var indoorNavigationSection: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            HStack(alignment: .firstTextBaseline) {
//                Text("Indoor Navigation")
//                    .font(.title3.weight(.bold))
//                    .foregroundStyle(Color(.label))
//                Spacer()
//                Text(walkTime)
//                    .font(.caption)
//                    .fontWeight(.medium)
//                    .foregroundStyle(.blue)
//                    .padding(.horizontal, 10)
//                    .padding(.vertical, 5)
//                    .background(Color.blue.opacity(0.1), in: Capsule())
//            }
//
//            VStack(spacing: 0) {
//                Button(action: { navigateToFullMap = true }) {
//                    ZStack {
//                        if UIImage(named: "hospital_map") != nil {
//                            Image("hospital_map")
//                                .resizable().scaledToFill().frame(height: 160).clipped()
//                        } else {
//                            MiniMapFallback().frame(height: 160)
//                        }
//                        VStack {
//                            HStack {
//                                Spacer()
//                                Label("Tap to expand", systemImage: "arrow.up.left.and.arrow.down.right")
//                                    .font(.system(size: 10, weight: .semibold))
//                                    .foregroundStyle(.white)
//                                    .padding(.horizontal, 8).padding(.vertical, 4)
//                                    .background(Color.black.opacity(0.40), in: Capsule())
//                                    .padding(10)
//                            }
//                            Spacer()
//                        }
//                    }
//                    .frame(height: 160)
//                }
//                .buttonStyle(.plain)
//                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 16, bottomLeadingRadius: 0,
//                                                  bottomTrailingRadius: 0, topTrailingRadius: 16))
//
//                Divider()
//
//                Button(action: { navigateToFullMap = true }) {
//                    HStack {
//                        Text("Open Full Map View").font(.callout.weight(.semibold)).foregroundStyle(.blue)
//                        Spacer()
//                        Image(systemName: "chevron.right").font(.footnote.weight(.semibold)).foregroundStyle(Color(.tertiaryLabel))
//                    }
//                    .padding(.horizontal, 16).padding(.vertical, 14).contentShape(Rectangle())
//                }
//                .buttonStyle(.plain).scaleOnPress()
//                .background(Color(.systemBackground))
//                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 16,
//                                                  bottomTrailingRadius: 16, topTrailingRadius: 0))
//            }
//            .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
//            .cardShadow()
//        }
//    }
//
//    // MARK: - Step-by-Step Directions
//    private var textNavigationSection: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            HStack {
//                Text("Step-by-Step Directions").font(.title3.weight(.bold)).foregroundStyle(Color(.label))
//                Spacer()
//                Text("180 m").font(.caption.weight(.semibold)).foregroundStyle(Color(.secondaryLabel))
//                    .padding(.horizontal, 10).padding(.vertical, 5)
//                    .background(Color(.secondarySystemGroupedBackground), in: Capsule())
//            }
//            VStack(spacing: 0) {
//                directionStep(n: 1, text: "Walk straight 20 m to central elevators", last: false)
//                directionStep(n: 2, text: "Turn right at the Pharmacy",               last: false)
//                directionStep(n: 3, text: "Take elevator to 3rd Floor",               last: false)
//                directionStep(n: 4, text: "Cardiology Clinic is on your left",        last: true)
//            }
//            .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
//            .cardShadow()
//        }
//    }
//
//    @ViewBuilder
//    private func directionStep(n: Int, text: String, last: Bool) -> some View {
//        HStack(alignment: .top, spacing: 14) {
//            VStack(spacing: 0) {
//                ZStack {
//                    Circle().fill(last ? Color.green.opacity(0.12) : Color.blue.opacity(0.1)).frame(width: 36, height: 36)
//                    if last {
//                        Image(systemName: "checkmark.circle.fill").font(.system(size: 16, weight: .semibold)).foregroundStyle(.green)
//                    } else {
//                        Text("\(n)").font(.system(size: 13, weight: .bold)).foregroundStyle(.blue)
//                    }
//                }
//                if !last { Rectangle().fill(Color(.separator)).frame(width: 1.5, height: 20) }
//            }
//            VStack(alignment: .leading, spacing: 3) {
//                Text(last ? "Arrived" : "Step \(n)").font(.caption.weight(.semibold)).foregroundStyle(last ? .green : .blue)
//                Text(text).font(.subheadline).foregroundStyle(Color(.label)).fixedSize(horizontal: false, vertical: true)
//            }.padding(.top, 8)
//            Spacer()
//        }
//        .padding(.horizontal, 16).padding(.top, 14).padding(.bottom, last ? 16 : 4)
//        if !last { Divider().padding(.leading, 66) }
//    }
//}
//
//// MARK: - Mini Map Fallback
//private struct MiniMapFallback: View {
//    var body: some View {
//        GeometryReader { geo in
//            let w = geo.size.width; let h = geo.size.height
//            ZStack {
//                Color(hex: "#E2E8F4")
//                Path { p in
//                    stride(from: CGFloat(0), to: w, by: w/9).forEach { x in
//                        p.move(to: .init(x: x, y: 0)); p.addLine(to: .init(x: x, y: h))
//                    }
//                    stride(from: CGFloat(0), to: h, by: h/7).forEach { y in
//                        p.move(to: .init(x: 0, y: y)); p.addLine(to: .init(x: w, y: y))
//                    }
//                }.stroke(Color.white.opacity(0.45), lineWidth: 0.5)
//                miniBlock(x: w*0.13, y: h*0.42, w: w*0.20, h: h*0.36, label: "EMERGENCY", color: Color(hex: "#A4AECB"))
//                miniBlock(x: w*0.50, y: h*0.32, w: w*0.18, h: h*0.26, label: "SURGERY",   color: Color(hex: "#8F9EC0"))
//                miniBlock(x: w*0.79, y: h*0.26, w: w*0.16, h: h*0.22, label: "PHARMACY",  color: Color(hex: "#A4AECB"))
//                miniBlock(x: w*0.79, y: h*0.66, w: w*0.16, h: h*0.22, label: "OPD",       color: Color(hex: "#3A7BF7").opacity(0.75))
//                Capsule().fill(Color(hex: "#C2CCE4")).frame(width: w*0.72, height: 12).position(x: w*0.50, y: h*0.57)
//                HospitalRouteOverlay(start: CGPoint(x: 0.13, y: 0.88), end: CGPoint(x: 0.79, y: 0.51),
//                                     size: CGSize(width: w, height: h))
//                Circle().fill(Color(hex: "#34C759")).frame(width: 9, height: 9)
//                    .overlay(Circle().stroke(.white, lineWidth: 2)).position(x: w*0.13, y: h*0.88)
//                Image(systemName: "mappin.circle.fill").font(.system(size: 15))
//                    .foregroundStyle(Color(hex: "#3A7BF7")).position(x: w*0.79, y: h*0.46)
//            }
//        }
//    }
//    private func miniBlock(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, label: String, color: Color) -> some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 3).fill(color).frame(width: w, height: h).position(x: x, y: y)
//            Text(label).font(.system(size: 5.5, weight: .bold)).foregroundStyle(.white).position(x: x, y: y)
//        }
//    }
//}
//
//// MARK: - Route Overlay
//struct HospitalRouteOverlay: View {
//    let start: CGPoint; let end: CGPoint; let size: CGSize
//    private let accent = Color.blue
//    var body: some View {
//        Canvas { ctx, _ in
//            let s = CGPoint(x: start.x * size.width, y: start.y * size.height)
//            let e = CGPoint(x: end.x * size.width, y: end.y * size.height)
//            let midY = size.height * 0.40
//            var path = Path()
//            path.move(to: s)
//            path.addLine(to: CGPoint(x: s.x, y: midY))
//            path.addLine(to: CGPoint(x: e.x, y: midY))
//            path.addLine(to: e)
//            ctx.stroke(path, with: .color(accent.opacity(0.18)),
//                       style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
//            ctx.stroke(path, with: .color(accent),
//                       style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round, dash: [8, 6]))
//            for t: CGFloat in [0.35, 0.65] {
//                let px = s.x + (e.x - s.x) * t
//                var a = Path()
//                a.move(to: CGPoint(x: px - 6, y: midY - 5))
//                a.addLine(to: CGPoint(x: px, y: midY))
//                a.addLine(to: CGPoint(x: px - 6, y: midY + 5))
//                ctx.stroke(a, with: .color(accent), style: StrokeStyle(lineWidth: 2, lineCap: .round))
//            }
//        }
//    }
//}
//
//// MARK: - QR Scan View
//struct QRScanView: View {
//    @Environment(\.dismiss) private var dismiss
//    @State private var scanLineOffset: CGFloat = -120
//    @State private var isScanning   = true
//    @State private var didDetect    = false
//    @State private var pulseCorners = false
//    @State private var flashEnabled = false
//    @State private var showSuccess  = false
//    private let simulatedLocation = "Cardiology Clinic – 3rd Floor, Wing B"
//
//    var body: some View {
//        ZStack {
//            Color.black.ignoresSafeArea()
//            if !showSuccess { scannerContent } else { successOverlay }
//        }
//        .navigationTitle("Scan Location QR")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbarBackground(.black, for: .navigationBar)
//        .toolbarBackground(.visible, for: .navigationBar)
//        .toolbarColorScheme(.dark, for: .navigationBar)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: { flashEnabled.toggle() }) {
//                    Image(systemName: flashEnabled ? "bolt.fill" : "bolt.slash.fill")
//                        .foregroundStyle(flashEnabled ? .yellow : .white)
//                        .font(.system(size: 16, weight: .medium))
//                }
//            }
//        }
//        .onAppear { startScanAnimation() }
//    }
//
//    private var scannerContent: some View {
//        ZStack {
//            LinearGradient(colors: [Color(white: 0.08), Color(white: 0.14), Color(white: 0.07)],
//                           startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
//            VStack(spacing: 0) {
//                Spacer()
//                Text("Point your camera at a location QR code")
//                    .font(.subheadline).foregroundStyle(.white.opacity(0.85))
//                    .multilineTextAlignment(.center).padding(.horizontal, 40).padding(.bottom, 32)
//                ZStack {
//                    GeometryReader { geo in
//                        let boxSize: CGFloat = 260
//                        let ox = (geo.size.width - boxSize) / 2
//                        let oy = (geo.size.height - boxSize) / 2
//                        Path { p in
//                            p.addRect(CGRect(origin: .zero, size: geo.size))
//                            p.addRoundedRect(in: CGRect(x: ox, y: oy, width: boxSize, height: boxSize),
//                                             cornerRadii: RectangleCornerRadii(topLeading: 16, bottomLeading: 16,
//                                                                               bottomTrailing: 16, topTrailing: 16))
//                        }
//                        .fill(style: FillStyle(eoFill: true)).foregroundStyle(.black.opacity(0.65))
//                        RoundedRectangle(cornerRadius: 1)
//                            .fill(LinearGradient(colors: [.clear, .green.opacity(0.9), .clear],
//                                                 startPoint: .leading, endPoint: .trailing))
//                            .frame(width: boxSize - 20, height: 2)
//                            .offset(x: ox + 10, y: oy + 10 + scanLineOffset + 120)
//                            .opacity(isScanning ? 1 : 0)
//                    }.frame(height: 260)
//                    CornerBrackets(size: 260, cornerLength: 28, color: didDetect ? .green : .white, pulse: pulseCorners)
//                }.frame(width: 260, height: 260)
//                Spacer().frame(height: 40)
//                statusPill
//                Spacer()
//                VStack(spacing: 12) {
//                    HStack(spacing: 6) {
//                        Image(systemName: "info.circle").font(.caption)
//                        Text("QR codes are placed at every department entrance").font(.caption)
//                    }.foregroundStyle(.white.opacity(0.5))
//                    Button(action: simulateScan) {
//                        Label("Simulate Scan (Demo)", systemImage: "qrcode")
//                            .font(.footnote.weight(.semibold)).foregroundStyle(.white)
//                            .padding(.horizontal, 20).padding(.vertical, 10)
//                            .background(.white.opacity(0.12), in: Capsule())
//                    }
//                }.padding(.bottom, 48)
//            }
//        }
//    }
//
//    private var statusPill: some View {
//        HStack(spacing: 8) {
//            if didDetect {
//                Image(systemName: "checkmark.circle.fill").foregroundStyle(.green)
//                Text("QR Code Detected!").fontWeight(.semibold)
//            } else {
//                ProgressView().tint(.white).scaleEffect(0.8)
//                Text("Scanning…")
//            }
//        }
//        .font(.subheadline).foregroundStyle(.white)
//        .padding(.horizontal, 20).padding(.vertical, 10)
//        .background(.white.opacity(0.12), in: Capsule())
//        .animation(.easeInOut(duration: 0.3), value: didDetect)
//    }
//
//    private var successOverlay: some View {
//        ZStack {
//            Color(.systemGroupedBackground).ignoresSafeArea()
//            VStack(spacing: 32) {
//                Spacer()
//                ZStack {
//                    Circle().fill(Color.green.opacity(0.12)).frame(width: 120, height: 120)
//                    Circle().fill(Color.green.opacity(0.20)).frame(width: 90, height: 90)
//                    Image(systemName: "checkmark.circle.fill").font(.system(size: 52)).foregroundStyle(.green)
//                }
//                VStack(spacing: 8) {
//                    Text("Location Confirmed").font(.title2.weight(.bold)).foregroundStyle(Color(.label))
//                    Text(simulatedLocation).font(.body).foregroundStyle(Color(.secondaryLabel)).multilineTextAlignment(.center)
//                }
//                VStack(spacing: 0) {
//                    infoRow(icon: "map.fill",       color: .blue,   label: "Department",  value: "OPD – Cardiology")
//                    Divider().padding(.horizontal, 16)
//                    infoRow(icon: "arrow.up.right", color: .orange, label: "Floor",        value: "3rd Floor, Wing B")
//                    Divider().padding(.horizontal, 16)
//                    infoRow(icon: "figure.walk",    color: .green,  label: "Walking Time", value: "~3 minutes")
//                }
//                .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
//                .shadow(color: .black.opacity(0.05), radius: 12, y: 4).padding(.horizontal, 24)
//                Spacer()
//                VStack(spacing: 12) {
//                    // Updated Start Navigation button with gradient
//                    Button(action: { dismiss() }) {
//                        Text("Start Navigation")
//                            .font(.body.weight(.semibold))
//                            .foregroundStyle(.white)
//                            .frame(maxWidth: .infinity)
//                            .padding(.vertical, 16)
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
//                    Button(action: rescan) {
//                        Text("Scan Again").font(.body.weight(.medium)).foregroundStyle(.blue)
//                    }
//                }.padding(.horizontal, 24).padding(.bottom, 40)
//            }
//        }
//    }
//
//    private func infoRow(icon: String, color: Color, label: String, value: String) -> some View {
//        HStack(spacing: 14) {
//            ZStack {
//                RoundedRectangle(cornerRadius: 8).fill(color.opacity(0.12)).frame(width: 36, height: 36)
//                Image(systemName: icon).font(.system(size: 15, weight: .medium)).foregroundStyle(color)
//            }
//            Text(label).font(.subheadline).foregroundStyle(Color(.secondaryLabel))
//            Spacer()
//            Text(value).font(.subheadline.weight(.semibold)).foregroundStyle(Color(.label))
//        }
//        .padding(.horizontal, 16).padding(.vertical, 14)
//    }
//
//    private func startScanAnimation() {
//        isScanning = true; didDetect = false; showSuccess = false; scanLineOffset = -120
//        withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) { scanLineOffset = 120 }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { simulateScan() }
//    }
//    private func simulateScan() {
//        UINotificationFeedbackGenerator().notificationOccurred(.success)
//        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) { didDetect = true; pulseCorners = true }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
//            withAnimation(.easeInOut(duration: 0.45)) { showSuccess = true }
//        }
//    }
//    private func rescan() {
//        withAnimation(.easeInOut(duration: 0.3)) { showSuccess = false }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { startScanAnimation() }
//    }
//}
//
//// MARK: - SimpleHospitalMapView
//struct SimpleHospitalMapView: View {
//    @Environment(\.dismiss) private var dismiss
//    private let assetName = "hospital_map"
//    private let userPos = CGPoint(x: 0.18, y: 0.82)
//    private let destPos = CGPoint(x: 0.80, y: 0.28)
//
//    var body: some View {
//        ScrollView(showsIndicators: false) {
//            VStack(alignment: .leading, spacing: 20) {
//                GeometryReader { geo in
//                    ZStack {
//                        mapBackground(size: geo.size)
//                        HospitalRouteOverlay(start: userPos, end: destPos, size: geo.size)
//                        HospitalMapPin(pos: userPos, color: .green, icon: "location.circle.fill", label: "You are here", size: geo.size)
//                        HospitalMapPin(pos: destPos, color: .blue,  icon: "heart.circle.fill",    label: "Cardiology",   size: geo.size)
//                    }
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
//                    .shadow(color: .black.opacity(0.10), radius: 12, y: 5)
//                }
//                .frame(height: 340).padding(.horizontal, 16)
//
//                HStack(spacing: 0) {
//                    routeEndpoint(icon: "location.circle.fill", color: .green, label: "FROM", name: "Main Reception",   sub: "Ground Floor")
//                    VStack(spacing: 4) {
//                        Image(systemName: "arrow.right").font(.system(size: 13, weight: .semibold)).foregroundStyle(Color(.tertiaryLabel))
//                        Text("3 min").font(.caption2.weight(.semibold)).foregroundStyle(.blue)
//                    }.frame(maxWidth: .infinity)
//                    routeEndpoint(icon: "heart.circle.fill",    color: .blue,  label: "TO",   name: "Cardiology Clinic", sub: "3rd Floor, Wing B")
//                }
//                .padding(16)
//                .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
//                .shadow(color: .black.opacity(0.05), radius: 8, y: 3).padding(.horizontal, 16)
//
//                VStack(alignment: .leading, spacing: 12) {
//                    HStack {
//                        Text("Directions").font(.headline)
//                        Spacer()
//                        Text("180 m").font(.caption.weight(.semibold)).foregroundStyle(Color(.secondaryLabel))
//                            .padding(.horizontal, 10).padding(.vertical, 5)
//                            .background(Color(.secondarySystemGroupedBackground), in: Capsule())
//                    }.padding(.horizontal, 4)
//                    VStack(spacing: 0) {
//                        directionStep(n: 1, text: "Walk straight 20 m to central elevators", last: false)
//                        directionStep(n: 2, text: "Turn right at the Pharmacy",               last: false)
//                        directionStep(n: 3, text: "Take elevator to 3rd Floor",               last: false)
//                        directionStep(n: 4, text: "Cardiology Clinic is on your left",        last: true)
//                    }
//                    .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
//                    .shadow(color: .black.opacity(0.05), radius: 8, y: 3)
//                }.padding(.horizontal, 16)
//                
//                // "Start Navigation" button removed here as requested.
//            }.padding(.top, 16)
//        }
//        .background(Color(.systemGroupedBackground))
//        .navigationTitle("Indoor Navigation")
//        .navigationBarTitleDisplayMode(.large)
//    }
//
//    @ViewBuilder
//    private func mapBackground(size: CGSize) -> some View {
//        if UIImage(named: assetName) != nil {
//            Image(assetName).resizable().scaledToFill().frame(width: size.width, height: size.height).clipped()
//        } else {
//            ZStack {
//                Color(hex: "#E8EDF6")
//                VStack(spacing: 8) {
//                    Image(systemName: "map").font(.system(size: 44)).foregroundStyle(Color.blue.opacity(0.4))
//                    Text("Add \"\(assetName)\" to Assets.xcassets")
//                        .font(.caption).foregroundStyle(Color(.secondaryLabel))
//                        .multilineTextAlignment(.center).padding(.horizontal, 20)
//                }
//            }.frame(width: size.width, height: size.height)
//        }
//    }
//
//    private func routeEndpoint(icon: String, color: Color, label: String, name: String, sub: String) -> some View {
//        HStack(spacing: 10) {
//            ZStack {
//                Circle().fill(color.opacity(0.12)).frame(width: 38, height: 38)
//                Image(systemName: icon).font(.system(size: 18)).foregroundStyle(color)
//            }
//            VStack(alignment: .leading, spacing: 2) {
//                Text(label).font(.caption2.weight(.semibold)).foregroundStyle(Color(.tertiaryLabel)).tracking(0.5)
//                Text(name).font(.footnote.weight(.semibold)).foregroundStyle(Color(.label))
//                Text(sub).font(.caption2).foregroundStyle(Color(.secondaryLabel))
//            }
//        }.frame(maxWidth: .infinity, alignment: .leading)
//    }
//
//    @ViewBuilder
//    private func directionStep(n: Int, text: String, last: Bool) -> some View {
//        HStack(alignment: .top, spacing: 14) {
//            VStack(spacing: 0) {
//                ZStack {
//                    Circle().fill(last ? Color.green.opacity(0.12) : Color.blue.opacity(0.10)).frame(width: 36, height: 36)
//                    if last {
//                        Image(systemName: "checkmark.circle.fill").font(.system(size: 16, weight: .semibold)).foregroundStyle(.green)
//                    } else {
//                        Text("\(n)").font(.system(size: 13, weight: .bold)).foregroundStyle(.blue)
//                    }
//                }
//                if !last { Rectangle().fill(Color.blue.opacity(0.20)).frame(width: 1.5, height: 20) }
//            }
//            VStack(alignment: .leading, spacing: 3) {
//                Text(last ? "Arrived" : "Step \(n)").font(.caption.weight(.semibold)).foregroundStyle(last ? .green : .blue)
//                Text(text).font(.subheadline).foregroundStyle(Color(.label)).fixedSize(horizontal: false, vertical: true)
//            }.padding(.top, 8)
//            Spacer()
//        }
//        .padding(.horizontal, 16).padding(.top, 14).padding(.bottom, last ? 16 : 4)
//        if !last { Divider().padding(.leading, 66) }
//    }
//}
//
//struct HospitalMapPin: View {
//    let pos: CGPoint; let color: Color; let icon: String; let label: String; let size: CGSize
//    var body: some View {
//        VStack(spacing: 2) {
//            ZStack {
//                Circle().fill(color.opacity(0.20)).frame(width: 46, height: 46)
//                Circle().fill(color).frame(width: 32, height: 32).shadow(color: color.opacity(0.40), radius: 5, y: 3)
//                Image(systemName: icon).font(.system(size: 15, weight: .medium)).foregroundStyle(.white)
//            }
//            Text(label).font(.system(size: 9, weight: .bold)).foregroundStyle(.white)
//                .padding(.horizontal, 7).padding(.vertical, 3)
//                .background(color, in: Capsule())
//                .shadow(color: color.opacity(0.35), radius: 3, y: 2)
//        }
//        .position(x: pos.x * size.width, y: pos.y * size.height - 28)
//    }
//}
//
//// MARK: - Corner Brackets
//private struct CornerBrackets: View {
//    let size: CGFloat; let cornerLength: CGFloat; let color: Color; let pulse: Bool
//    var body: some View {
//        ZStack {
//            cornerShape(rotation: 0).offset(x: -(size/2 - cornerLength/2 + 1), y: -(size/2 - cornerLength/2 + 1))
//            cornerShape(rotation: 90).offset(x:  (size/2 - cornerLength/2 + 1), y: -(size/2 - cornerLength/2 + 1))
//            cornerShape(rotation: 270).offset(x: -(size/2 - cornerLength/2 + 1), y:  (size/2 - cornerLength/2 + 1))
//            cornerShape(rotation: 180).offset(x:  (size/2 - cornerLength/2 + 1), y:  (size/2 - cornerLength/2 + 1))
//        }
//        .scaleEffect(pulse ? 1.04 : 1.0)
//        .animation(.easeInOut(duration: 0.35), value: pulse)
//    }
//    private func cornerShape(rotation: Double) -> some View {
//        CornerBracketShape(length: cornerLength)
//            .stroke(color, style: StrokeStyle(lineWidth: 3, lineCap: .round))
//            .frame(width: cornerLength, height: cornerLength)
//            .rotationEffect(.degrees(rotation))
//    }
//}
//
//private struct CornerBracketShape: Shape {
//    let length: CGFloat
//    func path(in rect: CGRect) -> Path {
//        var p = Path()
//        p.move(to: CGPoint(x: 0, y: length))
//        p.addLine(to: CGPoint(x: 0, y: 0))
//        p.addLine(to: CGPoint(x: length, y: 0))
//        return p
//    }
//}
//
//// MARK: - View Modifiers
//private struct CardShadow: ViewModifier {
//    func body(content: Content) -> some View {
//        content.shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 4)
//    }
//}
//
//private struct ScaleOnPress: ViewModifier {
//    @State private var pressing = false
//    func body(content: Content) -> some View {
//        content
//            .scaleEffect(pressing ? 0.97 : 1.0)
//            .animation(.easeInOut(duration: 0.1), value: pressing)
//            .simultaneousGesture(
//                DragGesture(minimumDistance: 0)
//                    .onChanged { _ in pressing = true }
//                    .onEnded   { _ in pressing = false }
//            )
//    }
//}
//
//extension View {
//    func cardShadow() -> some View   { modifier(CardShadow()) }
//    func scaleOnPress() -> some View { modifier(ScaleOnPress()) }
//}
//
//// Color(hex:) is already defined elsewhere in your project.
//
//#Preview {
//    NavigationStack { HNavigationScreen() }
//}

import SwiftUI

// NOTE: HospitalDestination, NavigationStep, and allDestinations are defined
// in your existing project file — do not redeclare them here.

struct HNavigationScreen: View {
    @State private var navigateToQR      = false
    @State private var navigateToFullMap = false
    @State private var selectedDestID    = 0
    @State private var isDropdownOpen    = false  // ← lifted here, prevents state reset

    private let currentNumber   = 45
    private let yourNumber      = 55
    private let department      = "OPD"
    private let currentLocation = "Main Reception, Ground Floor"
    private let walkTime        = "3 min walk"

    private var selectedDest: HospitalDestination {
        allDestinations.first { $0.id == selectedDestID } ?? allDestinations[0]
    }

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    liveQueueSection
                    scanQRButton
                    locationSection
                    indoorNavigationSection
                    textNavigationSection
                    Color.clear.frame(height: 20)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
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
            HStack {
                HStack(spacing: 6) {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 8, height: 8)
                        .overlay(Circle().stroke(Color.green.opacity(0.35), lineWidth: 3))
                    Text("Live Queue Status")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                }
                Spacer()
                Text("Dept: \(department)")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Capsule().fill(Color(.secondarySystemBackground)))
            }
            .padding(.horizontal, 16)
            .padding(.top, 14)
            .padding(.bottom, 12)

            Divider().padding(.horizontal, 16)

            HStack(spacing: 0) {
                VStack(spacing: 4) {
                    Text("Current Number")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(currentNumber)")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(.primary)
                }
                .frame(maxWidth: .infinity)

                Rectangle()
                    .fill(Color(.separator))
                    .frame(width: 1, height: 48)

                VStack(spacing: 4) {
                    Text("Your Number")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Text("\(yourNumber)")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(.blue)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 14)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
        )
    }

    // MARK: - Scan QR Button with Gradient
    private var scanQRButton: some View {
        Button(action: { navigateToQR = true }) {
            Label("Scan Location QR", systemImage: "qrcode.viewfinder")
                .font(.body.weight(.semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    LinearGradient(
                        colors: [.blue, .cyan],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .blue.opacity(0.3), radius: 12, x: 0, y: 6)
        }
        .buttonStyle(.plain)
        .scaleOnPress()
    }

    // MARK: - Location Section
    private var locationSection: some View {
        VStack(spacing: 0) {
            // Current Location row
            HStack(alignment: .center, spacing: 12) {
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
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 8)

            // Connector line
            HStack {
                Spacer().frame(width: 34)
                Rectangle()
                    .fill(Color(.separator))
                    .frame(width: 1.5, height: 22)
                Spacer()
            }

            // Destination row
            HStack(alignment: .top, spacing: 12) {
                locationIcon(filled: true)
                    .padding(.top, 2)

                VStack(alignment: .leading, spacing: 8) {
                    Text("SELECT DESTINATION")
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(Color(.tertiaryLabel))
                        .tracking(0.5)

                    // ── Inline dropdown (state owned by parent) ──
                    VStack(spacing: 0) {

                        // Header — always visible, tap to toggle
                        Button {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                isDropdownOpen.toggle()
                            }
                        } label: {
                            HStack(spacing: 12) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.blue.opacity(0.10))
                                        .frame(width: 38, height: 38)
                                    Image(systemName: selectedDest.icon)
                                        .font(.system(size: 17, weight: .medium))
                                        .foregroundStyle(.blue)
                                }
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(selectedDest.name)
                                        .font(.callout.weight(.semibold))
                                        .foregroundStyle(Color(.label))
                                        .lineLimit(1)
                                    Text(selectedDest.sub)
                                        .font(.caption)
                                        .foregroundStyle(Color(.secondaryLabel))
                                }
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundStyle(Color(.secondaryLabel))
                                    .rotationEffect(.degrees(isDropdownOpen ? 180 : 0))
                                    .animation(.easeInOut(duration: 0.25), value: isDropdownOpen)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 12)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)

                        // Expanded list — shown/hidden based on isDropdownOpen
                        if isDropdownOpen {
                            Divider().padding(.horizontal, 12)

                            VStack(spacing: 0) {
                                ForEach(allDestinations) { dest in
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            selectedDestID = dest.id
                                            isDropdownOpen = false
                                        }
                                    } label: {
                                        HStack(spacing: 12) {
                                            ZStack {
                                                RoundedRectangle(cornerRadius: 6)
                                                    .fill(selectedDestID == dest.id
                                                          ? Color.blue.opacity(0.12)
                                                          : Color(.tertiarySystemGroupedBackground))
                                                    .frame(width: 32, height: 32)
                                                Image(systemName: dest.icon)
                                                    .font(.system(size: 14, weight: .medium))
                                                    .foregroundStyle(selectedDestID == dest.id
                                                                     ? .blue : Color(.secondaryLabel))
                                            }
                                            VStack(alignment: .leading, spacing: 1) {
                                                Text(dest.name)
                                                    .font(.subheadline)
                                                    .fontWeight(selectedDestID == dest.id ? .semibold : .regular)
                                                    .foregroundStyle(Color(.label))
                                                Text(dest.sub)
                                                    .font(.caption2)
                                                    .foregroundStyle(Color(.secondaryLabel))
                                            }
                                            Spacer()
                                            if selectedDestID == dest.id {
                                                Image(systemName: "checkmark.circle.fill")
                                                    .font(.system(size: 16))
                                                    .foregroundStyle(.blue)
                                            }
                                        }
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 10)
                                        .background(selectedDestID == dest.id
                                                    ? Color.blue.opacity(0.05) : Color.clear)
                                        .contentShape(Rectangle())
                                    }
                                    .buttonStyle(.plain)

                                    if dest.id != allDestinations.last?.id {
                                        Divider().padding(.horizontal, 12)
                                    }
                                }
                            }
                            .transition(.opacity)
                        }
                    }
                    .background(Color(.secondarySystemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color(.separator).opacity(0.4), lineWidth: 0.5)
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 16)
        }
        .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
        .cardShadow()
    }

    private func locationIcon(filled: Bool) -> some View {
        ZStack {
            Circle()
                .fill(filled ? Color.blue.opacity(0.1) : Color(.secondarySystemGroupedBackground))
                .frame(width: 36, height: 36)
            Image(systemName: filled ? "mappin.circle.fill" : "location.circle")
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(filled ? .blue : Color(.secondaryLabel))
        }
    }

    // MARK: - Indoor Navigation Thumbnail (UPDATED)
    private var indoorNavigationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline) {
                Text("Indoor Navigation")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(Color(.label))
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "figure.walk")
                        .font(.caption)
                    Text(walkTime)
                        .font(.caption)
                        .fontWeight(.medium)
                }
                .foregroundStyle(.blue)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.blue.opacity(0.1), in: Capsule())
            }

            VStack(spacing: 12) {
                // Map Thumbnail
                Button(action: { navigateToFullMap = true }) {
                    ZStack(alignment: .topTrailing) {
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
                        
                        // Better "Tap to expand" indicator
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.up.left.and.arrow.down.right")
                                .font(.system(size: 10, weight: .semibold))
                            Text("Expand")
                                .font(.system(size: 10, weight: .semibold))
                        }
                        .foregroundStyle(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.black.opacity(0.5))
                        .clipShape(Capsule())
                        .padding(12)
                    }
                    .frame(height: 160)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .buttonStyle(.plain)

                // "Open Full Map View" as a proper gradient button
                Button(action: { navigateToFullMap = true }) {
                    HStack {
                        Image(systemName: "map")
                            .font(.system(size: 14, weight: .medium))
                        Text("Open Full Map View")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12, weight: .semibold))
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(
                        LinearGradient(
                            colors: [.blue, .cyan],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: .blue.opacity(0.3), radius: 8, y: 4)
                }
                .buttonStyle(.plain)
                .scaleOnPress()
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
        )
    }

    // MARK: - Step-by-Step Directions
    private var textNavigationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Step-by-Step Directions")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(Color(.label))
                Spacer()
                HStack(spacing: 4) {
                    Image(systemName: "ruler")
                        .font(.caption)
                    Text("180 m")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(Color(.secondaryLabel))
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color(.secondarySystemGroupedBackground), in: Capsule())
            }
            
            VStack(spacing: 0) {
                directionStep(n: 1, text: "Walk straight 20 m to central elevators", last: false)
                directionStep(n: 2, text: "Turn right at the Pharmacy", last: false)
                directionStep(n: 3, text: "Take elevator to 3rd Floor", last: false)
                directionStep(n: 4, text: "Cardiology Clinic is on your left", last: true)
            }
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
            )
        }
    }

    @ViewBuilder
    private func directionStep(n: Int, text: String, last: Bool) -> some View {
        HStack(alignment: .top, spacing: 14) {
            VStack(spacing: 0) {
                ZStack {
                    Circle()
                        .fill(last ? Color.green.opacity(0.12) : Color.blue.opacity(0.1))
                        .frame(width: 36, height: 36)
                    if last {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.green)
                    } else {
                        Text("\(n)")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(.blue)
                    }
                }
                if !last {
                    Rectangle()
                        .fill(Color(.separator))
                        .frame(width: 1.5, height: 20)
                }
            }
            
            VStack(alignment: .leading, spacing: 3) {
                Text(last ? "Arrived" : "Step \(n)")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(last ? .green : .blue)
                Text(text)
                    .font(.subheadline)
                    .foregroundStyle(Color(.label))
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.top, 8)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 14)
        .padding(.bottom, last ? 16 : 4)
        
        if !last {
            Divider()
                .padding(.leading, 66)
        }
    }
}

// MARK: - Mini Map Fallback
private struct MiniMapFallback: View {
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            ZStack {
                LinearGradient(
                    colors: [Color(hex: "#E2E8F4"), Color(hex: "#D0D8E8")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                // Grid lines
                Path { p in
                    stride(from: CGFloat(0), to: w, by: w/9).forEach { x in
                        p.move(to: .init(x: x, y: 0))
                        p.addLine(to: .init(x: x, y: h))
                    }
                    stride(from: CGFloat(0), to: h, by: h/7).forEach { y in
                        p.move(to: .init(x: 0, y: y))
                        p.addLine(to: .init(x: w, y: y))
                    }
                }
                .stroke(Color.white.opacity(0.45), lineWidth: 0.5)
                
                // Department blocks
                miniBlock(x: w*0.13, y: h*0.42, w: w*0.20, h: h*0.36, label: "EMERGENCY", color: Color(hex: "#A4AECB"))
                miniBlock(x: w*0.50, y: h*0.32, w: w*0.18, h: h*0.26, label: "SURGERY",   color: Color(hex: "#8F9EC0"))
                miniBlock(x: w*0.79, y: h*0.26, w: w*0.16, h: h*0.22, label: "PHARMACY",  color: Color(hex: "#A4AECB"))
                miniBlock(x: w*0.79, y: h*0.66, w: w*0.16, h: h*0.22, label: "OPD",       color: Color(hex: "#3A7BF7").opacity(0.75))
                
                // Path
                Capsule()
                    .fill(Color(hex: "#C2CCE4"))
                    .frame(width: w*0.72, height: 12)
                    .position(x: w*0.50, y: h*0.57)
                
                HospitalRouteOverlay(
                    start: CGPoint(x: 0.13, y: 0.88),
                    end: CGPoint(x: 0.79, y: 0.51),
                    size: CGSize(width: w, height: h)
                )
                
                // Location markers
                Circle()
                    .fill(Color(hex: "#34C759"))
                    .frame(width: 9, height: 9)
                    .overlay(Circle().stroke(.white, lineWidth: 2))
                    .position(x: w*0.13, y: h*0.88)
                
                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: 15))
                    .foregroundStyle(Color(hex: "#3A7BF7"))
                    .position(x: w*0.79, y: h*0.46)
            }
        }
    }
    
    private func miniBlock(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat, label: String, color: Color) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 3)
                .fill(color)
                .frame(width: w, height: h)
                .position(x: x, y: y)
            Text(label)
                .font(.system(size: 5.5, weight: .bold))
                .foregroundStyle(.white)
                .position(x: x, y: y)
        }
    }
}

// MARK: - Route Overlay
struct HospitalRouteOverlay: View {
    let start: CGPoint
    let end: CGPoint
    let size: CGSize
    private let accent = Color.blue
    
    var body: some View {
        Canvas { ctx, _ in
            let s = CGPoint(x: start.x * size.width, y: start.y * size.height)
            let e = CGPoint(x: end.x * size.width, y: end.y * size.height)
            let midY = size.height * 0.40
            
            var path = Path()
            path.move(to: s)
            path.addLine(to: CGPoint(x: s.x, y: midY))
            path.addLine(to: CGPoint(x: e.x, y: midY))
            path.addLine(to: e)
            
            // Background path
            ctx.stroke(path, with: .color(accent.opacity(0.18)),
                       style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
            
            // Dashed path
            ctx.stroke(path, with: .color(accent),
                       style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round, dash: [8, 6]))
            
            // Direction arrows
            for t: CGFloat in [0.35, 0.65] {
                let px = s.x + (e.x - s.x) * t
                var arrow = Path()
                arrow.move(to: CGPoint(x: px - 6, y: midY - 5))
                arrow.addLine(to: CGPoint(x: px, y: midY))
                arrow.addLine(to: CGPoint(x: px - 6, y: midY + 5))
                ctx.stroke(arrow, with: .color(accent), style: StrokeStyle(lineWidth: 2, lineCap: .round))
            }
        }
    }
}

// MARK: - QR Scan View
struct QRScanView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var scanLineOffset: CGFloat = -120
    @State private var isScanning   = true
    @State private var didDetect    = false
    @State private var pulseCorners = false
    @State private var flashEnabled = false
    @State private var showSuccess  = false
    private let simulatedLocation = "Cardiology Clinic – 3rd Floor, Wing B"

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            if !showSuccess { scannerContent } else { successOverlay }
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

    private var scannerContent: some View {
        ZStack {
            LinearGradient(colors: [Color(white: 0.08), Color(white: 0.14), Color(white: 0.07)],
                           startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer()
                Text("Point your camera at a location QR code")
                    .font(.subheadline).foregroundStyle(.white.opacity(0.85))
                    .multilineTextAlignment(.center).padding(.horizontal, 40).padding(.bottom, 32)
                ZStack {
                    GeometryReader { geo in
                        let boxSize: CGFloat = 260
                        let ox = (geo.size.width - boxSize) / 2
                        let oy = (geo.size.height - boxSize) / 2
                        Path { p in
                            p.addRect(CGRect(origin: .zero, size: geo.size))
                            p.addRoundedRect(in: CGRect(x: ox, y: oy, width: boxSize, height: boxSize),
                                             cornerRadii: RectangleCornerRadii(topLeading: 16, bottomLeading: 16,
                                                                               bottomTrailing: 16, topTrailing: 16))
                        }
                        .fill(style: FillStyle(eoFill: true)).foregroundStyle(.black.opacity(0.65))
                        RoundedRectangle(cornerRadius: 1)
                            .fill(LinearGradient(colors: [.clear, .green.opacity(0.9), .clear],
                                                 startPoint: .leading, endPoint: .trailing))
                            .frame(width: boxSize - 20, height: 2)
                            .offset(x: ox + 10, y: oy + 10 + scanLineOffset + 120)
                            .opacity(isScanning ? 1 : 0)
                    }.frame(height: 260)
                    CornerBrackets(size: 260, cornerLength: 28, color: didDetect ? .green : .white, pulse: pulseCorners)
                }.frame(width: 260, height: 260)
                Spacer().frame(height: 40)
                statusPill
                Spacer()
                VStack(spacing: 12) {
                    HStack(spacing: 6) {
                        Image(systemName: "info.circle").font(.caption)
                        Text("QR codes are placed at every department entrance").font(.caption)
                    }.foregroundStyle(.white.opacity(0.5))
                    Button(action: simulateScan) {
                        Label("Simulate Scan (Demo)", systemImage: "qrcode")
                            .font(.footnote.weight(.semibold)).foregroundStyle(.white)
                            .padding(.horizontal, 20).padding(.vertical, 10)
                            .background(.white.opacity(0.12), in: Capsule())
                    }
                }.padding(.bottom, 48)
            }
        }
    }

    private var statusPill: some View {
        HStack(spacing: 8) {
            if didDetect {
                Image(systemName: "checkmark.circle.fill").foregroundStyle(.green)
                Text("QR Code Detected!").fontWeight(.semibold)
            } else {
                ProgressView().tint(.white).scaleEffect(0.8)
                Text("Scanning…")
            }
        }
        .font(.subheadline).foregroundStyle(.white)
        .padding(.horizontal, 20).padding(.vertical, 10)
        .background(.white.opacity(0.12), in: Capsule())
        .animation(.easeInOut(duration: 0.3), value: didDetect)
    }

    private var successOverlay: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()
            VStack(spacing: 32) {
                Spacer()
                ZStack {
                    Circle().fill(Color.green.opacity(0.12)).frame(width: 120, height: 120)
                    Circle().fill(Color.green.opacity(0.20)).frame(width: 90, height: 90)
                    Image(systemName: "checkmark.circle.fill").font(.system(size: 52)).foregroundStyle(.green)
                }
                VStack(spacing: 8) {
                    Text("Location Confirmed").font(.title2.weight(.bold)).foregroundStyle(Color(.label))
                    Text(simulatedLocation).font(.body).foregroundStyle(Color(.secondaryLabel)).multilineTextAlignment(.center)
                }
                VStack(spacing: 0) {
                    infoRow(icon: "map.fill",       color: .blue,   label: "Department",  value: "OPD – Cardiology")
                    Divider().padding(.horizontal, 16)
                    infoRow(icon: "arrow.up.right", color: .orange, label: "Floor",        value: "3rd Floor, Wing B")
                    Divider().padding(.horizontal, 16)
                    infoRow(icon: "figure.walk",    color: .green,  label: "Walking Time", value: "~3 minutes")
                }
                .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
                .shadow(color: .black.opacity(0.05), radius: 12, y: 4).padding(.horizontal, 24)
                Spacer()
                VStack(spacing: 12) {
                    Button(action: { dismiss() }) {
                        Text("Start Navigation")
                            .font(.body.weight(.semibold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    colors: [.blue, .cyan],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .shadow(color: .blue.opacity(0.3), radius: 10, y: 5)
                    }
                    Button(action: rescan) {
                        Text("Scan Again").font(.body.weight(.medium)).foregroundStyle(.blue)
                    }
                }.padding(.horizontal, 24).padding(.bottom, 40)
            }
        }
    }

    private func infoRow(icon: String, color: Color, label: String, value: String) -> some View {
        HStack(spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 8).fill(color.opacity(0.12)).frame(width: 36, height: 36)
                Image(systemName: icon).font(.system(size: 15, weight: .medium)).foregroundStyle(color)
            }
            Text(label).font(.subheadline).foregroundStyle(Color(.secondaryLabel))
            Spacer()
            Text(value).font(.subheadline.weight(.semibold)).foregroundStyle(Color(.label))
        }
        .padding(.horizontal, 16).padding(.vertical, 14)
    }

    private func startScanAnimation() {
        isScanning = true; didDetect = false; showSuccess = false; scanLineOffset = -120
        withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) { scanLineOffset = 120 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { simulateScan() }
    }
    private func simulateScan() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) { didDetect = true; pulseCorners = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            withAnimation(.easeInOut(duration: 0.45)) { showSuccess = true }
        }
    }
    private func rescan() {
        withAnimation(.easeInOut(duration: 0.3)) { showSuccess = false }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { startScanAnimation() }
    }
}

// MARK: - SimpleHospitalMapView
struct SimpleHospitalMapView: View {
    @Environment(\.dismiss) private var dismiss
    private let assetName = "hospital_map"
    private let userPos = CGPoint(x: 0.18, y: 0.82)
    private let destPos = CGPoint(x: 0.80, y: 0.28)

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                GeometryReader { geo in
                    ZStack {
                        mapBackground(size: geo.size)
                        HospitalRouteOverlay(start: userPos, end: destPos, size: geo.size)
                        HospitalMapPin(pos: userPos, color: .green, icon: "location.circle.fill", label: "You are here", size: geo.size)
                        HospitalMapPin(pos: destPos, color: .blue,  icon: "heart.circle.fill",    label: "Cardiology",   size: geo.size)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.10), radius: 12, y: 5)
                }
                .frame(height: 340).padding(.horizontal, 16)

                HStack(spacing: 0) {
                    routeEndpoint(icon: "location.circle.fill", color: .green, label: "FROM", name: "Main Reception",   sub: "Ground Floor")
                    VStack(spacing: 4) {
                        Image(systemName: "arrow.right").font(.system(size: 13, weight: .semibold)).foregroundStyle(Color(.tertiaryLabel))
                        Text("3 min").font(.caption2.weight(.semibold)).foregroundStyle(.blue)
                    }.frame(maxWidth: .infinity)
                    routeEndpoint(icon: "heart.circle.fill",    color: .blue,  label: "TO",   name: "Cardiology Clinic", sub: "3rd Floor, Wing B")
                }
                .padding(16)
                .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
                .shadow(color: .black.opacity(0.05), radius: 8, y: 3).padding(.horizontal, 16)

                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Directions").font(.headline)
                        Spacer()
                        Text("180 m").font(.caption.weight(.semibold)).foregroundStyle(Color(.secondaryLabel))
                            .padding(.horizontal, 10).padding(.vertical, 5)
                            .background(Color(.secondarySystemGroupedBackground), in: Capsule())
                    }.padding(.horizontal, 4)
                    VStack(spacing: 0) {
                        directionStep(n: 1, text: "Walk straight 20 m to central elevators", last: false)
                        directionStep(n: 2, text: "Turn right at the Pharmacy",               last: false)
                        directionStep(n: 3, text: "Take elevator to 3rd Floor",               last: false)
                        directionStep(n: 4, text: "Cardiology Clinic is on your left",        last: true)
                    }
                    .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .black.opacity(0.05), radius: 8, y: 3)
                }.padding(.horizontal, 16)
            }.padding(.top, 16)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Indoor Navigation")
        .navigationBarTitleDisplayMode(.large)
    }

    @ViewBuilder
    private func mapBackground(size: CGSize) -> some View {
        if UIImage(named: assetName) != nil {
            Image(assetName).resizable().scaledToFill().frame(width: size.width, height: size.height).clipped()
        } else {
            ZStack {
                Color(hex: "#E8EDF6")
                VStack(spacing: 8) {
                    Image(systemName: "map").font(.system(size: 44)).foregroundStyle(Color.blue.opacity(0.4))
                    Text("Add \"\(assetName)\" to Assets.xcassets")
                        .font(.caption).foregroundStyle(Color(.secondaryLabel))
                        .multilineTextAlignment(.center).padding(.horizontal, 20)
                }
            }.frame(width: size.width, height: size.height)
        }
    }

    private func routeEndpoint(icon: String, color: Color, label: String, name: String, sub: String) -> some View {
        HStack(spacing: 10) {
            ZStack {
                Circle().fill(color.opacity(0.12)).frame(width: 38, height: 38)
                Image(systemName: icon).font(.system(size: 18)).foregroundStyle(color)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(label).font(.caption2.weight(.semibold)).foregroundStyle(Color(.tertiaryLabel)).tracking(0.5)
                Text(name).font(.footnote.weight(.semibold)).foregroundStyle(Color(.label))
                Text(sub).font(.caption2).foregroundStyle(Color(.secondaryLabel))
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    private func directionStep(n: Int, text: String, last: Bool) -> some View {
        HStack(alignment: .top, spacing: 14) {
            VStack(spacing: 0) {
                ZStack {
                    Circle().fill(last ? Color.green.opacity(0.12) : Color.blue.opacity(0.10)).frame(width: 36, height: 36)
                    if last {
                        Image(systemName: "checkmark.circle.fill").font(.system(size: 16, weight: .semibold)).foregroundStyle(.green)
                    } else {
                        Text("\(n)").font(.system(size: 13, weight: .bold)).foregroundStyle(.blue)
                    }
                }
                if !last { Rectangle().fill(Color.blue.opacity(0.20)).frame(width: 1.5, height: 20) }
            }
            VStack(alignment: .leading, spacing: 3) {
                Text(last ? "Arrived" : "Step \(n)").font(.caption.weight(.semibold)).foregroundStyle(last ? .green : .blue)
                Text(text).font(.subheadline).foregroundStyle(Color(.label)).fixedSize(horizontal: false, vertical: true)
            }.padding(.top, 8)
            Spacer()
        }
        .padding(.horizontal, 16).padding(.top, 14).padding(.bottom, last ? 16 : 4)
        if !last { Divider().padding(.leading, 66) }
    }
}

struct HospitalMapPin: View {
    let pos: CGPoint; let color: Color; let icon: String; let label: String; let size: CGSize
    var body: some View {
        VStack(spacing: 2) {
            ZStack {
                Circle().fill(color.opacity(0.20)).frame(width: 46, height: 46)
                Circle().fill(color).frame(width: 32, height: 32).shadow(color: color.opacity(0.40), radius: 5, y: 3)
                Image(systemName: icon).font(.system(size: 15, weight: .medium)).foregroundStyle(.white)
            }
            Text(label).font(.system(size: 9, weight: .bold)).foregroundStyle(.white)
                .padding(.horizontal, 7).padding(.vertical, 3)
                .background(color, in: Capsule())
                .shadow(color: color.opacity(0.35), radius: 3, y: 2)
        }
        .position(x: pos.x * size.width, y: pos.y * size.height - 28)
    }
}

// MARK: - Corner Brackets
private struct CornerBrackets: View {
    let size: CGFloat; let cornerLength: CGFloat; let color: Color; let pulse: Bool
    var body: some View {
        ZStack {
            cornerShape(rotation: 0).offset(x: -(size/2 - cornerLength/2 + 1), y: -(size/2 - cornerLength/2 + 1))
            cornerShape(rotation: 90).offset(x:  (size/2 - cornerLength/2 + 1), y: -(size/2 - cornerLength/2 + 1))
            cornerShape(rotation: 270).offset(x: -(size/2 - cornerLength/2 + 1), y:  (size/2 - cornerLength/2 + 1))
            cornerShape(rotation: 180).offset(x:  (size/2 - cornerLength/2 + 1), y:  (size/2 - cornerLength/2 + 1))
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
    func cardShadow() -> some View   { modifier(CardShadow()) }
    func scaleOnPress() -> some View { modifier(ScaleOnPress()) }
}

// Color(hex:) is already defined elsewhere in your project.

#Preview {
    NavigationStack { HNavigationScreen() }
}
