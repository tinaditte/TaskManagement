//
//  DataService.swift
//  Task Management
//
//  Created by Tina Thomsen on 23/01/2025.
//

import Foundation

class DataService {
    private let mockDelay: TimeInterval

    init(mockDelay: TimeInterval = 2.0) {
        self.mockDelay = mockDelay
    }
    
    func fetchRequest(resource: String) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64(mockDelay * 1_000_000_000))
        
        guard let url = Bundle.main.url(forResource: resource, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            throw DataError.fileNotFound
        }
        return data
    }
    
    func checkUserExistence(username: String) async throws -> UserOverview {
        let data = try await fetchRequest(resource: "users")
        let usersContainer = try JSONDecoder().decode(UsersContainer.self, from: data)
        
        guard let userOverview = usersContainer.users.first(where: { $0.username == username }) else {
            throw DataError.userNotFound
        }
        return userOverview
    }
    
    func checkPassword(userOverview: UserOverview, password: String) async throws -> User {
        let data = try await fetchRequest(resource: userOverview.id)
        let userContainer = try JSONDecoder().decode([String: User].self, from: data)
        
        guard let user = userContainer[userOverview.id] else {
            throw DataError.userNotFound
        }
        guard user.password == password else {
            throw DataError.invalidCredentials
        }
        return user
    }
    
    func fetchTasks(taskListId: String) async throws -> [UserTask] {
            guard let data = try? await fetchRequest(resource: taskListId) else {
                throw DataError.fileNotFound
            }
            
            guard let container = try? JSONDecoder().decode(UserTaskContainer.self, from: data) else {
                throw DataError.decodingError
            }
            
            return container.tasks
    }
    
    func saveTasks(_ tasks: [UserTask], taskListId: String) async throws {
        try await Task.sleep(nanoseconds: UInt64(1_000_000_000))
        
        guard let url = Bundle.main.url(forResource: taskListId, withExtension: "json") else {
            throw DataError.fileNotFound
        }

        let data = try JSONEncoder().encode(tasks)
        try data.write(to: url)
    }
}
