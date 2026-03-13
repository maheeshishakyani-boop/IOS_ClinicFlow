////
////  MainTabView.swift
////  ClinicApp
////
////  Created by BSCComp-046 on 2026-03-13.
////
//
////
////  MainTabView.swift
////  ClinicApp
////
////  Created by YourName on 2026-03-13.
////
//
//import SwiftUI
//
//struct MainTabView: View {
//    init() {
//        let appearance = UITabBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor.systemBackground
//        UITabBar.appearance().standardAppearance = appearance
//        UITabBar.appearance().scrollEdgeAppearance = appearance
//    }
//
//    var body: some View {
//        TabView {
//            HomeView()
//                .tabItem {
//                    Label("Home", systemImage: "house.fill")
//                }
//
//            TrackMyQueueView()
//                .tabItem {
//                    Label("Queue", systemImage: "person.3.sequence.fill")
//                }
//
//            HNavigationScreen()
//                .tabItem {
//                    Label("Navigate", systemImage: "map.fill")
//                }
//
//            DigitalClinicBookView()
//                .tabItem {
//                    Label("Records", systemImage: "book.closed.fill")
//                }
//
//            ProfileView()
//                .tabItem {
//                    Label("Profile", systemImage: "person.circle.fill")
//                }
//        }
//        .accentColor(.blue)
//    }
//}
//
//#Preview {
//    MainTabView()
//}



//
//  MainTabView.swift
//  ClinicApp
//
//  Created by YourName on 2026-03-13.
//
//
//import SwiftUI
//
//struct MainTabView: View {
//    init() {
//        let appearance = UITabBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor.systemBackground
//        UITabBar.appearance().standardAppearance = appearance
//        UITabBar.appearance().scrollEdgeAppearance = appearance
//    }
//
//    var body: some View {
//        TabView {
//            HomeView()
//                .tabItem {
//                    Label("Home", systemImage: "house.fill")
//                }
//
//            TrackMyQueueView()
//                .tabItem {
//                    Label("Queue", systemImage: "person.3.sequence.fill")
//                }
//
//            HNavigationScreen()
//                .tabItem {
//                    Label("Navigate", systemImage: "map.fill")
//                }
//
//            DigitalClinicBookView()
//                .tabItem {
//                    Label("Records", systemImage: "book.closed.fill")
//                }
//
//            // Profile is still accessible but removed from tab bar
//            // Users can access profile through the HomeView avatar button
//        }
//        .accentColor(.blue)
//    }
//}
//
//#Preview {
//    MainTabView()
//}


import SwiftUI

struct MainTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        
        // Customize selected item color to match gradient's blue
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.systemBlue
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        
        appearance.inlineLayoutAppearance.selected.iconColor = UIColor.systemBlue
        appearance.inlineLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        
        appearance.compactInlineLayoutAppearance.selected.iconColor = UIColor.systemBlue
        appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            TrackMyQueueView()
                .tabItem {
                    Label("Queue", systemImage: "person.3.sequence.fill")
                }

            HNavigationScreen()
                .tabItem {
                    Label("Navigate", systemImage: "map.fill")
                }

            DigitalClinicBookView()
                .tabItem {
                    Label("Records", systemImage: "book.closed.fill")
                }

            // Profile is still accessible but removed from tab bar
            // Users can access profile through the HomeView avatar button
        }
        .accentColor(.blue) // This sets the tab bar tint color
        .preferredColorScheme(.light) // Optional: force light mode for consistent colors
    }
}

#Preview {
    MainTabView()
}
