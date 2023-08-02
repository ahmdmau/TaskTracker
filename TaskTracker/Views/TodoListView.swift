//
//  TodoListView.swift
//  TaskTracker
//
//  Created by Ahmad Maulana on 02/08/23.
//

import SwiftUI

struct TodoListView: View {
    @StateObject private var viewModel = TodoViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.todos, id: \.self) { todo in
                        HStack(alignment: .center, spacing: 8) {
                            Toggle("Mark as complete", isOn: Binding<Bool>(get: { todo.isCompleted }, set: { newValue in
                                viewModel.setCompleted(todo, isCompleted: newValue)
                            }))
                            .toggleStyle(CheckboxToggleStyle())
                            
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(todo.title ?? "Unknown")
                                    .fontWeight(.semibold)
                                Text(todo.todoDescription ?? "Unknown")
                                    .fontWeight(.regular)
                                    .font(.system(size: 14))
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                Text("Due \(DateHelper.shared.formatDateToString(date: todo.dueDate ?? Date()))")
                                    .font(.footnote)
                            }
                            
                            Spacer()
                            Text(DueDateUtility.label(for: DueDateUtility.status(for: todo)))
                                .font(.footnote)
                                .foregroundColor(DueDateUtility.color(for: DueDateUtility.status(for: todo)))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .frame(minWidth: 62)
                                .overlay(
                                    Capsule().stroke(DueDateUtility.color(for: DueDateUtility.status(for: todo)), lineWidth: 0.75)
                                )
                        }
                    }
                }
            }
            .navigationTitle("Task Tracker")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchTodos()
            }
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
