//
//  Preview.swift
//  Library
//
//  Created by Ruslan Alekyan on 21.02.2024.
//

import SwiftData
import SwiftUI

@MainActor
struct Preview {
    static var previewContainer: ModelContainer {
        let container = try! ModelContainer(for: Author.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let jorge = Author(name: "Хорхе Луис Борхес", originalName: "Jorge Luis Borges")
        
        container.mainContext.insert(Author(name: "Данте Алигьери", originalName: "Dante Alighieri"))
        container.mainContext.insert(jorge)
        container.mainContext.insert(Author(name: "Михаил Булгаков"))
        container.mainContext.insert(Author(name: "Габриэль Гарсиа Маркес", originalName: "Gabriel García Márquez"))
        
        container.mainContext.insert(Book(title: "Имя розы", originalTitle: "Il nome della rosa", author: Author(name: "Умберто Эко", originalName: "Umberto Eco"), year: "1980", country: "Италия", form: .novel))
        container.mainContext.insert(Book(title: "Пикник на обочине", author: Author(name: "Аркадий и Борис Стругацкие"), year: "1972", country: "СССР", form: .novella))
        container.mainContext.insert(Book(title: "1984", originalTitle: "Nineteen Eighty-Four", author: Author(name: "Джордж Оруэлл", originalName: "George Orwell"), year: "1949", country: "Великобритания", form: .novel))
        container.mainContext.insert(Book(title: "Жизнь взаймы", originalTitle: "Geborgtes Leben", author: Author(name: "Эрих Мария Ремарк", originalName: "Erich Maria Remarque"), year: "1961", country: "Германия", form: .novel))
        container.mainContext.insert(Book(title: "Алеф", originalTitle: "El Aleph", author: jorge, year: "1949", country: "Аргентина", form: .shortStoryCollection))
        container.mainContext.insert(Book(title: "Вымыслы", originalTitle: "Ficciones", author: jorge, year: "1944", country: "Аргентина", form: .shortStoryCollection))

        return container
    }
}
