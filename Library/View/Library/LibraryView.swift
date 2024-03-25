//
//  LibraryView.swift
//  Library
//
//  Created by Ruslan Alekyan on 14.02.2024.
//

import SwiftUI

struct LibraryView: View {
    @EnvironmentObject private var library: Library
    
    @State private var showBookEditor = false
    @State private var showFilterSheet = false
    
    var body: some View {
        NavigationStack {
            BookList(predicate: library.predicate, sortDescriptor: library.sortDescriptor)
                .navigationDestination(for: Book.self) { book in
                    BookView(book: book)
                }
                .navigationTitle("Library")
                .searchable(text: $library.searchText)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarLeading) {
                        sortButton
                        filterButton
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        addBookButton
                    }
                }
        }
        .sheet(isPresented: $showBookEditor) {
            BookEditorSheet()
        }
        .sheet(isPresented: $showFilterSheet) {
            FilterSheet()
        }
    }
    
    // MARK: - Toolbar buttons
    
    private var sortButton: some View {
        Menu("Sort", systemImage: "arrow.up.arrow.down") {
            Picker("Sort by", selection: $library.sortOption) {
                ForEach(Library.SortOption.allCases) { option in
                    Text(option.name)
                    
                }
            }
            Picker("Sort order", selection: $library.sortOrder) {
                ForEach([SortOrder.forward, .reverse], id: \.self) { order in
                    Text(order.name)
                }
            }
        }
    }
    
    private var filterButton: some View {
        Button {
            showFilterSheet.toggle()
        } label: {
            Image(systemName: "slider.horizontal.3")                // Поменять иконку?
        }
    }
    
    private var addBookButton: some View {
        Button {
            showBookEditor.toggle()
        } label: {
            Image(systemName: "plus")
        }
    }
}

#Preview {
    LibraryView()
        .environmentObject(Library())
        .modelContainer(Preview.previewContainer)
}
