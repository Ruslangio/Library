//
//  ContentView.swift
//  Library
//
//  Created by Ruslan Alekyan on 14.02.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            LibraryView()
                .tabItem {
                    Label("Library", systemImage: "books.vertical")
                }
            AuthorsListView()
                .tabItem {
                    Label("Authors", systemImage: "person.3")                           // Выбрать иконку
                }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(Library())
        .modelContainer(Preview.previewContainer)
}
