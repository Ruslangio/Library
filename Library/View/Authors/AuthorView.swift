//
//  AuthorView.swift
//  Library
//
//  Created by Ruslan Alekyan on 15.02.2024.
//

import SwiftUI

struct AuthorView: View {
    let author: Author
    
    @State private var showAuthorEditor = false

    
    var body: some View {
        List {                                                                          // Пока примерно сделано
            Section {
                ForEach(author.books.sorted(by: { $0.year < $1.year} )) { book in
                    HStack {
                        Rectangle()
                            .aspectRatio(2/3, contentMode: .fit)
                            .foregroundStyle(.secondary.opacity(0.7))
                        
                        VStack(alignment: .leading) {
                            Text(book.title)
                                .font(.headline)
                            if !book.originalTitle.isEmpty {
                                Text(book.originalTitle)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Text(book.year)
                                .font(.footnote)
                        }
                    }
                    .frame(height: 80)
                }
            } header: {
                Text("Bibliography")
                    .font(.headline)
            }
        }
        .navigationTitle(author.name)
        .sheet(isPresented: $showAuthorEditor) {
            AuthorEditorSheet(author: author)
        }
        .toolbar {
            Button("Edit") {
                showAuthorEditor.toggle()
            }
        }
    }
}

#Preview {                          // Не настроено
    let container = Preview.previewContainer
    return NavigationStack {
        AuthorView(author: Author(name: "Джованни Боккаччо", originalName: "Giovanni Boccaccio"))
    }
    .modelContainer(container)
}
