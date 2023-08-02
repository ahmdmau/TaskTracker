//
//  EditTodoView.swift
//  TaskTracker
//
//  Created by Ahmad Maulana on 02/08/23.
//

import SwiftUI

struct EditTodoView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var newTodoTitle = ""
    @State private var newTodoDescription = ""
    @State private var dueDate = Date()
    @State private var priority = "Normal"
    @State private var isCompleted = false
    @ObservedObject var viewModel: TodoViewModel
    @Binding var todo: Todo?
    
    private let priorities = ["High", "Normal", "Low"]
    
    private var isFormFilled: Bool {
        return !newTodoTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !(newTodoDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty )
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    TextField("Name", text: $newTodoTitle)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(8)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $newTodoDescription)
                            .frame(height: 100)
                            .border(Color(uiColor: .tertiarySystemFill), width: 0.5)
                            .scrollContentBackground(.hidden)
                            .background(Color(UIColor.tertiarySystemFill))
                            .cornerRadius(8)
                        Text("Todo Description").foregroundColor(Color(.placeholderText)).padding(8).hidden(!newTodoDescription.isEmpty)
                    }
                    DatePicker("Due Date",
                               selection: $dueDate,
                               displayedComponents: .date)
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                    HStack {
                        Text("Mark as complete")
                        Spacer()
                        Toggle("Mark as complete", isOn: $isCompleted)
                            .toggleStyle(CheckboxToggleStyle())
                    }
                    
                    Button(action: {
                        if isFormFilled {
                            viewModel.updateTodo(todo: todo!,
                                                 title: newTodoTitle,
                                                 description: newTodoDescription,
                                                 dueDate: dueDate,
                                                 priority: priority,
                                                 isCompleted: isCompleted)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Text("Save")
                            .frame(maxWidth: .infinity)
                            .font(.headline)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 8)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(!isFormFilled)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 20)
                .onAppear {
                    if let todo = todo {
                        newTodoTitle = todo.title ?? ""
                        newTodoDescription = todo.todoDescription ?? ""
                        dueDate = todo.dueDate ?? Date()
                        priority = todo.priority ?? ""
                        isCompleted = todo.isCompleted
                    }
                }
            }
            .navigationTitle("Edit Todo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct EditTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView(viewModel: TodoViewModel())
    }
}
