//////
//////  NotificationsView.swift
//////  ClinicApp
//////
//////  Created by BSCComp-046 on 2026-03-13.
//////
////
//////
//////  NotificationsView.swift
//////  ClinicApp
//////
//////  Created by YourName on 2026-03-13.
//////
////
////import SwiftUI
////
////struct NotificationsView: View {
////    @State private var selectedFilter: FilterType = .all
////
////    enum FilterType {
////        case all, unread
////    }
////
////    var body: some View {
////        ScrollView {
////            VStack(alignment: .leading, spacing: 0) {
////                // Filter Segmented Control
////                HStack(spacing: 6) {
////                    filterButton(title: "All", type: .all)
////                    filterButton(title: "Unread", type: .unread)
////                }
////                .padding(4)
////                .background(
////                    RoundedRectangle(cornerRadius: 10)
////                        .fill(Color(.secondarySystemBackground))
////                        .overlay(
////                            RoundedRectangle(cornerRadius: 10)
////                                .stroke(Color(.separator), lineWidth: 0.5)
////                        )
////                )
////                .padding(.horizontal, 20)
////                .padding(.top, 12)
////                .padding(.bottom, 24)
////
////                // TODAY
////                sectionHeader("Today")
////
////                VStack(spacing: 16) {
////                    NotificationCard(
////                        icon: "person.2.fill",
////                        iconColor: .blue,
////                        title: "Queue Update",
////                        time: "2h ago",
////                        message: "Your current token OPD-45 is 5th in the queue. Please stay near the waiting area.",
////                        isUnread: true,
////                        actionLabel: "View Queue"
////                    )
////
////                    NotificationCard(
////                        icon: "checkmark.circle.fill",
////                        iconColor: .green,
////                        title: "Check-In Successful",
////                        time: "4h ago",
////                        message: "You have successfully checked in for General Medicine with Dr. Sarah Mitchell at Room 302.",
////                        isUnread: false,
////                        actionLabel: nil
////                    )
////                }
////                .padding(.horizontal, 20)
////                .padding(.bottom, 32)
////
////                // YESTERDAY
////                sectionHeader("Yesterday")
////
////                VStack(spacing: 16) {
////                    NotificationCard(
////                        icon: "clipboard.fill",
////                        iconColor: .blue,
////                        title: "Registration Complete",
////                        time: "1d ago",
////                        message: "Your clinic account is active. Use your registration number OPD-REG-45 to log in securely next time.",
////                        isUnread: false,
////                        actionLabel: nil
////                    )
////
////                    NotificationCard(
////                        icon: "book.closed.fill",
////                        iconColor: .purple,
////                        title: "Digital Clinic Book",
////                        time: "2d ago",
////                        message: "Your Digital Clinic Book is ready. View your visits, previous prescriptions, and lab reports all in one place.",
////                        isUnread: false,
////                        actionLabel: "Open Book"
////                    )
////                }
////                .padding(.horizontal, 20)
////                .padding(.bottom, 40)
////            }
////        }
////        .background(Color(.systemGroupedBackground))
////        .navigationTitle("Notifications")
////        .navigationBarTitleDisplayMode(.inline)
////        .toolbar {
////            ToolbarItem(placement: .topBarTrailing) {
////                Button("Mark All Read") {
////                    // Action
////                }
////                .font(.subheadline)
////                .fontWeight(.medium)
////            }
////        }
////    }
////
////    @ViewBuilder
////    private func filterButton(title: String, type: FilterType) -> some View {
////        Button {
////            selectedFilter = type
////        } label: {
////            Text(title)
////                .font(.subheadline)
////                .fontWeight(selectedFilter == type ? .semibold : .medium)
////                .foregroundStyle(selectedFilter == type ? .primary : .secondary)
////                .frame(maxWidth: .infinity)
////                .padding(.vertical, 8)
////                .background(
////                    RoundedRectangle(cornerRadius: 8)
////                        .fill(selectedFilter == type ? Color(.systemBackground) : Color.clear)
////                        .overlay(
////                            RoundedRectangle(cornerRadius: 8)
////                                .stroke(
////                                    selectedFilter == type
////                                    ? Color(.separator)
////                                    : Color.clear,
////                                    lineWidth: 0.6
////                                )
////                        )
////                        .shadow(
////                            color: selectedFilter == type
////                            ? .black.opacity(0.06)
////                            : .clear,
////                            radius: 3,
////                            y: 2
////                        )
////                )
////        }
////    }
////
////    private func sectionHeader(_ title: String) -> some View {
////        Text(title)
////            .font(.title3)
////            .fontWeight(.bold)
////            .foregroundStyle(.primary)
////            .frame(maxWidth: .infinity, alignment: .leading)
////            .padding(.horizontal, 20)
////            .padding(.bottom, 12)
////    }
////}
////
////// MARK: - Notification Card
////struct NotificationCard: View {
////    let icon: String
////    let iconColor: Color
////    let title: String
////    let time: String
////    let message: String
////    let isUnread: Bool
////    let actionLabel: String?
////
////    var body: some View {
////        VStack(alignment: .leading, spacing: 0) {
////            HStack(alignment: .top, spacing: 12) {
////                // Icon
////                RoundedRectangle(cornerRadius: 12)
////                    .fill(iconColor.opacity(0.12))
////                    .frame(width: 48, height: 48)
////                    .overlay(
////                        Image(systemName: icon)
////                            .font(.system(size: 20, weight: .medium))
////                            .foregroundStyle(iconColor)
////                    )
////
////                VStack(alignment: .leading, spacing: 6) {
////                    HStack(spacing: 8) {
////                        HStack(spacing: 6) {
////                            if isUnread {
////                                Circle()
////                                    .fill(.blue)
////                                    .frame(width: 8, height: 8)
////                            }
////
////                            Text(title)
////                                .font(.headline)
////                                .foregroundStyle(.primary)
////                                .lineLimit(1)
////                        }
////
////                        Spacer(minLength: 8)
////
////                        Text(time)
////                            .font(.caption)
////                            .foregroundStyle(.secondary)
////                    }
////
////                    Text(message)
////                        .font(.subheadline)
////                        .foregroundStyle(.secondary)
////                        .fixedSize(horizontal: false, vertical: true)
////                        .lineSpacing(2)
////                        .padding(.trailing, 4)
////                }
////            }
////            .padding(.horizontal, 16)
////            .padding(.top, 16)
////            .padding(.bottom, actionLabel != nil ? 12 : 16)
////
////            if let actionLabel = actionLabel {
////                Divider()
////                    .padding(.leading, 76)
////                    .padding(.trailing, 16)
////
////                Button(action: {
////                    // Action
////                }) {
////                    Text(actionLabel)
////                        .font(.subheadline)
////                        .fontWeight(.semibold)
////                        .foregroundStyle(.blue)
////                        .frame(maxWidth: .infinity, alignment: .leading)
////                        .padding(.leading, 76)
////                        .padding(.vertical, 12)
////                }
////                .buttonStyle(.plain)
////            }
////        }
////        .background(
////            RoundedRectangle(cornerRadius: 16)
////                .fill(Color(.systemBackground))
////                .shadow(
////                    color: .black.opacity(0.05),
////                    radius: 8,
////                    y: 2
////                )
////        )
////    }
////}
////
////#Preview {
////    NavigationStack {
////        NotificationsView()
////    }
////}
//
//
////
////  NotificationsView.swift
////  ClinicApp
////
////  Created by YourName on 2026-03-13.
////
//
//import SwiftUI
//
//struct NotificationsView: View {
//    @State private var selectedFilter: FilterType = .all
//    @Environment(\.dismiss) private var dismiss
//
//    enum FilterType {
//        case all, unread
//    }
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 0) {
//                // Filter Segmented Control
//                HStack(spacing: 6) {
//                    filterButton(title: "All", type: .all)
//                    filterButton(title: "Unread", type: .unread)
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
//                .padding(.top, 12)
//                .padding(.bottom, 24)
//
//                // TODAY
//                sectionHeader("Today")
//
//                VStack(spacing: 16) {
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
//                // YESTERDAY
//                sectionHeader("Yesterday")
//
//                VStack(spacing: 16) {
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
//        .navigationTitle("Notifications")
//        .navigationBarTitleDisplayMode(.large) // Changed to .large for scroll behavior
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                Button("Mark All Read") {
//                    // Action
//                }
//                .font(.subheadline)
//                .fontWeight(.medium)
//            }
//        }
//    }
//
//    @ViewBuilder
//    private func filterButton(title: String, type: FilterType) -> some View {
//        Button {
//            selectedFilter = type
//        } label: {
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
//    private func sectionHeader(_ title: String) -> some View {
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
//// MARK: - Notification Card
//struct NotificationCard: View {
//    let icon: String
//    let iconColor: Color
//    let title: String
//    let time: String
//    let message: String
//    let isUnread: Bool
//    let actionLabel: String?
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 0) {
//            HStack(alignment: .top, spacing: 12) {
//                // Icon
//                RoundedRectangle(cornerRadius: 12)
//                    .fill(iconColor.opacity(0.12))
//                    .frame(width: 48, height: 48)
//                    .overlay(
//                        Image(systemName: icon)
//                            .font(.system(size: 20, weight: .medium))
//                            .foregroundStyle(iconColor)
//                    )
//
//                VStack(alignment: .leading, spacing: 6) {
//                    HStack(spacing: 8) {
//                        HStack(spacing: 6) {
//                            if isUnread {
//                                Circle()
//                                    .fill(.blue)
//                                    .frame(width: 8, height: 8)
//                            }
//
//                            Text(title)
//                                .font(.headline)
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
//                    Text(message)
//                        .font(.subheadline)
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
//            if let actionLabel = actionLabel {
//                Divider()
//                    .padding(.leading, 76)
//                    .padding(.trailing, 16)
//
//                Button(action: {
//                    // Action
//                }) {
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
//#Preview {
//    NavigationStack {
//        NotificationsView()
//    }
//}


import SwiftUI

struct NotificationsView: View {
    @State private var selectedFilter: FilterType = .all

    enum FilterType {
        case all, unread
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {

                // Filter Segmented Control
                HStack(spacing: 6) {
                    filterButton(title: "All", type: .all)
                    filterButton(title: "Unread", type: .unread)
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

                // TODAY
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

                // YESTERDAY
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
        .navigationBarTitleDisplayMode(.large)

        // ✅ UPDATED TOOLBAR
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {

                Menu {

                    Button {
                        // Mark all read action
                    } label: {
                        Label("Mark All as Read", systemImage: "checkmark.circle")
                    }

                    Button(role: .destructive) {
                        // Clear notifications
                    } label: {
                        Label("Clear Notifications", systemImage: "trash")
                    }

                } label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.title3)
                }
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
                            ? .black.opacity(0.05)
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
            .font(.headline) // improved
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
    }
}

// MARK: Notification Card
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

                        Spacer()

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

            if let actionLabel {

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
                    color: .black.opacity(0.04), // improved
                    radius: 6,
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
