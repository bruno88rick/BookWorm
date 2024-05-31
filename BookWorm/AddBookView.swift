//
//  AddBookView.swift
//  BookWorm
//
//  Created by Bruno Oliveira on 29/05/24.
//

///import SwiftData
import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var showingAlert = false
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var notValidBook: Bool {
        if title.isNotAValidString || author.isNotAValidString || genre.isNotAValidString {
            showingAlert.toggle()
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of the book", text: $title)
                    TextField("Author`s name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach (genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section ("Write a Review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        if notValidBook == false {
                            let newBook = Book(title: title.trimmingWhiteSpaces, author: author.trimmingWhiteSpaces, genre: genre, review: review, rating: rating)
                            modelContext.insert(newBook)
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle("Add Book")
            .alert("Missing Information!", isPresented: $showingAlert) {
                Button("Ok") {
                    showingAlert.toggle()
                }
            } message: {
                Text("Some information Required is Empty or are not valid! Please, fill it correctly to save book.")
            }
        }
    }
}

#Preview {
    AddBookView()
}
