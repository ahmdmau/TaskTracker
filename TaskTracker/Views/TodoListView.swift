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
                        Text(todo.title ?? "-")
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
