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
    
    init() {
        _viewModel = StateObject(wrappedValue: TaskListViewModel(dataService: DataService()))
    }
    
    var body: some View {
        ZStack {
            Color.deepOcean.ignoresSafeArea()
            
            if viewModel.isLoading {
                ProgressView("Loading tasks...")
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
                        Text("Welcome \(sessionManager.currentUser?.name ?? "User")")
                            .font(.largeTitle.bold())
                            .foregroundColor(.cream)
                        Text("What task shall we tackle today?")
                            .font(.headline)
                            .foregroundColor(.fontBrown)
                    }
                    .padding(.horizontal)
                    
                    // Task List Section
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.cream)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                        .overlay(
                            List(viewModel.tasks, id: \.id) { task in
                                TaskCellView(task: task)
                                    .listRowSeparatorTint(.darkBrown)
                                    .listRowInsets(EdgeInsets())
                            }
                                .listStyle(.plain)
                                .scrollContentBackground(.hidden)
                        )
                }
                .padding()
            }
        }
        .onAppear {
            Task {
                await viewModel.loadTasks()
            }
        }
    }
}

struct TaskCellView: View {
    let task: UserTask
    var body: some View {
        HStack {
            // Checkbox
            Circle()
                .strokeBorder(Color.darkBrown, lineWidth: 2)
                .frame(width: 24, height: 24)
                .overlay(
                    task.isCompleted ? Image(systemName: "checkmark")
                        .font(.caption.bold())
                        .foregroundColor(.darkBrown) : nil
                )
            // Task Headline
            Text(task.headline)
                .font(.body)
                .foregroundColor(.fontBrown)
                .padding(.horizontal)
            Spacer()
            // Navigation Arrow
            Image(systemName: "chevron.right")
                .foregroundColor(.midBlue)
        }
        .padding()
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
