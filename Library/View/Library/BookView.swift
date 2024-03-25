//
//  BookView.swift
//  Library
//
//  Created by Ruslan Alekyan on 14.02.2024.
//

import SwiftUI

struct BookView: View {
    let book: Book
    
    @State private var showBookEditor = false
    
    var body: some View {
        ScrollView {                                                        // Переделать
            Text(book.title)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom, 5)
            if !book.originalTitle.isEmpty {
                Text(book.originalTitle)
                    .font(.subheadline)
            }
            if let author = book.author {
                Text(author.name)
                    .font(.headline)
            }
            Group {
                Text(book.country + ", " + book.year)
                Text(book.form.rawValue)
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        .frame(alignment: .center)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showBookEditor) {
            BookEditorSheet(book: book)
        }
        .toolbar {
            Button("Edit") {
                showBookEditor.toggle()
            }
        }
    }
}

//#Preview {
//    let container = try! ModelContainer(for: Author.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
//    let book = Book(title: "Имя розы", originalTitle: "Il nome della rosa", author: Author(name: "Умберто Эко"), year: "1980", country: "Италия", form: .novel)
//    return NavigationStack {
//        BookView(book: book)
//    }
//    .modelContainer(container)
//}
