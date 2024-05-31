//
//  ContentView.swift
//  BookWorm
//
//  Created by Bruno Oliveira on 28/05/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    //@Query var books: [Book]
    //using sort to sorting data. We thave some ways to sort, even using SorDescriptor to sort by one or more fields
    //@Query(sort: \Book.title) var books: [Book]
    //@Query(sort: \Book.rating, order: .reverse) var books: [Book]
    //@Query(sort: [SortDescriptor(\Book.title)]) var books: [Book]
    //@Query(sort: [SortDescriptor(\Book.title, order: .reverse)]) var books: [Book]
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author),
        SortDescriptor(\Book.rating, order: .reverse)
    ]) var books: [Book]
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundColor(book.rating == 1 ? .red : .primary)
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Book", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen, content: {
                AddBookView()
            })
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            //find this book in our query
            let book = books[offset]
            
            //delete it from the context
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}
