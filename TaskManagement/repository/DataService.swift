//
//  DataService.swift
//  Task Management
//
//  Created by Tina Thomsen on 23/01/2025.
//

import Foundation

class DataService {
    
    static func fetchRequest(resource: String) -> Data? {
        guard let url = Bundle.main.url(forResource: resource, withExtension: "json", subdirectory: "resources/mockData"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        return data
    }
    
    static func checkUserExistence(username: String) -> Bool {
        guard let data = fetchRequest(resource: "users") else {
            print("users.json not found")
            return false
        }
        
        do {
            let usersContainer = try JSONDecoder().decode(UsersContainer.self, from: data)
            return usersContainer.users.contains { $0.username == username }
        } catch {
            print("Error decoding users.json: \(error)")
            return false
        }
    }
    
    static func checkPassword(userId: String, password: String) -> User? {
        guard let data = fetchRequest(resource: "userId") else {
            print("\(userId).json not found")
            return nil
        }
        
        do {
            let user = try JSONDecoder().decode(User.self, from: data)
            return user.password == password ? user : nil
        } catch {
            print("Error parsing JSON: \(error)")
            return nil
        }
    }
}
