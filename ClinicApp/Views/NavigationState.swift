////
////  NavigationState.swift
////  ClinicApp
////
////  Created by BSCComp-046 on 2026-03-13.
////
////
////import SwiftUI
////
////class NavigationState: ObservableObject {
////    @Published var path = NavigationPath()
////    
////    func popToRoot() {
////        path = NavigationPath()
////    }
////}
////
////
////
////  NavigationState.swift
////  ClinicApp
////
////  Created by BSCComp-046 on 2026-03-13.
////
//
//import SwiftUI
//import Combine
//
//class NavigationState: ObservableObject {
//    @Published var path = NavigationPath()
//    
//    func popToRoot() {
//        path = NavigationPath()
//    }
//}
//
//
//
//
//



import SwiftUI
import Combine

// Enum to type-safely represent all navigation destinations
enum AppRoute: Hashable {
    case registration
    case registrationSuccess(opdNumber: String)
    case otp
}

class NavigationState: ObservableObject {
    @Published var path = NavigationPath()

    func popToRoot() {
        path = NavigationPath()
    }
}


