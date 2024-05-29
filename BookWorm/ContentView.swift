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
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Bookworm")
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .toolbar {
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
}

#Preview {
    ContentView()
}
