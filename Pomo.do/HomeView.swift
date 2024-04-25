//
//  HomeView.swift
//  Pomo.do
//
//  Created by David Qu on 4/22/24.
//

import SwiftUI

struct HomeView: View {
    @Binding var name: String
    
    @State var tasks = [
        TaskItem(taskName: "Proposal Document", isChecked: true),
        TaskItem(taskName: "Homework 7", isChecked: true),
        TaskItem(taskName: "Open App", isChecked: true),
        TaskItem(taskName: "Figma Prototype", isChecked: false),
        TaskItem(taskName: "Build App", isChecked: false)
    ]

    
    // [Beta] TODO: reset tasks everyday / overdue etc.
    // [Beta] TODO: Add ability to queue tasks so that it comes back everyday
    // [Beta] TODO: Customizable Profile Picture
    
    
    private var progress: Double {
        let completedTasks = tasks.filter { $0.isChecked }.count
        return Double(completedTasks) / Double(tasks.count)
    }
    
    private var completedTasksText: String {
        let completedTasks = tasks.filter { $0.isChecked }.count
        return "\(completedTasks) of \(tasks.count) tasks\ncompleted today!"
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d y"
        return formatter
    }()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0.95, green: 0.95, blue: 0.95)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text(Date.init(), formatter: dateFormatter)
                            .font(.subheadline)
                            .padding(.leading, 40)
                        
                        Spacer()
                    }
                    
                    // Greeting
                    HStack {
                        HStack {
                            Text("Hello, ")
                                .foregroundColor(.black) // Color for "Hello, "
                            
                            Text((name.isEmpty ? "New User" : name) + "!")
                                .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                                .padding(.leading, -8)
                                .bold()
                        }
                        .font(.title)
                        .padding(.top, -5)
                        .padding(.leading, 23)
                        
                        Spacer()
                        
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(.trailing, 30)
                            .padding(.bottom, 10)
                            .foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8))
                    }
                    .padding(.horizontal)
                    
                    // rectangle for progress bar
                    VStack {
                        
                        // circle and text
                        HStack {
                            
                            // circle progress bar
                            ZStack {
                                Circle()
                                    .stroke(
                                        Color(red:0.9, green:0.9, blue:0.9).opacity(0.5),
                                        lineWidth: 15
                                    )
                                Circle()
                                    .trim(from: 0, to: progress)
                                    .stroke(
                                        Color(red:0.9, green:0.9, blue:0.9),
                                        style: StrokeStyle(
                                            lineWidth: 15,
                                            lineCap: .round
                                        )
                                    )
                                    .rotationEffect(.degrees(-90))
                                    .animation(.easeOut, value: progress)
                                Text("\(progress * 100, specifier: "%.0f")%")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            .frame(width: 100, height: 100)
                            
                            Spacer()
                            
                            Text(completedTasksText)
                                .multilineTextAlignment(.leading)
                                .font(.headline)
                                .foregroundColor(Color(red:0.9, green:0.9, blue:0.9))
                        }
                        .padding(.vertical, 40)
                        .padding(.horizontal, 20)
                        
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 0.8, green: 0, blue: 0))
                    )
                    .padding(.horizontal, 40)
                    
                    Spacer()
                    // Task List
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("Your Tasks")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            // TODO: change to an add new task button
                            NavigationLink(destination: CreateTaskView(tasks: $tasks)) {
                                Text("Add New Task")
                                    .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                                    .font(.subheadline)
                                    .bold()
                            }
                            
                        }
                        .padding(.horizontal)
                        .padding(.vertical)
                        
                        List {
                            ForEach($tasks) { $task in
                                TaskListView(task: $task)
                                    .listRowInsets(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
                                    .listRowBackground(Color.clear)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white)
                            .shadow(radius: 2)
                    )
                    .padding(.top)
                    .padding(.bottom, 30)
                    .padding(.horizontal, 30)
                    
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .navigationBarBackButtonHidden(true)

        
        
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(name: .constant("David Qu"))
    }
}
