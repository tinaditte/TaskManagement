//
//  Task.swift
//  Task Management
//
//  Created by Tina Thomsen on 23/01/2025.
//

struct Task: Codable {
    let id: Int
    var headline: String
    var description: String
    var isCompleted: Bool
}
