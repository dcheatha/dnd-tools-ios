//
//  BookIndexView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct BookTableOfContentsView: View, ResolvableTagViewProtocol {
    static var tagInfo = TagInfo(prefixes: ["book", "adventure"], minArgs: 1)
    
    var tag: String
    @EnvironmentObject var navigation: TaggedNavigationViewModel
    
    init(tag: String) {
        self.tag = tag
    }
    
    @State var bookCover: BookModel?
    
    var body: some View {
        if let bookCover, let bookType, let bookId {
            BookView(type: bookType, id: bookId, book: bookCover)
        } else {
            DetailTextView(text: "Loading BookIndexView \(tag) with args \(args.joined(separator: ","))")
                .onAppear(perform: loadData)
                .navigationTitle(tag)
        }
    }
    
    var args: [String] {
        TagPreprocessor.shared.parseFirstTag(text: tag)?.args() ?? []
    }
    
    var bookId: String? {
        args.first
    }
    
    var bookType: String? {
        TagPreprocessor.shared.findFirstTag(text: tag)
    }
    
    func loadData() {
        guard let bookType else { return }
        guard let bookId else { return }
        
        Store.shared.book.loadCover(for: bookId, type: .from(bookType)) {
            result in
            
            if case let .failure(error) = result {
                print(error)
                return
            }
            
            self.bookCover = try! result.get()
        }
    }
}
