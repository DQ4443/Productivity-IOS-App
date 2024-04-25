//
//  TaskListView.swift
//  Pomo.do
//
//  Created by David Qu on 4/22/24.
//

import SwiftUI

struct TaskListView: View {
    @Binding var task: TaskItem
    
    // TODO: add triple dots for edit options
    // TODO: add edit options View (basically copy from CreateNewTaskView)
    
    var body: some View {
        HStack {
            Text(task.taskName)
                .foregroundColor(task.isChecked ? Color(red: 0.7, green: 0, blue: 0) : .black)
                .strikethrough(task.isChecked)
                .font(.subheadline)
            
            Spacer()
            
            Image(systemName: task.isChecked ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(task.isChecked ? Color(red: 0.8, green: 0, blue: 0) : .black)
                .onTapGesture {
                    task.isChecked.toggle()
                }
            
        }
        .padding()
        .background(task.isChecked ? Color(red: 0.8, green: 0, blue: 0).opacity(0.2) : Color(red: 0.9, green: 0.9, blue: 0.9).opacity(0.8))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 13)
                .stroke(Color.black, lineWidth: 0)
        )
    }
}


// TODO: add flag to indicate priority
// TODO: add flair to indicate category
struct TaskItem: Identifiable {
    let id = UUID()
    var taskName: String
    var isChecked: Bool
}
