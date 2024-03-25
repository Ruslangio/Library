//
//  BookEditorSheet.swift
//  Library
//
//  Created by Ruslan Alekyan on 14.02.2024.
//

import SwiftData
import SwiftUI

struct BookEditorSheet: View {
    let book: Book?
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Query(sort: \Author.name) private var authors: [Author]
    
    @State private var title = ""
    @State private var originalTitle = ""
    @State private var author: Author?
    @State private var year = ""
    @State private var country = ""
    @State private var form = Book.Form.novel
    
    init(book: Book? = nil) {
        self.book = book                                                            // Добавлено только из-за инициализатора
        UITextField.appearance().clearButtonMode = .whileEditing                        // Вынести в расширение View
    }
    
    var body: some View {
        NavigationStack {
            Form {                                                                           // Поработать над формой!
                TextField("Title", text: $title)
                TextField("Original title", text: $originalTitle)
                Picker("Author", selection: $author) {                                      // Длинные имена не вмещаются
                    Text("Select an author").tag(nil as Author?)                            //  Почему нужно as?
                    ForEach(authors) { author in
                        Text(author.name)
                            .tag(author as Author?)                                         // И здесь
                    }
                }
                TextField("Year", text: $year)                                               // Сделать проверку на цифры?
                    .keyboardType(.numberPad)
                TextField("Country", text: $country)
                
                Section("Form") {                                                               // Пока так
                    Picker("Form", selection: $form) {
                        ForEach([Book.Form.shortStory, .novella, .novel]) { form in
                            Text(form.rawValue)
                        }
                    }
                    Picker("Form", selection: $form) {
                        ForEach([Book.Form.poem, .shortStoryCollection]) { form in
                            Text(form.rawValue)
                        }
                    }
                }
                .pickerStyle(.segmented)
            }
            .navigationTitle(book == nil ? "New book" : "Edit book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(book == nil ? "Add" : "Done", action: addBook)
                        .disabled(title.isEmpty || year.isEmpty || country.isEmpty)
                }
            }
            .onAppear {
                if let book {
                    title = book.title
                    originalTitle = book.originalTitle
                    if let author = book.author {                   // Вроде работает (пересмотреть)
                        self.author = author
                    }
                    year = book.year
                    country = book.country
                    form = book.form
                }
            }
        }
    }
    
    private func addBook() {                                                        // Где должно находиться?
        let title = self.title.trimmingCharacters(in: .whitespaces)
        let originalTitle = self.originalTitle.trimmingCharacters(in: .whitespaces)
        let country = self.country.trimmingCharacters(in: .whitespaces)
        
        if let book {
            book.title = title
            book.originalTitle = originalTitle
            book.author = author
            book.year = year
            book.country = country
            book.form = form
        } else {
            let book = Book(title: title, originalTitle: originalTitle, author: author, year: year, country: country, form: form)
            modelContext.insert(book)
        }
        dismiss()
    }
}

#Preview {
    BookEditorSheet()
}
