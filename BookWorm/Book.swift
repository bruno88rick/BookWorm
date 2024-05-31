//
//  Book.swift
//  BookWorm
//
//  Created by Bruno Oliveira on 29/05/24.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var registrationDate = Date.now
    var readingDate: Date
    
    init(title: String, author: String, genre: String, review: String, rating: Int, readingDate: Date) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.readingDate = readingDate
    }
}
