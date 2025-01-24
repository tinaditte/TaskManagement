//
//  Router.swift
//  TaskManagement
//
//  Created by Tina Thomsen on 24/01/2025.
//

import SwiftUI

final class Router: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case loginScreen
        case taskListScreen
    }
    
    @Published var navPath = NavigationPath()
    
    func handleInitialNavigation(isLoggedIn: Bool) {
        resetFlow(isLoggedIn ? .taskListScreen : .loginScreen)
    }
    
    func resetFlow(_ destination: Destination) {
        navPath = NavigationPath()
        navPath.append(destination)
    }
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        guard !navPath.isEmpty else { return }
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath = NavigationPath()
    }
}


