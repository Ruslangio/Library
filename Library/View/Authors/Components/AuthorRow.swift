//
//  AuthorRow.swift
//  Library
//
//  Created by Ruslan Alekyan on 17.02.2024.
//

import SwiftUI

struct AuthorRow: View {
    let author: Author
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(author.name)
                .font(.headline)
            Text(author.originalName)
                .font(.subheadline)
            Spacer()
        }
        .frame(height: 40)
    }
}

#Preview {
    let container = Preview.previewContainer
    return List {
        AuthorRow(author: Author(name: "Хорхе Луис Борхес", originalName: "Jorge Luis Borges"))
    }
    .modelContainer(container)
}
