//
//  HospitalMapView3D.swift
//  ClinicApp
//
//  Created by BSCComp-046 on 2026-03-11.
//

import SwiftUI

// MARK: - Models

struct HospitalPin: Identifiable {
    let id = UUID()
    let name: String
    let shortLabel: String
    let floor: String
    let wing: String
    let icon: String
    let color: Color
    // Fractional position on the map image (0–1)
    let x: CGFloat
    let y: CGFloat
}

struct NavRoute {
    let steps: [String]
    let walkMinutes: Int
    let totalMeters: Int
}

// MARK: - Hospital Map Full View

struct HospitalMapFullView: View {

    // MARK: State
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPin: HospitalPin?  = nil
    @State private var showRouteSheet             = false
    @State private var routeDrawn                 = false
    @State private var mapScale: CGFloat          = 1.0
    @State private var mapOffset: CGSize          = .zero
    @State private var lastOffset: CGSize         = .zero
    @State private var lastScale: CGFloat         = 1.0
    @State private var showPinDetail              = false

    // Current user location (fixed for MVP)
    private let userLocation = CGPoint(x: 0.18, y: 0.82)

    // MARK: Pins
    private let pins: [HospitalPin] = [
        HospitalPin(name: "Emergency",        shortLabel: "ER",   floor: "Ground Floor", wing: "Wing A",
                    icon: "cross.circle.fill",       color: .red,
                    x: 0.12, y: 0.42),
        HospitalPin(name: "Cardiology Clinic",shortLabel: "OPD",  floor: "3rd Floor",    wing: "Wing B",
                    icon: "heart.circle.fill",        color: Color(hex: "#3A7BF7"),
                    x: 0.80, y: 0.28),
        HospitalPin(name: "Pharmacy",         shortLabel: "RX",   floor: "Ground Floor", wing: "Wing C",
                    icon: "pills.circle.fill",        color: .orange,
                    x: 0.64, y: 0.55),
        HospitalPin(name: "Surgery Block",    shortLabel: "SRG",  floor: "2nd Floor",    wing: "Wing D",
                    icon: "stethoscope.circle.fill",  color: .purple,
                    x: 0.45, y: 0.33),
        HospitalPin(name: "Radiology",        shortLabel: "RAD",  floor: "1st Floor",    wing: "Wing B",
                    icon: "waveform.circle.fill",     color: .teal,
                    x: 0.75, y: 0.65),
        HospitalPin(name: "Main Reception",   shortLabel: "REC",  floor: "Ground Floor", wing: "Main",
                    icon: "person.crop.circle.fill",  color: .green,
                    x: 0.18, y: 0.82),
    ]

    // Route from Main Reception → Cardiology
    private func route(for pin: HospitalPin) -> NavRoute {
        switch pin.shortLabel {
        case "OPD":
            return NavRoute(
                steps: ["Walk straight 20m to central elevators",
                        "Turn right at the Pharmacy",
                        "Take elevator to 3rd Floor",
                        "Turn left, Cardiology Clinic is on your right"],
                walkMinutes: 3, totalMeters: 180)
        case "RX":
            return NavRoute(
                steps: ["Walk straight 20m toward Pharmacy sign",
                        "Pharmacy is on your left"],
                walkMinutes: 1, totalMeters: 40)
        case "SRG":
            return NavRoute(
                steps: ["Take elevator to 2nd Floor",
                        "Follow signs for Surgery Block, Wing D"],
                walkMinutes: 2, totalMeters: 95)
        case "RAD":
            return NavRoute(
                steps: ["Walk toward central elevators",
                        "Take elevator to 1st Floor",
                        "Follow blue signage for Radiology"],
                walkMinutes: 2, totalMeters: 110)
        case "ER":
            return NavRoute(
                steps: ["Turn left at main entrance",
                        "Emergency is straight ahead, Wing A"],
                walkMinutes: 1, totalMeters: 35)
        default:
            return NavRoute(steps: ["You are already here"], walkMinutes: 0, totalMeters: 0)
        }
    }

    // MARK: Body
    var body: some View {
        ZStack(alignment: .bottom) {
            Color(.systemGroupedBackground).ignoresSafeArea()

            VStack(spacing: 0) {
                mapArea
                legendStrip
            }

            // Pin detail sheet
            if let pin = selectedPin, showPinDetail {
                pinDetailCard(pin: pin)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(10)
            }
        }
        .navigationTitle("Hospital Map")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: resetMap) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.system(size: 14, weight: .semibold))
                }
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.75), value: showPinDetail)
        .animation(.spring(response: 0.4, dampingFraction: 0.75), value: selectedPin?.id)
    }

    // MARK: Map Area

    private var mapArea: some View {
        GeometryReader { geo in
            ZStack {
                // ── Map background (floor plan illustration) ──
                FloorPlanCanvas(
                    size: CGSize(width: geo.size.width, height: geo.size.height),
                    routeTarget: selectedPin,
                    userLocation: userLocation,
                    routeDrawn: routeDrawn
                )

                // ── Pins ──
                ForEach(pins) { pin in
                    pinView(pin: pin, in: geo.size)
                }

                // ── User location dot ──
                userDot(in: geo.size)

                // ── Scale bar ──
                scaleBar
                    .frame(maxWidth: .infinity, maxHeight: .infinity,
                           alignment: .bottomLeading)
                    .padding(.leading, 16)
                    .padding(.bottom, 16)

                // ── Floor selector ──
                floorSelector
                    .frame(maxWidth: .infinity, maxHeight: .infinity,
                           alignment: .topTrailing)
                    .padding(.trailing, 16)
                    .padding(.top, 16)
            }
            .scaleEffect(mapScale, anchor: .center)
            .offset(mapOffset)
            .gesture(
                SimultaneousGesture(
                    MagnificationGesture()
                        .onChanged { v in mapScale = (lastScale * v).clamped(to: 0.8...3.0) }
                        .onEnded   { _ in lastScale = mapScale },
                    DragGesture()
                        .onChanged { v in mapOffset = CGSize(width:  lastOffset.width  + v.translation.width,
                                                             height: lastOffset.height + v.translation.height) }
                        .onEnded   { _ in lastOffset = mapOffset }
                )
            )
            .clipped()
        }
        .frame(maxHeight: .infinity)
        .background(Color(hex: "#E8EDF6"))
    }

    // MARK: Pin View

    private func pinView(pin: HospitalPin, in size: CGSize) -> some View {
        let px = pin.x * size.width
        let py = pin.y * size.height
        let isSelected = selectedPin?.id == pin.id
        let isUser     = pin.shortLabel == "REC"

        return VStack(spacing: 0) {
            ZStack {
                // Glow ring when selected
                if isSelected {
                    Circle()
                        .fill(pin.color.opacity(0.22))
                        .frame(width: 52, height: 52)
                }
                Circle()
                    .fill(isSelected ? pin.color : Color(.systemBackground))
                    .frame(width: 36, height: 36)
                    .shadow(color: pin.color.opacity(0.35), radius: isSelected ? 10 : 5,
                            x: 0, y: isSelected ? 5 : 2)
                Image(systemName: pin.icon)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(isSelected ? .white : pin.color)
            }

            // Stem
            Rectangle()
                .fill(pin.color)
                .frame(width: 2, height: 8)

            // Dot foot
            Circle()
                .fill(pin.color)
                .frame(width: 5, height: 5)
        }
        .scaleEffect(isSelected ? 1.15 : 1.0)
        .animation(.spring(response: 0.35, dampingFraction: 0.6), value: isSelected)
        .position(x: px, y: py - 22) // offset upward so dot sits on location
        .onTapGesture {
            let haptic = UIImpactFeedbackGenerator(style: .light)
            haptic.impactOccurred()

            if selectedPin?.id == pin.id {
                // Deselect
                withAnimation { selectedPin = nil; showPinDetail = false; routeDrawn = false }
            } else {
                selectedPin  = pin
                showPinDetail = false
                routeDrawn   = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    withAnimation { showPinDetail = true }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation { routeDrawn = true }
                    }
                }
            }
        }
    }

    // MARK: User dot

    private func userDot(in size: CGSize) -> some View {
        ZStack {
            Circle()
                .fill(Color.blue.opacity(0.15))
                .frame(width: 28, height: 28)
            Circle()
                .fill(Color.blue)
                .frame(width: 14, height: 14)
                .overlay(Circle().stroke(.white, lineWidth: 2.5))
                .shadow(color: .blue.opacity(0.4), radius: 6)
        }
        .position(x: userLocation.x * size.width,
                  y: userLocation.y * size.height)
    }

    // MARK: Legend strip

    private var legendStrip: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(pins) { pin in
                    Button(action: {
                        if selectedPin?.id == pin.id {
                            withAnimation { selectedPin = nil; showPinDetail = false; routeDrawn = false }
                        } else {
                            selectedPin = pin; showPinDetail = false; routeDrawn = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation { showPinDetail = true }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    withAnimation { routeDrawn = true }
                                }
                            }
                        }
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: pin.icon)
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(selectedPin?.id == pin.id ? .white : pin.color)
                            Text(pin.name)
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(selectedPin?.id == pin.id ? .white : Color(.label))
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            selectedPin?.id == pin.id
                                ? pin.color
                                : Color(.systemBackground),
                            in: Capsule()
                        )
                        .shadow(color: .black.opacity(0.06), radius: 4, y: 2)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(Color(.systemBackground))
        .shadow(color: .black.opacity(0.05), radius: 6, y: -3)
    }

    // MARK: Scale bar

    private var scaleBar: some View {
        VStack(alignment: .leading, spacing: 3) {
            Rectangle()
                .fill(Color(.label))
                .frame(width: 60, height: 2)
            Text("50 m")
                .font(.system(size: 9, weight: .medium))
                .foregroundStyle(Color(.secondaryLabel))
        }
        .padding(8)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
    }

    // MARK: Floor selector

    private var floorSelector: some View {
        VStack(spacing: 0) {
            ForEach(["3F", "2F", "1F", "G"].indices, id: \.self) { i in
                let labels = ["3F", "2F", "1F", "G"]
                let label = labels[i]
                let active = label == "G"

                Button(action: {}) {
                    Text(label)
                        .font(.system(size: 12, weight: active ? .bold : .regular))
                        .foregroundStyle(active ? .white : Color(.secondaryLabel))
                        .frame(width: 36, height: 32)
                        .background(active ? Color(hex: "#3A7BF7") : Color.clear)
                }

                if i < 3 { Divider() }
            }
        }
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.08), radius: 6, y: 3)
    }

    // MARK: Pin Detail Card

    private func pinDetailCard(pin: HospitalPin) -> some View {
        let r = route(for: pin)

        return VStack(spacing: 0) {
            // Handle bar
            Capsule()
                .fill(Color(.tertiaryLabel))
                .frame(width: 36, height: 4)
                .padding(.top, 10)
                .padding(.bottom, 16)

            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(pin.color.opacity(0.12))
                        .frame(width: 52, height: 52)
                    Image(systemName: pin.icon)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(pin.color)
                }

                VStack(alignment: .leading, spacing: 3) {
                    Text(pin.name)
                        .font(.headline)
                        .foregroundStyle(Color(.label))
                    HStack(spacing: 6) {
                        Label(pin.floor, systemImage: "building.2")
                            .font(.caption)
                            .foregroundStyle(Color(.secondaryLabel))
                        Text("·").foregroundStyle(Color(.tertiaryLabel))
                        Text(pin.wing)
                            .font(.caption)
                            .foregroundStyle(Color(.secondaryLabel))
                    }
                }

                Spacer()

                // Time badge
                VStack(spacing: 2) {
                    Text("\(r.walkMinutes)")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(hex: "#3A7BF7"))
                    Text("min")
                        .font(.caption2.weight(.medium))
                        .foregroundStyle(Color(.secondaryLabel))
                }
            }
            .padding(.horizontal, 20)

            Divider().padding(.vertical, 14)

            // Steps
            VStack(spacing: 0) {
                ForEach(Array(r.steps.enumerated()), id: \.offset) { idx, step in
                    HStack(alignment: .top, spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(idx == r.steps.count - 1
                                      ? Color.green.opacity(0.12)
                                      : Color(hex: "#EBF1FF"))
                                .frame(width: 30, height: 30)
                            if idx == r.steps.count - 1 {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 14))
                                    .foregroundStyle(.green)
                            } else {
                                Text("\(idx + 1)")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundStyle(Color(hex: "#3A7BF7"))
                            }
                        }

                        Text(step)
                            .font(.subheadline)
                            .foregroundStyle(Color(.label))
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.vertical, 8)

                    if idx < r.steps.count - 1 {
                        HStack {
                            Rectangle()
                                .fill(Color(hex: "#3A7BF7").opacity(0.2))
                                .frame(width: 1.5, height: 14)
                                .padding(.leading, 14)
                            Spacer()
                        }
                    }
                }
            }
            .padding(.horizontal, 20)

            // Navigate button
            Button(action: { withAnimation { showPinDetail = false; selectedPin = nil } }) {
                Label("Start Navigation", systemImage: "arrow.triangle.turn.up.right.circle.fill")
                    .font(.body.weight(.semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(colors: [Color(hex: "#4A7CF7"), Color(hex: "#2F5FD8")],
                                       startPoint: .leading, endPoint: .trailing),
                        in: RoundedRectangle(cornerRadius: 14)
                    )
                    .shadow(color: Color(hex: "#3A7BF7").opacity(0.28), radius: 10, y: 5)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 32)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.12), radius: 24, y: -6)
    }

    // MARK: Helpers

    private func resetMap() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            mapScale   = 1.0
            mapOffset  = .zero
            lastScale  = 1.0
            lastOffset = .zero
        }
    }
}

// MARK: - Floor Plan Canvas

private struct FloorPlanCanvas: View {
    let size: CGSize
    let routeTarget: HospitalPin?
    let userLocation: CGPoint
    let routeDrawn: Bool

    var body: some View {
        Canvas { ctx, canvasSize in
            let w = canvasSize.width
            let h = canvasSize.height

            // ── Background ──
            ctx.fill(
                Path(CGRect(origin: .zero, size: canvasSize)),
                with: .color(Color(hex: "#E4EAF6"))
            )

            // ── Outer walls ──
            let wallInset: CGFloat = 12
            let wallRect = CGRect(x: wallInset, y: wallInset,
                                  width: w - wallInset*2, height: h - wallInset*2)
            ctx.stroke(
                Path(roundedRect: wallRect, cornerRadius: 8),
                with: .color(Color(hex: "#8A97B8")), lineWidth: 3
            )

            // ── Interior wall grid ──
            drawRooms(ctx: ctx, w: w, h: h)

            // ── Corridors ──
            drawCorridors(ctx: ctx, w: w, h: h)

            // ── Route overlay ──
            if let target = routeTarget, routeDrawn {
                drawRoute(ctx: ctx, w: w, h: h, target: target)
            }
        }
    }

    private func drawRooms(ctx: GraphicsContext, w: CGFloat, h: CGFloat) {
        let rooms: [(CGRect, String, Color)] = [
            // Ground floor layout
            (CGRect(x: w*0.04, y: h*0.25, width: w*0.20, height: h*0.35),  "EMERGENCY",  Color(hex: "#C5CDDF")),
            (CGRect(x: w*0.04, y: h*0.65, width: w*0.20, height: h*0.20),  "RECEPTION",  Color(hex: "#BBCDD8")),
            (CGRect(x: w*0.28, y: h*0.08, width: w*0.22, height: h*0.30),  "SURGERY",    Color(hex: "#B8BFD6")),
            (CGRect(x: w*0.28, y: h*0.44, width: w*0.22, height: h*0.26),  "ICU",        Color(hex: "#C0C8DB")),
            (CGRect(x: w*0.55, y: h*0.08, width: w*0.18, height: h*0.24),  "CARDIOLOGY", Color(hex: "#A8B4D0")),
            (CGRect(x: w*0.55, y: h*0.44, width: w*0.18, height: h*0.24),  "PHARMACY",   Color(hex: "#B4C2D6")),
            (CGRect(x: w*0.77, y: h*0.08, width: w*0.18, height: h*0.24),  "RADIOLOGY",  Color(hex: "#B8C4D4")),
            (CGRect(x: w*0.77, y: h*0.44, width: w*0.18, height: h*0.24),  "LABS",       Color(hex: "#C0CAD8")),
            (CGRect(x: w*0.28, y: h*0.75, width: w*0.67, height: h*0.16),  "WAITING AREA", Color(hex: "#D0D8E8")),
        ]

        for (rect, label, color) in rooms {
            ctx.fill(Path(roundedRect: rect, cornerRadius: 4), with: .color(color))
            ctx.stroke(Path(roundedRect: rect, cornerRadius: 4),
                       with: .color(Color(hex: "#8A97B8").opacity(0.5)), lineWidth: 1)

            // Room label
            ctx.draw(
                Text(label)
                    .font(.system(size: max(7, min(10, rect.width / 7)), weight: .semibold))
                    .foregroundStyle(Color(hex: "#4A5568")),
                at: CGPoint(x: rect.midX, y: rect.midY)
            )
        }
    }

    private func drawCorridors(ctx: GraphicsContext, w: CGFloat, h: CGFloat) {
        // Horizontal main corridor
        let hCorridor = CGRect(x: w*0.04, y: h*0.36, width: w*0.91, height: h*0.07)
        ctx.fill(Path(roundedRect: hCorridor, cornerRadius: 2),
                 with: .color(Color(hex: "#D8DEEC")))

        // Vertical connector
        let vCorridor = CGRect(x: w*0.25, y: h*0.08, width: w*0.04, height: h*0.83)
        ctx.fill(Path(roundedRect: vCorridor, cornerRadius: 2),
                 with: .color(Color(hex: "#D8DEEC")))

        // Second vertical
        let vCorridor2 = CGRect(x: w*0.52, y: h*0.08, width: w*0.04, height: h*0.67)
        ctx.fill(Path(roundedRect: vCorridor2, cornerRadius: 2),
                 with: .color(Color(hex: "#D8DEEC")))

        // Third vertical
        let vCorridor3 = CGRect(x: w*0.74, y: h*0.08, width: w*0.04, height: h*0.60)
        ctx.fill(Path(roundedRect: vCorridor3, cornerRadius: 2),
                 with: .color(Color(hex: "#D8DEEC")))
    }

    private func drawRoute(ctx: GraphicsContext, w: CGFloat, h: CGFloat,
                           target: HospitalPin) {
        // Build a path from user position to selected pin
        let startX = userLocation.x * w
        let startY = userLocation.y * h
        let endX   = target.x * w
        let endY   = target.y * h

        // Simple L-shaped route via corridors
        var routePath = Path()
        routePath.move(to: CGPoint(x: startX, y: startY))

        // Route via corridor logic (simplified for MVP)
        let midY = h * 0.39  // main corridor y-centre
        routePath.addLine(to: CGPoint(x: startX, y: midY))
        routePath.addLine(to: CGPoint(x: endX,   y: midY))
        routePath.addLine(to: CGPoint(x: endX,   y: endY))

        // Glow
        ctx.stroke(routePath,
                   with: .color(Color(hex: "#3A7BF7").opacity(0.18)),
                   style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))

        // Main line
        ctx.stroke(routePath,
                   with: .color(Color(hex: "#3A7BF7")),
                   style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round,
                                      dash: [8, 5]))

        // Direction chevrons along the route
        let chevronPositions: [CGFloat] = [0.25, 0.5, 0.75]
        for t in chevronPositions {
            let px = startX + (endX - startX) * t
            let py = midY
            var chevron = Path()
            chevron.move(to: CGPoint(x: px - 5, y: py - 4))
            chevron.addLine(to: CGPoint(x: px,     y: py))
            chevron.addLine(to: CGPoint(x: px - 5, y: py + 4))
            ctx.stroke(chevron,
                       with: .color(Color(hex: "#3A7BF7")),
                       style: StrokeStyle(lineWidth: 2, lineCap: .round))
        }
    }
}

// MARK: - Comparable clamp helper

extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        HospitalMapFullView()
    }
}
