//
//  journalApp.swift
//  journal
//
//  Created by Mickson Bossman on 06.03.2024.
//

import SwiftUI

@main
struct journalApp: App {
    @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
