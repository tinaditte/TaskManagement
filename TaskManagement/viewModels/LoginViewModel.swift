//
//  LoginViewModel.swift
//  Task Management
//
//  Created by Tina Thomsen on 23/01/2025.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private let dataService: DataService
        
    init(dataService: DataService = DataService()) {
        self.dataService = dataService
    }
    
    func handleLoginFlow() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let userOverview = try await dataService.checkUserExistence(username: username)
            let user = try await dataService.checkPassword(userOverview: userOverview, password: password)
            
            SessionManager.shared.saveLoggedInUser(user)
            errorMessage = nil
        } catch {
            errorMessage = ErrorHandler.handle(error: error)
        }
    }
}
