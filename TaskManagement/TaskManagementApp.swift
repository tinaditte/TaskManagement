//
//  Task_ManagementApp.swift
//  Task Management
//
//  Created by Tina Thomsen on 23/01/2025.
//

import SwiftUI
import SwiftData

// Lifecycle handler
// Inital navig + root structure

@main
struct Task_ManagementApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
