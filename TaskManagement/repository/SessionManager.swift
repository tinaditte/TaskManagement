//
//  SessionManager.swift
//  Task Management
//
//  Created by Tina Thomsen on 23/01/2025.
//

import Foundation

class SessionManager: ObservableObject {
    @Published var currentUser: User? { didSet { objectWillChange.send() }}
    
    var isLoggedIn: Bool { currentUser != nil }
    
    static let shared = SessionManager()
    
    private init() { currentUser = getLoggedInUser() }

    func saveLoggedInUser(_ user: User) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: "loggedInUser")
            currentUser = user
        }
    }

    func getLoggedInUser() -> User? {
    #if DEBUG
    if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
        return currentUser
    }
    #endif
    
    if let data = UserDefaults.standard.data(forKey: "loggedInUser") {
        let decoder = JSONDecoder()
        return try? decoder.decode(User.self, from: data)
    }
    return nil
    }

    func logoutUser() {
        UserDefaults.standard.removeObject(forKey: "loggedInUser")
        currentUser = nil
    }
    
}
