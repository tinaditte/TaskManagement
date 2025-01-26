//
//  TaskListViewModel.swift
//  Task Management
//
//  Created by Tina Thomsen on 23/01/2025.
//

import SwiftUICore
import SwiftUI

class TaskListViewModel: ObservableObject {
    @Published var tasks: [UserTask] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private let dataService: DataService
    
    init(dataService: DataService = DataService()) {
        self.dataService = dataService
    }
    
    @MainActor
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
    
    @MainActor
    func toggleTaskCompletion(taskId: Int) async {
        guard let user = SessionManager.shared.getLoggedInUser() else {
            return
        }
        
        guard let index = tasks.firstIndex(where: { $0.id == taskId }) else {
            errorMessage = ErrorHandler.handle(error: DataError.taskNotFound)
            return
        }
        
        tasks[index].isCompleted.toggle()
        
        do {
            try await dataService.saveTasks(tasks, taskListId: user.tasks)
        } catch {
            errorMessage = ErrorHandler.handle(error: error)
        }
    }
}

