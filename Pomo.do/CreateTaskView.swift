//
//  CreateTaskView.swift
//  Pomo.do
//
//  Created by David Qu on 4/25/24.
//

import SwiftUI

struct CreateTaskView: View {
    @Binding var tasks: [TaskItem]
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var newTaskNameTemp = ""
    @State private var newTaskDescriptionTemp = ""
    
    @State private var selectedCategory = "Work"
    @State private var selectedPriorityLevel = "High"
    
    @State private var showEmptyTaskNameMessage = false
    
    let category = ["School", "Work", "Personal", "Lifestyle", "Admin", "Other"]
    let priorityLevels = ["Low", "Medium", "High"]
    
    // [Beta] Add task functionality such as category and priority
    
    var body: some View {
        VStack {
            // Title + X
            HStack {
                Text("Create New Task Item")
                    .font(.headline)
                    
                    
                
                Spacer()
                
                NavigationLink(destination: HomeView(name: $name)) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                }
                
            }
            .padding(.top, 60)
            .padding(.bottom)
            .padding(.horizontal, 40)
            
            Divider()
                .padding(.horizontal, 30)
            
            // Task Name Box
            VStack {
                HStack {
                    Text("Task Name (Required)")
                        .font(.subheadline)
                        .padding(.top, 10)
                        .padding(.bottom, -20)
                    Spacer()
                }
                
                TextField("Name", text: $newTaskNameTemp)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .cornerRadius(5.0)
                    .padding(.vertical, 20)
                    .autocorrectionDisabled()
            }
            .padding(.horizontal, 30)
            
            // [Beta] Task Decription Box
            VStack {
                HStack {
                    Text("[Beta] Task Description")
                        .font(.subheadline)
                        .padding(.bottom, -20)
                    Spacer()
                }
                
                TextField("Description", text: $newTaskDescriptionTemp)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    .cornerRadius(5.0)
                    .padding(.vertical, 20)
                    .autocorrectionDisabled()
            }
            .padding(.horizontal, 30)
            
            // [Beta] Drop down menu section
            VStack {
                HStack {
                    Text("Category")
                    Spacer()
                    Picker("", selection: $selectedCategory) {
                        ForEach(category, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .accentColor(Color(red: 0.8, green: 0, blue: 0))
                    
                }
                
                HStack {
                    Text("Priority Level")
                    Spacer()
                    Picker("", selection: $selectedPriorityLevel) {
                        ForEach(priorityLevels, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .accentColor(Color(red: 0.8, green: 0, blue: 0))
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
            
            // Create Task Button
            VStack {
                Button(action: {
                    if (!newTaskNameTemp.isEmpty) {
                        let newTask = TaskItem(taskName: newTaskNameTemp, isChecked: false)
                        tasks.append(newTask)
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        showEmptyTaskNameMessage = true
                    }
                    
                }) {
                    ZStack {
                        Text("Create Task")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(Color(red: 0.8, green: 0, blue: 0))
                            .cornerRadius(5.0)
                        
                        if (showEmptyTaskNameMessage) {
                            Text("Please enter a task name")
                                .font(.subheadline)
                                .foregroundColor(.red)
                                .padding(.top, 70)
                                .padding(.bottom, -20)
                        }
                            
                    }
                    
                }
            }
            .padding(.bottom, 60)
            
            
            
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .shadow(radius: 2)
        )
        .padding(.horizontal, 40)
        .padding(.vertical, 40)
        .navigationBarBackButtonHidden()
        
    }
}

#Preview {
    CreateTaskView(tasks: .constant([TaskItem(taskName: "Proposal Document", isChecked: true)]))
}
