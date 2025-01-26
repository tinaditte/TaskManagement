//
//  strings.swift
//  Task Management
//
//  Created by Tina Thomsen on 23/01/2025.
//

struct AppStrings {
    struct Login {
        static let loginTitle = "Login"
        static let usernamePlaceholder = "Username"
        static let passwordPlaceholder = "Password"
        static let loginBtn = "Login"
    }
    
    struct TaskList {
        static let loading = "Loading..."
        static let welcomeTitle = "Welcome %@"
        static let welcomeSubtitle = "Here are your tasks:"
        static let logoutBtn = "Logout"
    }
    
    struct Errors {
        static let invalidUsername = "The username does not exist."
        static let invalidPassword = "The password is incorrect."
        static let fileNotFound = "Data file is missing."
        static let decodingError = "Data could not be processed."
        static let invalidTaskId = "Task ID is invalid."
        static let taskNotFound = "Task could not be updated."
    }
    
    static func formattedString(_ template: String, _ values: CVarArg...) -> String {
        String(format: template, arguments: values)
    }
}
