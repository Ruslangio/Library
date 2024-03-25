//
//  Book.swift
//  Library
//
//  Created by Ruslan Alekyan on 14.02.2024.
//

import Foundation
import SwiftData

@Model
class Book {
    let date = Date()
    
    var title: String
    var originalTitle: String
    var author: Author?
    var year: String                                                                                                        // А String ли?
    var country: String
    var form: Form
    
    init(title: String, originalTitle: String = "", author: Author?, year: String, country: String, form: Form) {
        self.title = title
        self.originalTitle = originalTitle
        self.author = author
        self.year = year
        self.country = country
        self.form = form
    }
    
    enum Form: String, CaseIterable, Codable, Identifiable {
        case shortStory = "Short story"
        case novella = "Novella"
        case novel = "Novel"
        case shortStoryCollection = "Short story collection"
        case poem = "Poem"
        
        var id: Self { self }
    }
}
