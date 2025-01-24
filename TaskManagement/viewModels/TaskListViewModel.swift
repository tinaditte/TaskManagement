//
//  TaskListViewModel.swift
//  Task Management
//
//  Created by Tina Thomsen on 23/01/2025.
//

import SwiftUICore
import SwiftUI

@MainActor
class TaskListViewModel: ObservableObject {
    @Published var tasks: [UserTask] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private let dataService: DataService
    
    init(dataService: DataService = DataService()) {
        self.dataService = dataService
    }
    
    
    func loadTasks() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            guard let user = SessionManager.shared.getLoggedInUser() else {
                throw DataError.userNotFound
            }
            tasks = try await dataService.fetchTasks(taskListId: user.tasks)
        } catch {
            errorMessage = ErrorHandler.handle(error: error)
        }
    }
}
