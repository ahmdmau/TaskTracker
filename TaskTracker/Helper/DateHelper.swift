//
//  DateHelper.swift
//  TaskTracker
//
//  Created by Ahmad Maulana on 02/08/23.
//

import Foundation

class DateHelper {
    static let shared = DateHelper()
    
    private let dateFormatter: DateFormatter
    
    private init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
    }
    
    func formatDateToString(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
