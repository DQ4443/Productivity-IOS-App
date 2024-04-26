//
//  DataManager.swift
//  Pomo.do
//
//  Created by David Qu on 4/25/24.
//

import SwiftUI
import Firebase

class DataManager: ObservableObject {
    @Published var tasks: [TaskItem] = []
    
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    init() {
        fetchTasks()
    }
    
    func fetchTasks() {
        listenerRegistration = db.collection("Tasks").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.tasks = documents.compactMap { queryDocumentSnapshot -> TaskItem? in
                let data = queryDocumentSnapshot.data()
                
                let id = data["id"] as? String ?? ""
                let taskName = data["taskName"] as? String ?? ""
                let isChecked = data["isChecked"] as? Bool ?? false
                
                return TaskItem(id: id, taskName: taskName, isChecked: isChecked)
            }
        }
    }
}
