//
//  MemoriesApp.swift
//  Memories
//
//  Created by Spike on 1/5/2023.
//

import SwiftUI

@main
struct MemoriesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
