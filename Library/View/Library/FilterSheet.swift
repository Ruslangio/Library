//
//  FilterSheet.swift
//  Library
//
//  Created by Ruslan Alekyan on 14.02.2024.
//

import SwiftData
import SwiftUI

struct FilterSheet: View {
    @EnvironmentObject private var library: Library
    
    @Environment(\.dismiss) private var dismiss
    
    @Query(sort: \Author.name) private var authors: [Author]
    
    @State private var author: Author?
    @State private var yearFrom = ""
    @State private var yearTo = ""
    @State private var country = ""
    
    let countries = [                                                                                                     // Максимально временно
        "Австралия", "Аргентина", "Бразилия", "Великобритания", "Германия", "Италия", "Канада", "Колумбия", "Мексика", "Нигерия",
        "Перу", "Польша", "Португалия", "Россия", "СССР", "США", "Флорентийская республика", "Франция", "Чехословакия"]
    
    var body: some View {
        NavigationStack {
            List {
                Section("Year") {                                                               // Переделать
                    TextField("From", text: $yearFrom)
                    TextField("To", text: $yearTo)
                }
                
                Section {
                    Picker("Author", selection: $author) {                  // Не работает
                        Text("None").tag(nil as Author?)
                        ForEach(authors) { author in
                            Text(author.name)
                                .tag(author as Author?)
                        }
                    }
                    Picker("Country", selection: $country) {
                        Section {
                            Text("None").tag("")
                        }
                        ForEach(countries, id: \.self) { country in
                            Text(country)
                        }
                    }
                }
            }
            .navigationTitle("Filter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {                                                                      // Кнопки неправильно работают
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reset", action: reset)
                }
                ToolbarItem(placement: .bottomBar) {
                    Button("Apply", action: apply)
                }
            }
            .onAppear {
                country = library.country
            }
        }
    }
    
    private func apply() {
        library.author = author
        library.yearFrom = yearFrom
        library.yearTo = yearTo
        library.country = country
        dismiss()
    }
    
    private func reset() {
        yearTo = ""
        yearFrom = ""
        country = ""
    }
}

#Preview {
    FilterSheet()
        .environmentObject(Library())                   // Чтобы кнопки не ломали preview
}
