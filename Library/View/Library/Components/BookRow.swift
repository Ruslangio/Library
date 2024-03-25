//
//  BookRow.swift
//  Library
//
//  Created by Ruslan Alekyan on 14.02.2024.
//

import SwiftUI

struct BookRow: View {
    let book: Book
    
    private var colors: [Color] {                                                // Временно
        var colors = [Color]()
        for i in 1...10 {
            for j in 1...10 {
                for k in 1...10 {
                    let di = Double(i) / 10 - 0.2
                    let dj = Double(j) / 10 - 0.1
                    let dk = Double(k) / 10
                    colors.append(Color(red: di, green: dj, blue: dk))
                }
            }
        }
        return colors
    }
    
    var body: some View {
        HStack {
            Rectangle()                                                         // Место для изображения
                .aspectRatio(2/3, contentMode: .fit)
                .foregroundStyle(colors.randomElement()!.opacity(0.7))
            
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                if let author = book.author {
                    Text(author.name)
                        .font(.subheadline)
                }
                Spacer()
                HStack {
                    Text(book.year)
                    Spacer()
                    Text(book.country)
                }
                .font(.footnote)
            }
        }
        .frame(height: 90)
    }
}

//#Preview {
//    BookRow()
//}
