//
//  TodoViewModel.swift
//  TaskTracker
//
//  Created by Ahmad Maulana on 02/08/23.
//

import SwiftUI
import CoreData

class TodoViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    
    private let context = PersistenceController.shared.container.viewContext
    
    func fetchTodos() {
        let fetchRequest: NSFetchRequest<Todo> = Todo.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \Todo.isCompleted, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            todos = try context.fetch(fetchRequest)
        } catch {
            errorMessage = "Error fetching todos: \(error)"
            showErrorAlert = true
        }
    }
    
    func addTodo(title: String, description: String, dueDate: Date, priority: String) {
        let newTodo = Todo(context: context)
        newTodo.title = title
        newTodo.todoDescription = description
        newTodo.dueDate = dueDate
        newTodo.isCompleted = false
        newTodo.createdAt = Date()
        newTodo.priority = priority
        
        saveContext()
        
        fetchTodos()
    }
    
    func updateTodo(todo: Todo, title: String, description: String, dueDate: Date, priority: String, isCompleted: Bool) {
        todo.title = title
        todo.todoDescription = description
        todo.dueDate = dueDate
        todo.isCompleted = false
        todo.createdAt = Date()
        todo.priority = priority
        todo.isCompleted = isCompleted
        
        saveContext()
        
        fetchTodos()
    }
    
    func setCompleted(_ todo : Todo, isCompleted: Bool) {
        todo.isCompleted = isCompleted
        saveContext()
        fetchTodos()
    }
    
    func deleteTodo(_ todo: Todo) {
        context.delete(todo)
        saveContext()
        
        fetchTodos()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            errorMessage = "Error saving todos: \(error)"
            showErrorAlert = true
        }
    }
}
