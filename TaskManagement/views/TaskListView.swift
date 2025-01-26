//
//  TaskListVie.swift
//  Task Management
//
//  Created by Tina Thomsen on 23/01/2025.
//

import SwiftUICore
import SwiftUI

struct TaskListView: View {
    @StateObject var viewModel: TaskListViewModel
    @EnvironmentObject var router: Router
    @EnvironmentObject var sessionManager: SessionManager
    
    private var isPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
    init() {
        _viewModel = StateObject(wrappedValue: TaskListViewModel(dataService: DataService()))
    }
    
    private func loadData() {
        if isPreview {
            viewModel.tasks = SampleData.mockTasks
        } else {
            Task {
                await viewModel.loadTasks()
            }
        }
    }
    
    private func logout() {
        sessionManager.logoutUser()
    }
    
    private func toggleTask(taskId: Int) {
        if !isPreview {
            Task {
                await viewModel.toggleTaskCompletion(taskId: taskId)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.deepOcean.ignoresSafeArea()
            
            if viewModel.isLoading {
                ProgressView(AppStrings.TaskList.loading)
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundColor(.cream)
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                VStack(alignment: .leading, spacing: 20) {
                    // Title Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text(AppStrings.formattedString(
                            AppStrings.TaskList.welcomeTitle,
                            SessionManager.shared.currentUser?.name ?? "User")
                        )
                            .font(.largeTitle.bold())
                            .foregroundColor(.bearBrown)
                        Text(AppStrings.TaskList.welcomeSubtitle)
                            .font(.headline)
                            .foregroundColor(.bearBrown)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    List(viewModel.tasks, id: \.id) { task in
                        TaskCellView(task: task, onToggle: {
                            toggleTask(taskId: task.id)
                        })
                            .listRowBackground(Color.cream)
                            .padding(.horizontal, -10)
                            .listRowSeparatorTint(.darkBrown)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(Color.cream)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .shadow(radius: 5)
                }
                .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(AppStrings.TaskList.logoutBtn) {
                    logout()
                }
                .foregroundColor(.cream)
            }
        }
        .onAppear {
            loadData()
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
            .environmentObject(SessionManager.shared)
            .environmentObject(Router())
    }
}
