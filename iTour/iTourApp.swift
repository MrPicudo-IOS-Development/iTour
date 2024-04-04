//
//  iTourApp.swift
//  iTour
//
//  Created by Jose Miguel Torres Chavez Nava on 04/04/24.
//

import SwiftData
import SwiftUI

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
