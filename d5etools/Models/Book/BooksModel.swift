//
//  BooksModel.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

class BooksModel: Decodable {
    let book: [BookModel]?
    let adventure: [BookModel]?
    
    var all: [BookModel] {
        (book ?? []) + (adventure ?? [])
    }
}
