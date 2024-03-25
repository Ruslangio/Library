//
//  Library.swift
//  Library
//
//  Created by Ruslan Alekyan on 14.02.2024.
//

import SwiftUI

class Library: ObservableObject {                                                               // Рассмотреть @Observable
    @Published var sortOption = SortOption.none
    @Published var sortOrder = SortOrder.forward
    
    var sortDescriptor: [SortDescriptor<Book>] {                                                  // Можно ли улучшить?
        let sortDescriptor = switch sortOption {
        case .none: SortDescriptor(\Book.date, order: sortOrder)
        case .title: SortDescriptor(\Book.title, order: sortOrder)
        case .author: SortDescriptor(\Book.author?.name, order: sortOrder)
        case .year: SortDescriptor(\Book.year, order: sortOrder)
        case .country: SortDescriptor(\Book.country, order: sortOrder)
        }
        
        return [sortDescriptor, SortDescriptor(\Book.date, order: sortOrder)]
    }
    
    enum SortOption: String, CaseIterable, Identifiable {
        case none = "Default"                                                                           // Может перемеиновать?
        case title, author, year, country
        
        var id: Self { self }
        var name: String { rawValue.capitalized }
    }
    
    //MARK: - Filter
    
    @Published var searchText = ""
    
    @Published var author: Author?
    @Published var yearFrom = ""
    @Published var yearTo = ""
    @Published var country = ""
    
    
    var predicate: Predicate<Book> {
        #Predicate<Book> { book in                                                                                                                           // Разобраться
            (book.title.localizedStandardContains(searchText) || (book.author?.name.localizedStandardContains(searchText) ?? false) || searchText.isEmpty)
            && (book.year >= yearFrom || yearFrom.isEmpty) && (book.year <= yearTo || yearTo.isEmpty)
            && (book.country == country || country.isEmpty)
        }
    }
}

extension SortOrder {                                                           // В каком файле должно находиться?
    var name: String {
        switch self {
        case .forward: "Forward"
        case .reverse: "Reverse"
        }
    }
}
