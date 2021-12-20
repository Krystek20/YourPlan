//
//  YourPlanApp.swift
//  YourPlan
//
//  Created by Krystian Solarz on 20/12/2021.
//

import SwiftUI

@main
struct YourPlanApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
