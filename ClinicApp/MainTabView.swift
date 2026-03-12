
import SwiftUI

struct MainTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.shadowColor = UIColor.black.withAlphaComponent(0.08)

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            // Home tab — HomeView owns its own NavigationStack internally.
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }

            // Queue tab
            TrackMyQueueView()
                .tabItem { Label("Queue", systemImage: "person.3.sequence.fill") }

            // Location tab
            LocationView()
                .tabItem { Label("Location", systemImage: "map.fill") }

            // Clinic Book tab — wrap in NavigationStack so the tab bar stays visible
            // when the user navigates to this tab directly.
            // DigitalClinicBookView itself does NOT contain a NavigationStack,
            // so there is no double-stack nesting.
            NavigationStack {
                DigitalClinicBookView()
            }
            .tabItem { Label("Clinic Book", systemImage: "book.closed.fill") }
        }
        .tint(.blue)
    }
}

// MARK: - LocationView

struct LocationView: View {
    var body: some View {
        NavigationStack {
            HNavigationScreen()
        }
    }
}

#Preview {
    MainTabView()
}
