//
//  BookModel.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

class BookModel: Model<BookDataModel> {}

struct BookDataModel: Decodable {
    let name, id, source, group: String
    let coverUrl: String
    let published: String
    let author: String?
    let contents: [BookContent]
    let alias: [String]?
}

struct BookContent: Decodable {
    let name: String
    let headers: [BookHeader]?
    let ordinal: BookOrdinal?
}

enum BookHeader: Decodable {
    case rich(RichBookHeader)
    case text(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let text = try? container.decode(String.self) {
            self = .text(text)
            return
        }
    
        if let model = try? container.decode(RichBookHeader.self) {
            self = .rich(model)
            return
        }
    
        throw DecodingError.typeMismatch(
            BookHeader.self,
            DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for HeaderElement")
        )
    }
}

struct RichBookHeader: Decodable {
    let index: Int?
    let header: String
    let depth: Int?
}

struct BookOrdinal: Decodable {
    let type: String
    let identifier: BookHeaderIdentifier?
}

enum BookHeaderIdentifier: Decodable {
    case int(Int)
    case text(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let text = try? container.decode(String.self) {
            self = .text(text)
            return
        }
    
        if let int = try? container.decode(Int.self) {
            self = .int(int)
            return
        }
    
        throw DecodingError.typeMismatch(
            BookHeaderIdentifier.self,
            DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Identifier")
        )
    }
}
