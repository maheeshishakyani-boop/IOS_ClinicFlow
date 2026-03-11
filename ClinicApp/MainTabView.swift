////////////
//
//import SwiftUI
//
//struct MainTabView: View {
//    init() {
//        let appearance = UITabBarAppearance()
//        appearance.configureWithDefaultBackground()
//        appearance.backgroundColor = UIColor.systemBackground
//        appearance.shadowColor = UIColor.black.withAlphaComponent(0.08)
//       
//        UITabBar.appearance().standardAppearance = appearance
//        UITabBar.appearance().scrollEdgeAppearance = appearance
//    }
//   
//    var body: some View {
//        TabView {
//            HomeView()
//                .tabItem { Label("Home", systemImage: "house.fill") }
//           
//            TrackMyQueueView()                    // ← Direct access from bottom tab
//                .tabItem { Label("Queue", systemImage: "person.3.sequence.fill") }
//           
//            LocationView()
//                .tabItem { Label("Location", systemImage: "map.fill") }
//           
//            DigitalClinicBookView()
//                .tabItem { Label("Clinic Book", systemImage: "book.closed.fill") }
//        }
//        .tint(.blue)
//    }
//}
//
//// Placeholder views for other tabs
//struct LocationView: View {
//    var body: some View {
//        NavigationStack {
//            ScrollView { Text("Hospital Navigation").font(.largeTitle).padding() }
//                .navigationTitle("Location")
//                .navigationBarTitleDisplayMode(.large)
//                .background(Color(.systemGroupedBackground))
//        }
//    }
//}
//
//struct DigitalClinicBookView: View {
//    var body: some View {
//        NavigationStack {
//            ScrollView { Text("Digital Clinic Book").font(.largeTitle).padding() }
//                .navigationTitle("Clinic Book")
//                .navigationBarTitleDisplayMode(.large)
//                .background(Color(.systemGroupedBackground))
//        }
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
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.shadowColor = UIColor.black.withAlphaComponent(0.08)
       
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
   
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }
           
            TrackMyQueueView()
                .tabItem { Label("Queue", systemImage: "person.3.sequence.fill") }
           
            LocationView()
                .tabItem { Label("Location", systemImage: "map.fill") }
           
            DigitalClinicBookView()
                .tabItem { Label("Clinic Book", systemImage: "book.closed.fill") }
        }
        .tint(.blue)
    }
}

// Updated LocationView that uses your HNavigationScreen
struct LocationView: View {
    var body: some View {
        NavigationStack {
            HNavigationScreen()
        }
    }
}

// DigitalClinicBookView remains the same
struct DigitalClinicBookView: View {
    var body: some View {
        NavigationStack {
            ScrollView { Text("Digital Clinic Book").font(.largeTitle).padding() }
                .navigationTitle("Clinic Book")
                .navigationBarTitleDisplayMode(.large)
                .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    MainTabView()
}
