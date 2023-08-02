//
//  TaskTrackerApp.swift
//  TaskTracker
//
//  Created by Ahmad Maulana on 02/08/23.
//

import SwiftUI

@main
struct TaskTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
