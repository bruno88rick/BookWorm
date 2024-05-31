//
//  DetailView.swift
//  BookWorm
//
//  Created by Bruno Oliveira on 29/05/24.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre)
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author)
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            
            Text("Registration Date: \(book.registrationDate, format: .dateTime.day().month().year().hour().minute()) h")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Text(book.review)
                .padding()
            
            Text("Read in: \(book.readingDate, format: .dateTime.month().year())")
                .font(.title3)
                .foregroundStyle(.primary)
                .padding()
            
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
            
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete Book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("Delete this book", systemImage:"trash") {
                showingDeleteAlert = true
            }
        }
    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Livro de Teste", author: "Autor de Teste", genre: "Horror", review: "Este livro  é muito bom e eu gostei bastande dele.", rating: 3, readingDate: Date.now)
        
        return DetailView(book: example)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
