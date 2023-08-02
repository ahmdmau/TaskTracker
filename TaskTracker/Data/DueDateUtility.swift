//
//  DueDateUtility.swift
//  TaskTracker
//
//  Created by Ahmad Maulana on 02/08/23.
//

import SwiftUI

struct DueDateUtility {
    static func status(for todo: Todo) -> DueDateStatus {
        let currentDate = Date()
        guard let dueDate = todo.dueDate else {
            return .notDueYet
        }
        
        if todo.isCompleted {
            return .completed
        } else if Calendar.current.isDateInToday(dueDate) {
            return .dueToday
        } else if dueDate < currentDate {
            return .overdue
        } else {
            return .notDueYet
        }
    }
    
    static func label(for status: DueDateStatus) -> String {
        switch status {
        case .completed:
            return "Completed"
        case .overdue:
            return "Overdue"
        case .dueToday:
            return "Due Today"
        case .notDueYet:
            return "Not Due Yet"
        }
    }
    
    static func color(for status: DueDateStatus) -> Color {
        switch status {
        case .overdue:
            return .red
        case .dueToday:
            return .orange
        case .notDueYet:
            return .gray
        case .completed:
            return .green
        }
    }
}

enum DueDateStatus {
    case overdue
    case dueToday
    case notDueYet
    case completed
}
