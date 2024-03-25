//
//  BookList.swift
//  Library
//
//  Created by Ruslan Alekyan on 14.02.2024.
//

import SwiftData
import SwiftUI

struct BookList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var books: [Book]
    
    init(predicate: Predicate<Book>, sortDescriptor: [SortDescriptor<Book>]) {                  // Почему необходимы эти входные данные именно здесь?
        _books = Query(filter: predicate, sort: sortDescriptor)
    }
    
    var body: some View {
        List {
            ForEach(books) { book in
                NavigationLink(value: book) {
                    BookRow(book: book)
                }
            }
            .onDelete(perform: deleteBook)
        }
    }
    
    private func deleteBook(at indexSet: IndexSet) {                                         // Где должно находиться?
        for index in indexSet {
            modelContext.delete(books[index])
        }
    }
}

#Preview {
    NavigationStack {
        BookList(predicate: #Predicate<Book> { !$0.title.isEmpty }, sortDescriptor: [SortDescriptor(\Book.date)])
    }
    .modelContainer(Preview.previewContainer)
}
