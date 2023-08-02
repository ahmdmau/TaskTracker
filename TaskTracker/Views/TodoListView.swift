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
                        HStack {
                            Toggle("Mark as complete", isOn: Binding<Bool>(get: { todo.isCompleted }, set: { newValue in
                                viewModel.setCompleted(todo, isCompleted: newValue)
                            }))
                            .toggleStyle(CheckboxToggleStyle())
                            Text(todo.title ?? "-")
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
