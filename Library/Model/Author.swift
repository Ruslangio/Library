//
//  Author.swift
//  Library
//
//  Created by Ruslan Alekyan on 14.02.2024.
//

import SwiftData

@Model
class Author {
    var name: String                                                            // Перемеиновать свойство?                      // Нужен ли уникальный атрибут?
    var originalName: String
    @Relationship(inverse: \Book.author) var books = [Book]()
    
    init(name: String, originalName: String = "") {
        self.name = name
        self.originalName = originalName
    }
}
