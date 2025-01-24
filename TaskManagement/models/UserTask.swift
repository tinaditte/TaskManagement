//
//  Task.swift
//  Task Management
//
//  Created by Tina Thomsen on 23/01/2025.
//

struct UserTaskContainer: Codable {
    var tasks: [UserTask]
}

struct UserTask: Codable, Identifiable {
    let id: Int
    var headline: String
    var description: String
    var isCompleted: Bool
}

