//
//  User.swift
//  Task Management
//
//  Created by Tina Thomsen on 23/01/2025.
//

struct UsersContainer: Codable {
    let users: [UserOverview]
}

struct UserOverview: Codable {
    let id: String
    let username: String
}

struct User: Codable {
    let id: String
    let username: String
    let name: String
    let password: String
    var tasks: String
}
