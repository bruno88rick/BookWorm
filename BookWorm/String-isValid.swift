//
//  String-isValid.swift
//  BookWorm
//
//  Created by Bruno Oliveira on 31/05/24.
//

import Foundation

//validate string by white spaces and new lines and if it is Empty
extension String {
    var isNotValidString: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

