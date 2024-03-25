//
//  AuthorsListView.swift
//  Library
//
//  Created by Ruslan Alekyan on 14.02.2024.
//

import SwiftData
import SwiftUI

struct AuthorsListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Author.name) private var authors: [Author]
    
    @State private var showAuthorEditor = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(authors) { author in
                    NavigationLink(value: author) {
                        AuthorRow(author: author)
                    }
                }
                .onDelete(perform: deleteAuthor)
            }
            .navigationDestination(for: Author.self) { author in
                AuthorView(author: author)
            }
            .navigationTitle("Authors")
            .toolbar {
                Button {
                    showAuthorEditor.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showAuthorEditor) {
            AuthorEditorSheet()
        }
    }
    
    private func deleteAuthor(at indexSet: IndexSet) {                    // Где должно находиться?
        for index in indexSet {
            modelContext.delete(authors[index])
        }
    }
}

#Preview {
    AuthorsListView()
        .modelContainer(Preview.previewContainer)
}
