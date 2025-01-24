//
//  TaskManagementApp.swift
//  Task Management
//
//  Created by Tina Thomsen on 23/01/2025.
//

import SwiftUI
import SwiftData
import SwiftUICore

// Lifecycle handler
// Inital navig + root structure

@main
struct TaskManagementApp: App {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var router = Router()
    @StateObject private var sessionManager = SessionManager.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                Group{
                    if sessionManager.isLoggedIn {
                        TaskListView()
                    } else {
                        LoginView()
                    }
                }
                .navigationDestination(for: Router.Destination.self) { destination in
                    switch destination {
                    case .taskListScreen:
                        TaskListView()
                    case .loginScreen:
                        LoginView()
                    }
                }
            }
            .tint(.cream)
            .environmentObject(sessionManager)
            .environmentObject(router)
            .onChange(of: scenePhase) {
                sessionManager.logoutUser()
            }
        }
    }
}
