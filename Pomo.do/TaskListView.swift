//
//  TaskListView.swift
//  Pomo.do
//
//  Created by David Qu on 4/22/24.
//

import SwiftUI
import Firebase

struct TaskListView: View {
    @EnvironmentObject var dataManager: DataManager
    var task: TaskItem
    
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
                    updateTaskInFirestore()
                }
            
            Button(action: {
                deleteTaskFromFirestore()
            }) {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(task.isChecked ? Color(red: 0.8, green: 0, blue: 0).opacity(0.6) : .gray)
                    .bold()
                    .padding(.leading, 2)
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
    
    private func updateTaskInFirestore() {
            let db = Firestore.firestore()
            let ref = db.collection("Tasks").document(task.id)
            ref.updateData(["isChecked": !task.isChecked]) { error in
                if let error = error {
                    print("Error updating task in Firestore: \(error.localizedDescription)")
                } else {
                    print("Task updated in Firestore successfully!")
                }
            }
        }
    
    private func deleteTaskFromFirestore() {
        let db = Firestore.firestore()
        let ref = db.collection("Tasks").document(task.id)
        ref.delete { error in
            if let error = error {
                print("Error deleting task from Firestore: \(error.localizedDescription)")
            } else {
                print("Task deleted from Firestore successfully!")
            }
        }
    }
}


// [Beta] TODO: add flag to indicate priority
// [Beta] TODO: add flair to indicate category
struct TaskItem: Identifiable, Codable {
    let id: String
    var taskName: String
    var isChecked: Bool
}

#Preview {
    HomeView(name: .constant("Jay"))
        .environmentObject(DataManager())
}
