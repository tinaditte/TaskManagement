//
//  TaskCellView.swift
//  TaskManagement
//
//  Created by Tina Thomsen on 26/01/2025.
//

import SwiftUICore
import SwiftUI

struct TaskCellView: View {
    let task: UserTask
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onToggle) {
                Image(systemName: task.isCompleted ? "checkmark.square" : "square")
                    .foregroundColor(.darkBrown)
            }
            Text(task.headline)
                .foregroundColor(.fontBrown)
                .font(.body)
                .padding(.leading, 10)
            
            Spacer()
            
            //Image(systemName: "chevron.right")
            //    .foregroundColor(.midBlue)
        }
        .padding(.vertical, 10)
        .background(Color.cream)
        .clipped()
    }
}
