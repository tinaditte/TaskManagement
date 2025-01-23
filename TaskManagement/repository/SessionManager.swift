//
//  SessionManager.swift
//  Task Management
//
//  Created by Tina Thomsen on 23/01/2025.
//

import Foundation

class SessionManager {
    static let shared = SessionManager()
    private init() {}
    
    var currentUser: User?
    
    func saveLoggedInUser(_ user: User) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: "loggedInUser")
            currentUser = user
        }
    }
    
    func getLoggedInUser() -> User? {
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

// idea: simulate automatic user logout after x minutes inactivity with Timer
// Show logout screen or login popup when session expires
