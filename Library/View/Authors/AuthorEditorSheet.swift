//
//  AuthorEditorSheet.swift
//  Library
//
//  Created by Ruslan Alekyan on 14.02.2024.
//

import SwiftUI

struct AuthorEditorSheet: View {
    let author: Author?
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var originalName = ""
    
    init(author: Author? = nil) {
        self.author = author                                                         // Добавлено только из-за инициализатора
        UITextField.appearance().clearButtonMode = .whileEditing                        // Вынести в расширение View
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Original name", text: $originalName)
            }
            .textInputAutocapitalization(.words)
            .navigationTitle(author == nil ? "New author" : "Edit author")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(author == nil ? "Add" : "Done", action: addAuthor)
                        .disabled(name.isEmpty)
                }
            }
            .onAppear {
                if let author {
                    name = author.name
                    originalName = author.originalName
                }
            }
        }
    }
    
    private func addAuthor() {
        let name = self.name.trimmingCharacters(in: .whitespaces)
        let originalName = self.originalName.trimmingCharacters(in: .whitespaces)
        
        if let author {
            author.name = name
            author.originalName = originalName
        } else {
            let author = Author(name: name, originalName: originalName)
            modelContext.insert(author)
        }
        dismiss()
    }
}

#Preview {
    AuthorEditorSheet()
}
