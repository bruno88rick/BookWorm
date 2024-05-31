//
//  String-isValid.swift
//  BookWorm
//
//  Created by Bruno Oliveira on 31/05/24.
//

import Foundation

//validate string by white spaces and new lines and if it is Empty or have less than 2 characters
extension String {
    var isNotAValidString: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || self.count <= 1
    }
    
    var trimmingWhiteSpaces: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

