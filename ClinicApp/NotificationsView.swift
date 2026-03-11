//////
//////  NotificationsView.swift
//////  ClinicApp
//////
//////  Created by COBSCCOM-45 on 2026-03-11.
//////
////
////import SwiftUI
////
////// MARK: - Notification Model
////
////enum NotificationCategory {
////    case queue, checkIn, registration, clinicBook, appointment, prescription
////
////    var icon: String {
////        switch self {
////        case .queue:         return "person.2.fill"
////        case .checkIn:       return "checkmark.circle.fill"
////        case .registration:  return "clipboard.fill"
////        case .clinicBook:    return "book.closed.fill"
////        case .appointment:   return "calendar"
////        case .prescription:  return "pill.fill"
////        }
////    }
////
////    var iconColor: Color {
////        switch self {
////        case .queue:         return .blue
////        case .checkIn:       return .green
////        case .registration:  return .blue
////        case .clinicBook:    return .purple
////        case .appointment:   return .orange
////        case .prescription:  return .teal
////        }
////    }
////}
////
////struct AppNotification: Identifiable {
////    let id = UUID()
////    let category: NotificationCategory
////    let title: String
////    let message: String
////    let time: String
////    var isRead: Bool
////    /// Optional CTA label — if non-nil a tappable action button is shown
////    let actionLabel: String?
////}
////
////// MARK: - NotificationsView
////// Presented as a full-screen sheet from HomeView's bell button.
////// Follows iOS notification-centre conventions:
//////  • Large title that stays at the top
//////  • Filter segmented control (All / Unread)
//////  • Grouped sections (Today / Yesterday)
//////  • Swipe-to-dismiss via .presentationDragIndicator
////
////struct NotificationsView: View {
////    @Environment(\.dismiss) private var dismiss
////
////    @State private var filter: NotificationFilter = .all
////    @State private var notifications: [AppNotification] = sampleNotifications
////
////    enum NotificationFilter: String, CaseIterable {
////        case all    = "All"
////        case unread = "Unread"
////    }
////
////    var unreadCount: Int {
////        notifications.filter { !$0.isRead }.count
////    }
////
////    var todayNotifications: [AppNotification] {
////        let all = notifications.filter { $0.time.contains("ago") && !$0.time.contains("1d") && !$0.time.contains("2d") }
////        return filter == .unread ? all.filter { !$0.isRead } : all
////    }
////
////    var yesterdayNotifications: [AppNotification] {
////        let all = notifications.filter { $0.time.contains("1d") || $0.time.contains("2d") }
////        return filter == .unread ? all.filter { !$0.isRead } : all
////    }
////
////    var body: some View {
////        NavigationStack {
////            ScrollView {
////                VStack(alignment: .leading, spacing: 0) {
////
////                    // ── Filter Segmented Control ─────────────────────────────
////                    filterControl
////                        .padding(.horizontal, 20)
////                        .padding(.top, 16)
////                        .padding(.bottom, 8)
////
////                    // ── Today ────────────────────────────────────────────────
////                    if !todayNotifications.isEmpty {
////                        sectionHeader("Today")
////                        VStack(spacing: 12) {
////                            ForEach(todayNotifications) { notification in
////                                NotificationCard(
////                                    notification: notification,
////                                    onRead: { markRead(notification) }
////                                )
////                            }
////                        }
////                        .padding(.horizontal, 20)
////                        .padding(.bottom, 24)
////                    }
////
////                    // ── Yesterday ────────────────────────────────────────────
////                    if !yesterdayNotifications.isEmpty {
////                        sectionHeader("Yesterday")
////                        VStack(spacing: 12) {
////                            ForEach(yesterdayNotifications) { notification in
////                                NotificationCard(
////                                    notification: notification,
////                                    onRead: { markRead(notification) }
////                                )
////                            }
////                        }
////                        .padding(.horizontal, 20)
////                        .padding(.bottom, 24)
////                    }
////
////                    // ── Empty state ──────────────────────────────────────────
////                    if todayNotifications.isEmpty && yesterdayNotifications.isEmpty {
////                        emptyState
////                    }
////                }
////            }
////            .background(Color(.systemGroupedBackground))
////            .navigationTitle("Notifications")
////            .navigationBarTitleDisplayMode(.large)
////            .toolbar {
////                ToolbarItem(placement: .topBarLeading) {
////                    Button {
////                        dismiss()
////                    } label: {
////                        HStack(spacing: 4) {
////                            Image(systemName: "chevron.left")
////                                .font(.system(size: 16, weight: .semibold))
////                            Text("Back")
////                                .font(.body)
////                        }
////                        .foregroundStyle(.blue)
////                    }
////                }
////                ToolbarItem(placement: .topBarTrailing) {
////                    Button("Mark All Read") {
////                        withAnimation {
////                            markAllRead()
////                        }
////                    }
////                    .font(.subheadline)
////                    .foregroundStyle(unreadCount > 0 ? .blue : .secondary)
////                    .disabled(unreadCount == 0)
////                }
////            }
////            .toolbarBackground(Color(.systemGroupedBackground), for: .navigationBar)
////            .toolbarBackground(.visible, for: .navigationBar)
////        }
////        // Standard iOS sheet drag indicator
////        .presentationDragIndicator(.visible)
////        // Allow the sheet to expand to full height like iOS Notification Centre
////        .presentationDetents([.large])
////    }
////
////    // MARK: - Filter Control
////
////    private var filterControl: some View {
////        HStack(spacing: 0) {
////            ForEach(NotificationFilter.allCases, id: \.self) { tab in
////                Button {
////                    withAnimation(.easeInOut(duration: 0.2)) {
////                        filter = tab
////                    }
////                } label: {
////                    HStack(spacing: 6) {
////                        Text(tab.rawValue)
////                            .font(.subheadline)
////                            .fontWeight(.semibold)
////                        if tab == .unread && unreadCount > 0 {
////                            Text("\(unreadCount)")
////                                .font(.caption2)
////                                .fontWeight(.bold)
////                                .foregroundStyle(.white)
////                                .padding(.horizontal, 6)
////                                .padding(.vertical, 2)
////                                .background(Capsule().fill(Color.blue))
////                        }
////                    }
////                    .foregroundStyle(filter == tab ? .primary : .secondary)
////                    .frame(maxWidth: .infinity)
////                    .padding(.vertical, 8)
////                    .background(
////                        RoundedRectangle(cornerRadius: 8)
////                            .fill(filter == tab ? Color(.systemBackground) : Color.clear)
////                            .shadow(color: filter == tab ? .black.opacity(0.06) : .clear, radius: 4, y: 2)
////                    )
////                }
////            }
////        }
////        .padding(4)
////        .background(
////            RoundedRectangle(cornerRadius: 11)
////                .fill(Color(.secondarySystemBackground))
////        )
////    }
////
////    // MARK: - Section Header
////
////    private func sectionHeader(_ title: String) -> some View {
////        Text(title)
////            .font(.title3)
////            .fontWeight(.bold)
////            .foregroundStyle(.primary)
////            .padding(.horizontal, 20)
////            .padding(.top, 16)
////            .padding(.bottom, 10)
////    }
////
////    // MARK: - Empty State
////
////    private var emptyState: some View {
////        VStack(spacing: 16) {
////            Image(systemName: "bell.slash")
////                .font(.system(size: 48, weight: .light))
////                .foregroundStyle(.secondary)
////            Text("No Notifications")
////                .font(.title3)
////                .fontWeight(.semibold)
////            Text("You're all caught up.")
////                .font(.subheadline)
////                .foregroundStyle(.secondary)
////        }
////        .frame(maxWidth: .infinity)
////        .padding(.top, 80)
////    }
////
////    // MARK: - Actions
////
////    private func markRead(_ notification: AppNotification) {
////        if let idx = notifications.firstIndex(where: { $0.id == notification.id }) {
////            notifications[idx].isRead = true
////        }
////    }
////
////    private func markAllRead() {
////        for idx in notifications.indices {
////            notifications[idx].isRead = true
////        }
////    }
////}
////
////// MARK: - NotificationCard
////
////struct NotificationCard: View {
////    let notification: AppNotification
////    let onRead: () -> Void
////
////    var body: some View {
////        VStack(alignment: .leading, spacing: 0) {
////
////            // ── Main Row ────────────────────────────────────────────────────
////            HStack(alignment: .top, spacing: 14) {
////
////                // Icon container
////                ZStack {
////                    RoundedRectangle(cornerRadius: 12)
////                        .fill(notification.category.iconColor.opacity(0.12))
////                        .frame(width: 46, height: 46)
////                    Image(systemName: notification.category.icon)
////                        .font(.system(size: 20, weight: .medium))
////                        .foregroundStyle(notification.category.iconColor)
////                }
////
////                VStack(alignment: .leading, spacing: 4) {
////                    HStack(alignment: .firstTextBaseline) {
////                        // Unread blue dot
////                        if !notification.isRead {
////                            Circle()
////                                .fill(Color.blue)
////                                .frame(width: 8, height: 8)
////                                .offset(y: -1)
////                        }
////
////                        Text(notification.title)
////                            .font(.subheadline)
////                            .fontWeight(.semibold)
////                            .foregroundStyle(.primary)
////                            .lineLimit(1)
////
////                        Spacer()
////
////                        Text(notification.time)
////                            .font(.caption)
////                            .foregroundStyle(.secondary)
////                    }
////
////                    Text(notification.message)
////                        .font(.subheadline)
////                        .foregroundStyle(.secondary)
////                        .fixedSize(horizontal: false, vertical: true)
////                        .lineLimit(3)
////                }
////            }
////            .padding(16)
////            .contentShape(Rectangle())
////            .onTapGesture {
////                withAnimation(.easeInOut(duration: 0.15)) {
////                    onRead()
////                }
////            }
////
////            // ── CTA Action Button ────────────────────────────────────────────
////            if let label = notification.actionLabel {
////                Divider()
////                    .padding(.horizontal, 16)
////
////                Button {} label: {
////                    Text(label)
////                        .font(.subheadline)
////                        .fontWeight(.semibold)
////                        .foregroundStyle(.blue)
////                        .frame(maxWidth: .infinity)
////                        .padding(.vertical, 12)
////                }
////            }
////        }
////        .background(
////            RoundedRectangle(cornerRadius: 16)
////                .fill(Color(.systemBackground))
////                .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
////        )
////        // Subtle left-edge highlight for unread items
////        .overlay(alignment: .leading) {
////            if !notification.isRead {
////                RoundedRectangle(cornerRadius: 3)
////                    .fill(Color.blue)
////                    .frame(width: 3)
////                    .padding(.vertical, 12)
////                    .padding(.leading, 1)
////            }
////        }
////        .clipShape(RoundedRectangle(cornerRadius: 16))
////    }
////}
////
////// MARK: - Sample Data
////
////private let sampleNotifications: [AppNotification] = [
////    AppNotification(
////        category: .queue,
////        title: "Queue Update",
////        message: "Your current token OPD-45 is 5th in the queue. Please stay near the waiting area to avoid missing your turn.",
////        time: "2h ago",
////        isRead: false,
////        actionLabel: "View Queue"
////    ),
////    AppNotification(
////        category: .checkIn,
////        title: "Check-In Successful",
////        message: "You have successfully checked in for General Medicine with Dr. Sarah Mitchell at Room 302.",
////        time: "4h ago",
////        isRead: true,
////        actionLabel: nil
////    ),
////    AppNotification(
////        category: .registration,
////        title: "Registration Complete",
////        message: "Your clinic account is active. Use your registration number OPD-REG-45 to log in securely next time.",
////        time: "1d ago",
////        isRead: true,
////        actionLabel: nil
////    ),
////    AppNotification(
////        category: .clinicBook,
////        title: "Digital Clinic Book",
////        message: "Your Digital Clinic Book is ready. View your visits, previous prescriptions, and lab reports all in one place.",
////        time: "2d ago",
////        isRead: false,
////        actionLabel: "Open Book"
////    )
////]
////
////#Preview {
////    NotificationsView()
////}
//
//
//import SwiftUI
//
//// MARK: - NotificationsView
//// Pushed via NavigationLink from HomeView — the system provides the
//// "< Back" button automatically. No sheet, no custom back button.
//
//struct NotificationsView: View {
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 0) {
//
//                // ── Segmented Filter (static) ────────────────────────────────
//                HStack(spacing: 0) {
//                    // "All" — selected state
//                    Text("All")
//                        .font(.subheadline)
//                        .fontWeight(.semibold)
//                        .foregroundStyle(.primary)
//                        .frame(maxWidth: .infinity)
//                        .padding(.vertical, 8)
//                        .background(
//                            RoundedRectangle(cornerRadius: 8)
//                                .fill(Color(.systemBackground))
//                                .shadow(color: .black.opacity(0.06), radius: 4, y: 2)
//                        )
//
//                    // "Unread (1)" — unselected state
//                    Text("Unread (1)")
//                        .font(.subheadline)
//                        .fontWeight(.medium)
//                        .foregroundStyle(.secondary)
//                        .frame(maxWidth: .infinity)
//                        .padding(.vertical, 8)
//                }
//                .padding(4)
//                .background(
//                    RoundedRectangle(cornerRadius: 11)
//                        .fill(Color(.secondarySystemBackground))
//                )
//                .padding(.horizontal, 20)
//                .padding(.top, 16)
//                .padding(.bottom, 4)
//
//                // ── TODAY ────────────────────────────────────────────────────
//                sectionHeader("Today")
//
//                VStack(spacing: 12) {
//
//                    // Card 1 — Queue Update (has blue dot + CTA button)
//                    NotificationCard {
//                        HStack(alignment: .top, spacing: 14) {
//                            notifIcon(systemName: "person.2.fill", color: .blue)
//
//                            VStack(alignment: .leading, spacing: 4) {
//                                HStack(alignment: .firstTextBaseline, spacing: 5) {
//                                    // Blue unread dot
//                                    Circle()
//                                        .fill(Color.blue)
//                                        .frame(width: 8, height: 8)
//                                        .offset(y: -1)
//
//                                    Text("Queue Update")
//                                        .font(.subheadline)
//                                        .fontWeight(.semibold)
//                                        .foregroundStyle(.primary)
//
//                                    Spacer()
//
//                                    Text("2h ago")
//                                        .font(.caption)
//                                        .foregroundStyle(.secondary)
//                                }
//
//                                Text("Your current token OPD-45 is 5th in the queue. Please stay near the waiting area to avoid missing your turn.")
//                                    .font(.subheadline)
//                                    .foregroundStyle(.secondary)
//                                    .fixedSize(horizontal: false, vertical: true)
//                            }
//                        }
//                        .padding(16)
//                    } actionLabel: {
//                        Text("View Queue")
//                            .font(.subheadline)
//                            .fontWeight(.semibold)
//                            .foregroundStyle(.blue)
//                            .frame(maxWidth: .infinity)
//                            .padding(.vertical, 12)
//                    }
//
//                    // Card 2 — Check-In Successful (no CTA)
//                    NotificationCard {
//                        HStack(alignment: .top, spacing: 14) {
//                            notifIcon(systemName: "checkmark.circle.fill", color: .green)
//
//                            VStack(alignment: .leading, spacing: 4) {
//                                HStack(alignment: .firstTextBaseline) {
//                                    Text("Check-In Successful")
//                                        .font(.subheadline)
//                                        .fontWeight(.semibold)
//                                        .foregroundStyle(.primary)
//                                    Spacer()
//                                    Text("4h ago")
//                                        .font(.caption)
//                                        .foregroundStyle(.secondary)
//                                }
//
//                                Text("You have successfully checked in for General Medicine with Dr. Sarah Mitchell at Room 302.")
//                                    .font(.subheadline)
//                                    .foregroundStyle(.secondary)
//                                    .fixedSize(horizontal: false, vertical: true)
//                            }
//                        }
//                        .padding(16)
//                    } actionLabel: { EmptyView() }
//                }
//                .padding(.horizontal, 20)
//                .padding(.bottom, 24)
//
//                // ── YESTERDAY ────────────────────────────────────────────────
//                sectionHeader("Yesterday")
//
//                VStack(spacing: 12) {
//
//                    // Card 3 — Registration Complete (no CTA)
//                    NotificationCard {
//                        HStack(alignment: .top, spacing: 14) {
//                            notifIcon(systemName: "clipboard.fill", color: .blue)
//
//                            VStack(alignment: .leading, spacing: 4) {
//                                HStack(alignment: .firstTextBaseline) {
//                                    Text("Registration Complete")
//                                        .font(.subheadline)
//                                        .fontWeight(.semibold)
//                                        .foregroundStyle(.primary)
//                                    Spacer()
//                                    Text("1d ago")
//                                        .font(.caption)
//                                        .foregroundStyle(.secondary)
//                                }
//
//                                Text("Your clinic account is active. Use your registration number OPD-REG-45 to log in securely next time.")
//                                    .font(.subheadline)
//                                    .foregroundStyle(.secondary)
//                                    .fixedSize(horizontal: false, vertical: true)
//                            }
//                        }
//                        .padding(16)
//                    } actionLabel: { EmptyView() }
//
//                    // Card 4 — Digital Clinic Book (has CTA button)
//                    NotificationCard {
//                        HStack(alignment: .top, spacing: 14) {
//                            notifIcon(systemName: "book.closed.fill", color: .blue)
//
//                            VStack(alignment: .leading, spacing: 4) {
//                                HStack(alignment: .firstTextBaseline) {
//                                    Text("Digital Clinic Book")
//                                        .font(.subheadline)
//                                        .fontWeight(.semibold)
//                                        .foregroundStyle(.primary)
//                                    Spacer()
//                                    Text("2d ago")
//                                        .font(.caption)
//                                        .foregroundStyle(.secondary)
//                                }
//
//                                Text("Your Digital Clinic Book is ready. View your visits, previous prescriptions, and lab reports all in one place.")
//                                    .font(.subheadline)
//                                    .foregroundStyle(.secondary)
//                                    .fixedSize(horizontal: false, vertical: true)
//                            }
//                        }
//                        .padding(16)
//                    } actionLabel: {
//                        Text("Open Book")
//                            .font(.subheadline)
//                            .fontWeight(.semibold)
//                            .foregroundStyle(.primary)
//                            .frame(maxWidth: .infinity)
//                            .padding(.vertical, 12)
//                    }
//                }
//                .padding(.horizontal, 20)
//                .padding(.bottom, 32)
//            }
//        }
//        .background(Color(.systemGroupedBackground))
//        .navigationTitle("Notifications")
//        .navigationBarTitleDisplayMode(.large)
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                Text("Mark All Read")
//                    .font(.subheadline)
//                    .foregroundStyle(.blue)
//            }
//        }
//        .toolbarBackground(Color(.systemGroupedBackground), for: .navigationBar)
//        .toolbarBackground(.visible, for: .navigationBar)
//    }
//
//    // MARK: - Helpers
//
//    private func sectionHeader(_ title: String) -> some View {
//        Text(title)
//            .font(.title3)
//            .fontWeight(.bold)
//            .foregroundStyle(.primary)
//            .padding(.horizontal, 20)
//            .padding(.top, 20)
//            .padding(.bottom, 12)
//    }
//
//    private func notifIcon(systemName: String, color: Color) -> some View {
//        RoundedRectangle(cornerRadius: 12)
//            .fill(color.opacity(0.12))
//            .frame(width: 46, height: 46)
//            .overlay(
//                Image(systemName: systemName)
//                    .font(.system(size: 20, weight: .medium))
//                    .foregroundStyle(color)
//            )
//    }
//}
//
//// MARK: - NotificationCard
//// Generic card shell: body content on top, optional CTA button below a divider.
//
//struct NotificationCard<Body: View, Action: View>: View {
//    @ViewBuilder let body: () -> Body
//    @ViewBuilder let actionLabel: () -> Action
//
//    var body: some View {
//        VStack(spacing: 0) {
//            body()
//
//            // Only show divider + action if action is not EmptyView
//            if !(actionLabel() is EmptyView) {
//                Divider()
//                    .padding(.horizontal, 16)
//                actionLabel()
//            }
//        }
//        .background(
//            RoundedRectangle(cornerRadius: 16)
//                .fill(Color(.systemBackground))
//                .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
//        )
//    }
//}
//
//#Preview {
//    NavigationStack {
//        NotificationsView()
//    }
//}


//import SwiftUI
//
//// MARK: - NotificationsView
//
//struct NotificationsView: View {
//    
//    @State private var selectedFilter: FilterType = .all
//    
//    enum FilterType {
//        case all, unread
//    }
//    
//    var body: some View {
//        
//        ScrollView {
//            
//            VStack(alignment: .leading, spacing: 0) {
//                
//                // MARK: Header
//                HStack {
//                    
//                    Text("Notifications")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                    
//                    Spacer()
//                    
//                    Button("Mark All Read") {
//                        
//                    }
//                    .font(.subheadline)
//                    .fontWeight(.medium)
//                    .foregroundStyle(.blue)
//                }
//                .padding(.horizontal, 20)
//                .padding(.top, 16)
//                .padding(.bottom, 12)
//                
//                
//                // MARK: Filter Segmented Control
//                
//                HStack(spacing: 6) {
//                    
//                    filterButton(
//                        title: "All",
//                        type: .all
//                    )
//                    
//                    filterButton(
//                        title: "Unread",
//                        type: .unread
//                    )
//                    .frame(maxWidth: .infinity * 0.9) // slightly shorter visual
//                }
//                .padding(4)
//                .background(
//                    RoundedRectangle(cornerRadius: 10)
//                        .fill(Color(.secondarySystemBackground))
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(Color(.separator), lineWidth: 0.5)
//                        )
//                )
//                .padding(.horizontal, 20)
//                .padding(.bottom, 24)
//                
//                
//                // MARK: TODAY
//                
//                sectionHeader("Today")
//                
//                VStack(spacing: 16) {
//                    
//                    NotificationCard(
//                        icon: "person.2.fill",
//                        iconColor: .blue,
//                        title: "Queue Update",
//                        time: "2h ago",
//                        message: "Your current token OPD-45 is 5th in the queue. Please stay near the waiting area.",
//                        isUnread: true,
//                        actionLabel: "View Queue"
//                    )
//                    
//                    NotificationCard(
//                        icon: "checkmark.circle.fill",
//                        iconColor: .green,
//                        title: "Check-In Successful",
//                        time: "4h ago",
//                        message: "You have successfully checked in for General Medicine with Dr. Sarah Mitchell at Room 302.",
//                        isUnread: false,
//                        actionLabel: nil
//                    )
//                }
//                .padding(.horizontal, 20)
//                .padding(.bottom, 32)
//                
//                
//                // MARK: YESTERDAY
//                
//                sectionHeader("Yesterday")
//                
//                VStack(spacing: 16) {
//                    
//                    NotificationCard(
//                        icon: "clipboard.fill",
//                        iconColor: .blue,
//                        title: "Registration Complete",
//                        time: "1d ago",
//                        message: "Your clinic account is active. Use your registration number OPD-REG-45 to log in securely next time.",
//                        isUnread: false,
//                        actionLabel: nil
//                    )
//                    
//                    NotificationCard(
//                        icon: "book.closed.fill",
//                        iconColor: .purple,
//                        title: "Digital Clinic Book",
//                        time: "2d ago",
//                        message: "Your Digital Clinic Book is ready. View your visits, previous prescriptions, and lab reports all in one place.",
//                        isUnread: false,
//                        actionLabel: "Open Book"
//                    )
//                }
//                .padding(.horizontal, 20)
//                .padding(.bottom, 40)
//            }
//        }
//        .background(Color(.systemGroupedBackground))
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar(.hidden, for: .navigationBar)
//    }
//    
//    
//    // MARK: Filter Button
//    
//    @ViewBuilder
//    private func filterButton(title: String, type: FilterType) -> some View {
//        
//        Button {
//            selectedFilter = type
//        } label: {
//            
//            Text(title)
//                .font(.subheadline)
//                .fontWeight(selectedFilter == type ? .semibold : .medium)
//                .foregroundStyle(selectedFilter == type ? .primary : .secondary)
//                .frame(maxWidth: .infinity)
//                .padding(.vertical, 8)
//                .background(
//                    RoundedRectangle(cornerRadius: 8)
//                        .fill(selectedFilter == type ? Color(.systemBackground) : Color.clear)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 8)
//                                .stroke(
//                                    selectedFilter == type
//                                    ? Color(.separator)
//                                    : Color.clear,
//                                    lineWidth: 0.6
//                                )
//                        )
//                        .shadow(
//                            color: selectedFilter == type
//                            ? .black.opacity(0.06)
//                            : .clear,
//                            radius: 3,
//                            y: 2
//                        )
//                )
//        }
//    }
//    
//    
//    // MARK: Section Header
//    
//    private func sectionHeader(_ title: String) -> some View {
//        
//        Text(title)
//            .font(.title3)
//            .fontWeight(.bold)
//            .foregroundStyle(.primary)
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .padding(.horizontal, 20)
//            .padding(.bottom, 12)
//    }
//}
//
//
//
//// MARK: - Notification Card
//
//struct NotificationCard: View {
//    
//    let icon: String
//    let iconColor: Color
//    let title: String
//    let time: String
//    let message: String
//    let isUnread: Bool
//    let actionLabel: String?
//    
//    var body: some View {
//        
//        VStack(alignment: .leading, spacing: 0) {
//            
//            HStack(alignment: .top, spacing: 12) {
//                
//                // Icon
//                
//                RoundedRectangle(cornerRadius: 12)
//                    .fill(iconColor.opacity(0.12))
//                    .frame(width: 48, height: 48)
//                    .overlay(
//                        Image(systemName: icon)
//                            .font(.system(size: 20, weight: .medium))
//                            .foregroundStyle(iconColor)
//                    )
//                
//                
//                VStack(alignment: .leading, spacing: 6) {
//                    
//                    HStack(spacing: 8) {
//                        
//                        HStack(spacing: 6) {
//                            
//                            if isUnread {
//                                Circle()
//                                    .fill(.blue)
//                                    .frame(width: 8, height: 8)
//                            }
//                            
//                            Text(title)
//                                .font(.headline) // dynamic type friendly
//                                .foregroundStyle(.primary)
//                                .lineLimit(1)
//                        }
//                        
//                        Spacer(minLength: 8)
//                        
//                        Text(time)
//                            .font(.caption)
//                            .foregroundStyle(.secondary)
//                    }
//                    
//                    
//                    Text(message)
//                        .font(.subheadline) // dynamic iOS text
//                        .foregroundStyle(.secondary)
//                        .fixedSize(horizontal: false, vertical: true)
//                        .lineSpacing(2)
//                        .padding(.trailing, 4)
//                }
//            }
//            .padding(.horizontal, 16)
//            .padding(.top, 16)
//            .padding(.bottom, actionLabel != nil ? 12 : 16)
//            
//            
//            if let actionLabel = actionLabel {
//                
//                Divider()
//                    .padding(.leading, 76)
//                    .padding(.trailing, 16)
//                
//                Button(action: {
//                    
//                }) {
//                    
//                    Text(actionLabel)
//                        .font(.subheadline)
//                        .fontWeight(.semibold)
//                        .foregroundStyle(.blue)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 76)
//                        .padding(.vertical, 12)
//                }
//                .buttonStyle(.plain)
//            }
//        }
//        .background(
//            RoundedRectangle(cornerRadius: 16)
//                .fill(Color(.systemBackground))
//                .shadow(
//                    color: .black.opacity(0.05),
//                    radius: 8,
//                    y: 2
//                )
//        )
//    }
//}
//
//
//
//#Preview {
//    NavigationStack {
//        NotificationsView()
//    }
//}



import SwiftUI

// MARK: - NotificationsView

struct NotificationsView: View {
    
    @State private var selectedFilter: FilterType = .all
    
    enum FilterType {
        case all, unread
    }
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 0) {
                
                // MARK: Filter Segmented Control
                
                HStack(spacing: 6) {
                    
                    filterButton(
                        title: "All",
                        type: .all
                    )
                    
                    filterButton(
                        title: "Unread",
                        type: .unread
                    )
                }
                .padding(4)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.secondarySystemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.separator), lineWidth: 0.5)
                        )
                )
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 24)
                
                
                // MARK: TODAY
                
                sectionHeader("Today")
                
                VStack(spacing: 16) {
                    
                    NotificationCard(
                        icon: "person.2.fill",
                        iconColor: .blue,
                        title: "Queue Update",
                        time: "2h ago",
                        message: "Your current token OPD-45 is 5th in the queue. Please stay near the waiting area.",
                        isUnread: true,
                        actionLabel: "View Queue"
                    )
                    
                    NotificationCard(
                        icon: "checkmark.circle.fill",
                        iconColor: .green,
                        title: "Check-In Successful",
                        time: "4h ago",
                        message: "You have successfully checked in for General Medicine with Dr. Sarah Mitchell at Room 302.",
                        isUnread: false,
                        actionLabel: nil
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
                
                
                // MARK: YESTERDAY
                
                sectionHeader("Yesterday")
                
                VStack(spacing: 16) {
                    
                    NotificationCard(
                        icon: "clipboard.fill",
                        iconColor: .blue,
                        title: "Registration Complete",
                        time: "1d ago",
                        message: "Your clinic account is active. Use your registration number OPD-REG-45 to log in securely next time.",
                        isUnread: false,
                        actionLabel: nil
                    )
                    
                    NotificationCard(
                        icon: "book.closed.fill",
                        iconColor: .purple,
                        title: "Digital Clinic Book",
                        time: "2d ago",
                        message: "Your Digital Clinic Book is ready. View your visits, previous prescriptions, and lab reports all in one place.",
                        isUnread: false,
                        actionLabel: "Open Book"
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
        
        // MARK: Navigation Bar Button
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Mark All Read") {
                    
                }
                .font(.subheadline)
                .fontWeight(.medium)
            }
        }
    }
    
    
    // MARK: Filter Button
    
    @ViewBuilder
    private func filterButton(title: String, type: FilterType) -> some View {
        
        Button {
            selectedFilter = type
        } label: {
            
            Text(title)
                .font(.subheadline)
                .fontWeight(selectedFilter == type ? .semibold : .medium)
                .foregroundStyle(selectedFilter == type ? .primary : .secondary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(selectedFilter == type ? Color(.systemBackground) : Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    selectedFilter == type
                                    ? Color(.separator)
                                    : Color.clear,
                                    lineWidth: 0.6
                                )
                        )
                        .shadow(
                            color: selectedFilter == type
                            ? .black.opacity(0.06)
                            : .clear,
                            radius: 3,
                            y: 2
                        )
                )
        }
    }
    
    
    // MARK: Section Header
    
    private func sectionHeader(_ title: String) -> some View {
        
        Text(title)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
    }
}



// MARK: - Notification Card

struct NotificationCard: View {
    
    let icon: String
    let iconColor: Color
    let title: String
    let time: String
    let message: String
    let isUnread: Bool
    let actionLabel: String?
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .top, spacing: 12) {
                
                // Icon
                
                RoundedRectangle(cornerRadius: 12)
                    .fill(iconColor.opacity(0.12))
                    .frame(width: 48, height: 48)
                    .overlay(
                        Image(systemName: icon)
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(iconColor)
                    )
                
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    HStack(spacing: 8) {
                        
                        HStack(spacing: 6) {
                            
                            if isUnread {
                                Circle()
                                    .fill(.blue)
                                    .frame(width: 8, height: 8)
                            }
                            
                            Text(title)
                                .font(.headline)
                                .foregroundStyle(.primary)
                                .lineLimit(1)
                        }
                        
                        Spacer(minLength: 8)
                        
                        Text(time)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    
                    
                    Text(message)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(2)
                        .padding(.trailing, 4)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, actionLabel != nil ? 12 : 16)
            
            
            if let actionLabel = actionLabel {
                
                Divider()
                    .padding(.leading, 76)
                    .padding(.trailing, 16)
                
                Button(action: {
                    
                }) {
                    
                    Text(actionLabel)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 76)
                        .padding(.vertical, 12)
                }
                .buttonStyle(.plain)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(
                    color: .black.opacity(0.05),
                    radius: 8,
                    y: 2
                )
        )
    }
}



#Preview {
    NavigationStack {
        NotificationsView()
    }
}
