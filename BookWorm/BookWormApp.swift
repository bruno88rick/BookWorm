//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Bruno Oliveira on 28/05/24.
//

import SwiftData
import SwiftUI

@main
struct BookWormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
