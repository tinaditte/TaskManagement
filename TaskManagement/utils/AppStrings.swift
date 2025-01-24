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
    
    struct Errors {
        static let invalidUsername = "The username does not exist."
        static let invalidPassword = "The password is incorrect."
        static let fileNotFound = "Data file is missing."
        static let decodingError = "Data could not be processed."
        static let invalidTaskId = "Task ID is invalid."
    }
}
