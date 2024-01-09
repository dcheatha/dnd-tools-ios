//
//  BookStore.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation


typealias StoreResult<T> = Result<T, Error>
typealias StoreCompletion<T> = (StoreResult<T>) -> Void

enum StoreError: Error {
    case notFound
    case indexInvalid
}

enum BookType {
    case book
    case adventure
    
    static func from(_ text: String) -> BookType {
        return text == "book" ? .book : .adventure
    }
}

class BookStore {
    static let shared = BookStore()
    
    var adventures: [BookModel] = []
    var books: [BookModel] = []
    
    var bookContents: [String: FetchEntryData] = [:]
    
    public func loadLibrary(of type: BookType, completion: @escaping StoreCompletion<[BookModel]>) {
        if case .adventure = type, adventures.count > 0 {
            completion(.success(adventures))
            return
        } else if case .book = type, books.count > 0 {
            completion(.success(books))
            return
        }
        
        refreshLibrary(of: type, completion: completion)
    }
    
    public func loadCover(for id: String, type: BookType, completion: @escaping StoreCompletion<BookModel>) {
        if let cover = findCover(for: id, type: type) {
            completion(.success(cover))
            return
        }
        
        refreshLibrary(of: type) {
            [weak self]
            _ in
            
            if let cover = self?.findCover(for: id, type: type) {
                completion(.success(cover))
            } else {
                completion(.failure(StoreError.notFound))
            }
        }
    }
    
    public func loadContents(of id: String, type: BookType, completion: @escaping StoreCompletion<FetchEntryData>) {
        if let book = bookContents[id] {
            completion(.success(book))
            return
        }
        
        refreshContents(of: id, type: type, completion: completion)
    }
    
    public func loadChapter(from id: String, index: Int, type: BookType, completion: @escaping StoreCompletion<[EntryOrTextModel]>) {
        loadContents(of: id, type: type) {
            result in
            
            if case let .failure(error) = result {
                completion(.failure(error))
                return
            }
            
            let book = try! result.get()
            
            if let chapter = book.data[safe: index] {
                let storeId = "\(id)-\(index)"
                
                let parsedChapter = Store.shared.entry.loadEntries(
                    for: storeId, model: chapter
                )
                
                completion(.success(parsedChapter))
            } else {
                completion(.failure(StoreError.indexInvalid))
            }
        }
    }

    private func findCover(for id: String, type: BookType) -> BookModel? {
        let data = type == .adventure ? adventures : books
        
        return data
            .filter { $0.data.id == id}
            .first
    }
    
    private func refreshLibrary(of type: BookType, completion: @escaping StoreCompletion<[BookModel]>) {
        let filename = if case .adventure = type {
            "adventure"
        } else {
            "book"
        }
        
        DnDNetFetch.shared.as("data/\(filename)s.json") {
            [weak self]
            (result: NetFetchResult<BooksModel>) in
            
            if case let .failure(error) = result {
                completion(.failure(error))
                return
            }
            
            let books = try! result.get().all
            if case .adventure = type {
                self?.adventures = books
            } else if case .book = type {
                self?.books = books
            }
            
            completion(.success(books))
        }
    }
    
    private func refreshContents(of id: String, type: BookType, completion: @escaping StoreCompletion<FetchEntryData>) {
        let bookType = if case .adventure = type {
            "adventure"
        } else {
            "book"
        }
        
        DnDNetFetch.shared.as("data/\(bookType)/\(bookType)-\(id.lowercased()).json") {
            (result: NetFetchResult<FetchEntryData>) in
            
            if case let .failure(error) = result {
                completion(.failure(error))
                return
            }
            
            let bookEntryModel = try! result.get()
            
//            Store.shared.entry.loadEntries(for: id, model: bookEntryModel)
            
            self.bookContents[id] = bookEntryModel
            completion(.success(bookEntryModel))
        }
    }
}
