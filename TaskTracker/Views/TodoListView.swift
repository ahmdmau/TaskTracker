//
//  TodoListView.swift
//  TaskTracker
//
//  Created by Ahmad Maulana on 02/08/23.
//

import SwiftUI

struct TodoListView: View {
    // MARK: - Properties
    @StateObject private var viewModel = TodoViewModel()
    @State private var showingAddTodo = false
    @State private var animatingButton = false
    @State private var showingEditTodo = false
    @State private var selectedTodo: Todo?
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(viewModel.todos, id: \.self) { todo in
                            HStack(alignment: .top) {
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
                            }.onTapGesture {
                                selectedTodo = todo
                                showingEditTodo = true
                            }
                        }
                        .onDelete { indexSet in
                            let todo = viewModel.todos[indexSet.first!]
                            viewModel.deleteTodo(todo)
                        }
                    }
                    .animation(.default)
                }
                if viewModel.todos.count == 0 {
                    EmptyStateView()
                }
            }
            .navigationTitle("Task Tracker")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchTodos()
            }
            .sheet(isPresented: $showingAddTodo) {
                AddTodoView(viewModel: viewModel)
            }
            .sheet(isPresented: $showingEditTodo) {
                EditTodoView(viewModel: viewModel, todo: $selectedTodo)
            }
            
        }.alert(isPresented: $viewModel.showErrorAlert) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
        }.overlay(
            ZStack {
                Group {
                    Circle()
                        .fill(Color.blue)
                        .opacity(self.animatingButton ? 0.2 : 0)
                        .scaleEffect(self.animatingButton ? 1 : 0)
                        .frame(width: 68, height: 68, alignment: .center)
                    Circle()
                        .fill(Color.blue)
                        .opacity(self.animatingButton ? 0.15 : 0)
                        .scaleEffect(self.animatingButton ? 1 : 0)
                        .frame(width: 88, height: 88, alignment: .center)
                }
                .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animatingButton)
                
                Button(action: {
                    self.showingAddTodo.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .background(Circle().fill(Color("ColorBase")))
                        .frame(width: 48, height: 48, alignment: .center)
                } //: BUTTON
                
                .onAppear(perform: {
                    self.animatingButton.toggle()
                })
            } //: ZSTACK
                .padding(.bottom, 15)
                .padding(.trailing, 15)
            , alignment: .bottomTrailing
        )
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
