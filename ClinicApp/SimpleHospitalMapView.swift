//////
//////  SimpleHospitalMapView.swift
//////  ClinicApp
//////
//////  Created by BSCComp-046 on 2026-03-11.
//////
////
//////
//////  SimpleHospitalMapView.swift
//////  ClinicApp
//////
//////  Created by [Your Name] on 2026-03-11.
//////
////
////import SwiftUI
////
////// MARK: - Simple Hospital Map View (MVP)
////
////struct SimpleHospitalMapView: View {
////    @Environment(\.dismiss) private var dismiss
////    
////    // Static locations for MVP
////    private let userLocation = CGPoint(x: 0.18, y: 0.82)  // Main Reception
////    private let destinationLocation = CGPoint(x: 0.80, y: 0.28)  // Cardiology Clinic
////    
////    // Static labels
////    private let userLocationName = "You are here: Main Reception"
////    private let destinationName = "Destination: Cardiology Clinic (3rd Floor)"
////    
////    var body: some View {
////        ZStack {
////            Color(.systemGroupedBackground).ignoresSafeArea()
////            
////            VStack(spacing: 0) {
////                // Map Title
////                Text("Navigation Map")
////                    .font(.title2)
////                    .fontWeight(.semibold)
////                    .frame(maxWidth: .infinity, alignment: .leading)
////                    .padding(.horizontal, 20)
////                    .padding(.top, 16)
////                    .padding(.bottom, 8)
////                
////                // Map Container
////                GeometryReader { geo in
////                    ZStack {
////                        // Background Image
////                        Image("hospital_floor_plan")
////                            .resizable()
////                            .aspectRatio(contentMode: .fill)
////                            .frame(width: geo.size.width, height: geo.size.height)
////                            .clipped()
////                            .overlay(
////                                // Fallback color if image doesn't load
////                                Color(hex: "#E8EDF6")
////                            )
////                        
////                        // Navigation Route
////                        RouteOverlay(
////                            start: userLocation,
////                            end: destinationLocation,
////                            size: geo.size
////                        )
////                        
////                        // User Location Pin (You are here)
////                        MapPin(
////                            position: userLocation,
////                            color: .blue,
////                            icon: "location.circle.fill",
////                            label: "You",
////                            size: geo.size
////                        )
////                        
////                        // Destination Pin
////                        MapPin(
////                            position: destinationLocation,
////                            color: Color(hex: "#3A7BF7"),
////                            icon: "mappin.circle.fill",
////                            label: "Cardiology",
////                            size: geo.size
////                        )
////                    }
////                }
////                .frame(height: 400)
////                .clipShape(RoundedRectangle(cornerRadius: 20))
////                .padding(.horizontal, 20)
////                .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
////                
////                // Location Info Cards
////                VStack(spacing: 12) {
////                    // User Location Card
////                    LocationInfoCard(
////                        icon: "location.circle.fill",
////                        iconColor: .blue,
////                        title: "Current Location",
////                        location: userLocationName
////                    )
////                    
////                    // Destination Card
////                    LocationInfoCard(
////                        icon: "mappin.circle.fill",
////                        iconColor: Color(hex: "#3A7BF7"),
////                        title: "Destination",
////                        location: destinationName
////                    )
////                }
////                .padding(.horizontal, 20)
////                .padding(.top, 20)
////                
////                // Navigation Steps
////                VStack(alignment: .leading, spacing: 12) {
////                    Text("Directions")
////                        .font(.headline)
////                        .padding(.horizontal, 20)
////                    
////                    VStack(spacing: 0) {
////                        NavigationStepRow(step: 1, instruction: "Walk straight 20m to central elevators", isLast: false)
////                        NavigationStepRow(step: 2, instruction: "Take elevator to 3rd Floor", isLast: false)
////                        NavigationStepRow(step: 3, instruction: "Turn left at the corridor", isLast: false)
////                        NavigationStepRow(step: 4, instruction: "Cardiology Clinic is on your right", isLast: true)
////                    }
////                    .background(Color(.systemBackground))
////                    .clipShape(RoundedRectangle(cornerRadius: 16))
////                    .padding(.horizontal, 20)
////                    .shadow(color: .black.opacity(0.05), radius: 8, y: 2)
////                }
////                .padding(.top, 16)
////                
////                Spacer()
////                
////                // Start Navigation Button
////                Button(action: {
////                    // Action for starting navigation
////                    dismiss()
////                }) {
////                    Text("Start Navigation")
////                        .font(.headline)
////                        .fontWeight(.semibold)
////                        .foregroundStyle(.white)
////                        .frame(maxWidth: .infinity)
////                        .padding(.vertical, 16)
////                        .background(
////                            LinearGradient(
////                                colors: [Color(hex: "#4A7CF7"), Color(hex: "#2F5FD8")],
////                                startPoint: .leading,
////                                endPoint: .trailing
////                            ),
////                            in: RoundedRectangle(cornerRadius: 14)
////                        )
////                        .shadow(color: Color(hex: "#3A7BF7").opacity(0.3), radius: 10, y: 5)
////                }
////                .padding(.horizontal, 20)
////                .padding(.bottom, 30)
////            }
////        }
////        .navigationTitle("Indoor Navigation")
////        .navigationBarTitleDisplayMode(.inline)
////        .toolbar {
////            ToolbarItem(placement: .navigationBarLeading) {
////                Button(action: { dismiss() }) {
////                    Image(systemName: "chevron.left")
////                        .font(.system(size: 16, weight: .semibold))
////                        .foregroundStyle(Color(hex: "#3A7BF7"))
////                }
////            }
////        }
////    }
////}
////
////// MARK: - Route Overlay (Dotted Line)
////
////struct RouteOverlay: View {
////    let start: CGPoint
////    let end: CGPoint
////    let size: CGSize
////    
////    var body: some View {
////        Canvas { context, _ in
////            let startPoint = CGPoint(x: start.x * size.width, y: start.y * size.height)
////            let endPoint = CGPoint(x: end.x * size.width, y: end.y * size.height)
////            
////            // Create path with waypoints (via corridor)
////            var path = Path()
////            path.move(to: startPoint)
////            
////            // Add waypoint at corridor junction
////            let midY = size.height * 0.39 // corridor level
////            path.addLine(to: CGPoint(x: startPoint.x, y: midY))
////            path.addLine(to: CGPoint(x: endPoint.x, y: midY))
////            path.addLine(to: endPoint)
////            
////            // Draw glow effect
////            context.stroke(
////                path,
////                with: .color(Color(hex: "#3A7BF7").opacity(0.15)),
////                style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round)
////            )
////            
////            // Draw main dotted line
////            context.stroke(
////                path,
////                with: .color(Color(hex: "#3A7BF7")),
////                style: StrokeStyle(
////                    lineWidth: 2.5,
////                    lineCap: .round,
////                    lineJoin: .round,
////                    dash: [8, 6]
////                )
////            )
////            
////            // Draw direction arrows
////            drawArrow(context: context, at: CGPoint(x: startPoint.x + (endPoint.x - startPoint.x) * 0.3, y: midY))
////            drawArrow(context: context, at: CGPoint(x: startPoint.x + (endPoint.x - startPoint.x) * 0.6, y: midY))
////        }
////    }
////    
////    private func drawArrow(context: GraphicsContext, at point: CGPoint) {
////        var arrow = Path()
////        arrow.move(to: CGPoint(x: point.x - 6, y: point.y - 4))
////        arrow.addLine(to: CGPoint(x: point.x, y: point.y))
////        arrow.addLine(to: CGPoint(x: point.x - 6, y: point.y + 4))
////        
////        context.stroke(
////            arrow,
////            with: .color(Color(hex: "#3A7BF7")),
////            style: StrokeStyle(lineWidth: 2, lineCap: .round)
////        )
////    }
////}
////
////// MARK: - Map Pin
////
////struct MapPin: View {
////    let position: CGPoint
////    let color: Color
////    let icon: String
////    let label: String
////    let size: CGSize
////    
////    var body: some View {
////        VStack(spacing: 2) {
////            // Pin with glow
////            ZStack {
////                // Outer glow
////                Circle()
////                    .fill(color.opacity(0.2))
////                    .frame(width: 44, height: 44)
////                
////                // Inner circle
////                Circle()
////                    .fill(color)
////                    .frame(width: 32, height: 32)
////                    .shadow(color: color.opacity(0.4), radius: 4, y: 2)
////                
////                // Icon
////                Image(systemName: icon)
////                    .font(.system(size: 16, weight: .medium))
////                    .foregroundStyle(.white)
////            }
////            
////            // Label
////            Text(label)
////                .font(.caption2)
////                .fontWeight(.medium)
////                .padding(.horizontal, 8)
////                .padding(.vertical, 3)
////                .background(Color(.systemBackground))
////                .clipShape(Capsule())
////                .shadow(color: .black.opacity(0.1), radius: 2)
////        }
////        .position(
////            x: position.x * size.width,
////            y: (position.y * size.height) - 25 // Offset to place pin above the point
////        )
////    }
////}
////
////// MARK: - Location Info Card
////
////struct LocationInfoCard: View {
////    let icon: String
////    let iconColor: Color
////    let title: String
////    let location: String
////    
////    var body: some View {
////        HStack(spacing: 14) {
////            ZStack {
////                RoundedRectangle(cornerRadius: 10)
////                    .fill(iconColor.opacity(0.12))
////                    .frame(width: 44, height: 44)
////                
////                Image(systemName: icon)
////                    .font(.system(size: 20, weight: .medium))
////                    .foregroundStyle(iconColor)
////            }
////            
////            VStack(alignment: .leading, spacing: 4) {
////                Text(title)
////                    .font(.caption)
////                    .foregroundStyle(.secondary)
////                
////                Text(location)
////                    .font(.subheadline)
////                    .fontWeight(.medium)
////                    .foregroundStyle(.primary)
////                    .lineLimit(2)
////            }
////            
////            Spacer()
////        }
////        .padding(12)
////        .background(Color(.systemBackground))
////        .clipShape(RoundedRectangle(cornerRadius: 14))
////        .shadow(color: .black.opacity(0.05), radius: 8, y: 2)
////    }
////}
////
////// MARK: - Navigation Step Row
////
////struct NavigationStepRow: View {
////    let step: Int
////    let instruction: String
////    let isLast: Bool
////    
////    var body: some View {
////        HStack(alignment: .top, spacing: 16) {
////            // Step number circle
////            ZStack {
////                Circle()
////                    .fill(isLast ? Color.green.opacity(0.12) : Color(hex: "#3A7BF7").opacity(0.12))
////                    .frame(width: 30, height: 30)
////                
////                if isLast {
////                    Image(systemName: "checkmark.circle.fill")
////                        .font(.system(size: 14))
////                        .foregroundStyle(.green)
////                } else {
////                    Text("\(step)")
////                        .font(.system(size: 13, weight: .bold))
////                        .foregroundStyle(Color(hex: "#3A7BF7"))
////                }
////            }
////            
////            Text(instruction)
////                .font(.subheadline)
////                .foregroundStyle(Color(.label))
////                .fixedSize(horizontal: false, vertical: true)
////            
////            Spacer()
////        }
////        .padding(.horizontal, 16)
////        .padding(.vertical, 12)
////        
////        if !isLast {
////            Divider()
////                .padding(.leading, 62)
////        }
////    }
////}
////
////// MARK: - Update HNavigationScreen to use SimpleHospitalMapView
////
////// Add this to your HNavigationScreen.swift file, replacing the existing navigation
////// In HNavigationScreen, change the navigateToFullMap destination:
////
/////*
//// NavigationLink(destination: SimpleHospitalMapView(), isActive: $navigateToFullMap) {
////     EmptyView()
//// }
//// .hidden()
////*/
////
////// MARK: - Preview
////
////#Preview {
////    NavigationStack {
////        SimpleHospitalMapView()
////    }
////}
//
//
////
////  SimpleHospitalMapView.swift
////  ClinicApp
////
////  Created by BSCComp-046 on 2026-03-11.
////
//
//import SwiftUI
//
//// MARK: - Simple Hospital Map View (MVP)
//
//struct SimpleHospitalMapView: View {
//    @Environment(\.dismiss) private var dismiss
//    
//    // Static locations for MVP
//    private let userLocation = CGPoint(x: 0.18, y: 0.82)  // Main Reception
//    private let destinationLocation = CGPoint(x: 0.80, y: 0.28)  // Cardiology Clinic
//    
//    // Static labels
//    private let userLocationName = "You are here: Main Reception"
//    private let destinationName = "Destination: Cardiology Clinic (3rd Floor)"
//    
//    var body: some View {
//        // REMOVED the ZStack with Color and moved it to background
//        VStack(spacing: 0) {
//            // Map Title
//            Text("Navigation Map")
//                .font(.title2)
//                .fontWeight(.semibold)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.horizontal, 20)
//                .padding(.top, 16)
//                .padding(.bottom, 8)
//            
//            // Map Container
//            GeometryReader { geo in
//                ZStack {
//                    // Background Image - Check your asset name!
//                    // In your assets, you have "Screenshot 2026-03-11 at 12.04.12.png"
//                    // Let's use the correct name
//                    if let _ = UIImage(named: "Screenshot 2026-03-11 at 12.04.12") {
//                        Image("Screenshot 2026-03-11 at 12.04.12")
//                            .resizable()
//                            .aspectRatio(contentMode: .fill)
//                            .frame(width: geo.size.width, height: geo.size.height)
//                            .clipped()
//                    } else {
//                        // Fallback colored background with grid if image not found
//                        ZStack {
//                            Color(hex: "#E8EDF6")
//                            
//                            // Grid overlay
//                            Path { path in
//                                for i in 0...8 {
//                                    let x = (geo.size.width / 9) * CGFloat(i)
//                                    path.move(to: CGPoint(x: x, y: 0))
//                                    path.addLine(to: CGPoint(x: x, y: geo.size.height))
//                                }
//                                for i in 0...6 {
//                                    let y = (geo.size.height / 7) * CGFloat(i)
//                                    path.move(to: CGPoint(x: 0, y: y))
//                                    path.addLine(to: CGPoint(x: geo.size.width, y: y))
//                                }
//                            }
//                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
//                            
//                            // Room labels
//                            Text("EMERGENCY")
//                                .font(.caption2)
//                                .foregroundStyle(.gray)
//                                .position(x: geo.size.width * 0.12, y: geo.size.height * 0.42)
//                            
//                            Text("CARDIOLOGY")
//                                .font(.caption2)
//                                .foregroundStyle(Color(hex: "#3A7BF7"))
//                                .position(x: geo.size.width * 0.80, y: geo.size.height * 0.28)
//                            
//                            Text("RECEPTION")
//                                .font(.caption2)
//                                .foregroundStyle(.gray)
//                                .position(x: geo.size.width * 0.18, y: geo.size.height * 0.82)
//                            
//                            Text("PHARMACY")
//                                .font(.caption2)
//                                .foregroundStyle(.gray)
//                                .position(x: geo.size.width * 0.64, y: geo.size.height * 0.55)
//                        }
//                    }
//                    
//                    // Navigation Route
//                    RouteOverlay(
//                        start: userLocation,
//                        end: destinationLocation,
//                        size: geo.size
//                    )
//                    
//                    // User Location Pin (You are here)
//                    MapPin(
//                        position: userLocation,
//                        color: .blue,
//                        icon: "location.circle.fill",
//                        label: "You",
//                        size: geo.size
//                    )
//                    
//                    // Destination Pin
//                    MapPin(
//                        position: destinationLocation,
//                        color: Color(hex: "#3A7BF7"),
//                        icon: "mappin.circle.fill",
//                        label: "Cardiology",
//                        size: geo.size
//                    )
//                }
//            }
//            .frame(height: 400)
//            .clipShape(RoundedRectangle(cornerRadius: 20))
//            .padding(.horizontal, 20)
//            .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
//            
//            // Location Info Cards
//            VStack(spacing: 12) {
//                // User Location Card
//                LocationInfoCard(
//                    icon: "location.circle.fill",
//                    iconColor: .blue,
//                    title: "Current Location",
//                    location: userLocationName
//                )
//                
//                // Destination Card
//                LocationInfoCard(
//                    icon: "mappin.circle.fill",
//                    iconColor: Color(hex: "#3A7BF7"),
//                    title: "Destination",
//                    location: destinationName
//                )
//            }
//            .padding(.horizontal, 20)
//            .padding(.top, 20)
//            
//            // Navigation Steps
//            VStack(alignment: .leading, spacing: 12) {
//                Text("Directions")
//                    .font(.headline)
//                    .padding(.horizontal, 20)
//                
//                VStack(spacing: 0) {
//                    NavigationStepRow(step: 1, instruction: "Walk straight 20m to central elevators", isLast: false)
//                    NavigationStepRow(step: 2, instruction: "Take elevator to 3rd Floor", isLast: false)
//                    NavigationStepRow(step: 3, instruction: "Turn left at the corridor", isLast: false)
//                    NavigationStepRow(step: 4, instruction: "Cardiology Clinic is on your right", isLast: true)
//                }
//                .background(Color(.systemBackground))
//                .clipShape(RoundedRectangle(cornerRadius: 16))
//                .padding(.horizontal, 20)
//                .shadow(color: .black.opacity(0.05), radius: 8, y: 2)
//            }
//            .padding(.top, 16)
//            
//            Spacer()
//            
//            // Start Navigation Button
//            Button(action: {
//                dismiss()
//            }) {
//                Text("Start Navigation")
//                    .font(.headline)
//                    .fontWeight(.semibold)
//                    .foregroundStyle(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding(.vertical, 16)
//                    .background(
//                        LinearGradient(
//                            colors: [Color(hex: "#4A7CF7"), Color(hex: "#2F5FD8")],
//                            startPoint: .leading,
//                            endPoint: .trailing
//                        ),
//                        in: RoundedRectangle(cornerRadius: 14)
//                    )
//                    .shadow(color: Color(hex: "#3A7BF7").opacity(0.3), radius: 10, y: 5)
//            }
//            .padding(.horizontal, 20)
//            .padding(.bottom, 30)
//        }
//        .background(Color(.systemGroupedBackground))
//        .navigationTitle("Indoor Navigation")
//        .navigationBarTitleDisplayMode(.inline)
//        // REMOVED the custom back button - let the navigation bar handle it naturally
//    }
//}
//
//// MARK: - Route Overlay (Dotted Line)
//
//struct RouteOverlay: View {
//    let start: CGPoint
//    let end: CGPoint
//    let size: CGSize
//    
//    var body: some View {
//        Canvas { context, _ in
//            let startPoint = CGPoint(x: start.x * size.width, y: start.y * size.height)
//            let endPoint = CGPoint(x: end.x * size.width, y: end.y * size.height)
//            
//            // Create path with waypoints (via corridor)
//            var path = Path()
//            path.move(to: startPoint)
//            
//            // Add waypoint at corridor junction
//            let midY = size.height * 0.39 // corridor level
//            path.addLine(to: CGPoint(x: startPoint.x, y: midY))
//            path.addLine(to: CGPoint(x: endPoint.x, y: midY))
//            path.addLine(to: endPoint)
//            
//            // Draw glow effect
//            context.stroke(
//                path,
//                with: .color(Color(hex: "#3A7BF7").opacity(0.15)),
//                style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round)
//            )
//            
//            // Draw main dotted line
//            context.stroke(
//                path,
//                with: .color(Color(hex: "#3A7BF7")),
//                style: StrokeStyle(
//                    lineWidth: 2.5,
//                    lineCap: .round,
//                    lineJoin: .round,
//                    dash: [8, 6]
//                )
//            )
//            
//            // Draw direction arrows
//            drawArrow(context: context, at: CGPoint(x: startPoint.x + (endPoint.x - startPoint.x) * 0.3, y: midY))
//            drawArrow(context: context, at: CGPoint(x: startPoint.x + (endPoint.x - startPoint.x) * 0.6, y: midY))
//        }
//    }
//    
//    private func drawArrow(context: GraphicsContext, at point: CGPoint) {
//        var arrow = Path()
//        arrow.move(to: CGPoint(x: point.x - 6, y: point.y - 4))
//        arrow.addLine(to: CGPoint(x: point.x, y: point.y))
//        arrow.addLine(to: CGPoint(x: point.x - 6, y: point.y + 4))
//        
//        context.stroke(
//            arrow,
//            with: .color(Color(hex: "#3A7BF7")),
//            style: StrokeStyle(lineWidth: 2, lineCap: .round)
//        )
//    }
//}
//
//// MARK: - Map Pin
//
//struct MapPin: View {
//    let position: CGPoint
//    let color: Color
//    let icon: String
//    let label: String
//    let size: CGSize
//    
//    var body: some View {
//        VStack(spacing: 2) {
//            // Pin with glow
//            ZStack {
//                // Outer glow
//                Circle()
//                    .fill(color.opacity(0.2))
//                    .frame(width: 44, height: 44)
//                
//                // Inner circle
//                Circle()
//                    .fill(color)
//                    .frame(width: 32, height: 32)
//                    .shadow(color: color.opacity(0.4), radius: 4, y: 2)
//                
//                // Icon
//                Image(systemName: icon)
//                    .font(.system(size: 16, weight: .medium))
//                    .foregroundStyle(.white)
//            }
//            
//            // Label
//            Text(label)
//                .font(.caption2)
//                .fontWeight(.medium)
//                .padding(.horizontal, 8)
//                .padding(.vertical, 3)
//                .background(Color(.systemBackground))
//                .clipShape(Capsule())
//                .shadow(color: .black.opacity(0.1), radius: 2)
//        }
//        .position(
//            x: position.x * size.width,
//            y: (position.y * size.height) - 25 // Offset to place pin above the point
//        )
//    }
//}
//
//// MARK: - Location Info Card
//
//struct LocationInfoCard: View {
//    let icon: String
//    let iconColor: Color
//    let title: String
//    let location: String
//    
//    var body: some View {
//        HStack(spacing: 14) {
//            ZStack {
//                RoundedRectangle(cornerRadius: 10)
//                    .fill(iconColor.opacity(0.12))
//                    .frame(width: 44, height: 44)
//                
//                Image(systemName: icon)
//                    .font(.system(size: 20, weight: .medium))
//                    .foregroundStyle(iconColor)
//            }
//            
//            VStack(alignment: .leading, spacing: 4) {
//                Text(title)
//                    .font(.caption)
//                    .foregroundStyle(.secondary)
//                
//                Text(location)
//                    .font(.subheadline)
//                    .fontWeight(.medium)
//                    .foregroundStyle(.primary)
//                    .lineLimit(2)
//            }
//            
//            Spacer()
//        }
//        .padding(12)
//        .background(Color(.systemBackground))
//        .clipShape(RoundedRectangle(cornerRadius: 14))
//        .shadow(color: .black.opacity(0.05), radius: 8, y: 2)
//    }
//}
//
//// MARK: - Navigation Step Row
//
//struct NavigationStepRow: View {
//    let step: Int
//    let instruction: String
//    let isLast: Bool
//    
//    var body: some View {
//        HStack(alignment: .top, spacing: 16) {
//            // Step number circle
//            ZStack {
//                Circle()
//                    .fill(isLast ? Color.green.opacity(0.12) : Color(hex: "#3A7BF7").opacity(0.12))
//                    .frame(width: 30, height: 30)
//                
//                if isLast {
//                    Image(systemName: "checkmark.circle.fill")
//                        .font(.system(size: 14))
//                        .foregroundStyle(.green)
//                } else {
//                    Text("\(step)")
//                        .font(.system(size: 13, weight: .bold))
//                        .foregroundStyle(Color(hex: "#3A7BF7"))
//                }
//            }
//            
//            Text(instruction)
//                .font(.subheadline)
//                .foregroundStyle(Color(.label))
//                .fixedSize(horizontal: false, vertical: true)
//            
//            Spacer()
//        }
//        .padding(.horizontal, 16)
//        .padding(.vertical, 12)
//        
//        if !isLast {
//            Divider()
//                .padding(.leading, 62)
//        }
//    }
//}
//
//// MARK: - Preview
//
//#Preview {
//    NavigationStack {
//        SimpleHospitalMapView()
//    }
//}


import SwiftUI

// MARK: - Simple Hospital Map View (MVP)
// ─────────────────────────────────────────────────────────────
// HOW TO FIX THE IMAGE:
//   Your image is named "Screenshot 2026-03-11 at 12.04.12.png"
//   in Finder, but Xcode asset names cannot have spaces or dots
//   in the middle. Do ONE of the following:
//
//   OPTION A (recommended):
//     1. In Assets.xcassets, click on the image asset
//     2. Rename it to:  hospital_map
//     3. The constant below is already set to "hospital_map" ✓
//
//   OPTION B (no rename needed):
//     Change the constant below to:
//     private let assetName = "Screenshot 2026-03-11 at 12.04.12"
// ─────────────────────────────────────────────────────────────

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
