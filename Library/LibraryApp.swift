//
//  LibraryApp.swift
//  Library
//
//  Created by Ruslan Alekyan on 14.02.2024.
//

import SwiftUI

@main
struct LibraryApp: App {
    @StateObject private var library = Library()                          // Перенести в MainView?
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(library)
        }
        .modelContainer(for: [Author.self, Book.self])                  // Оставить только Author?
    }
}
