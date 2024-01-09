//
//  BookChapterView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct BookChapterView: View, ResolvableTagViewProtocol {
    static var tagInfo = TagInfo(prefixes: ["book", "adventure"], minArgs: 2)
    var tag: String
    @State var chapterData: [EntryOrTextModel]?
    
    init(tag: String) {
        self.tag = tag
    }
    
    var body: some View {
        if let entries = chapterData {
            EntryBrowserView(entries: entries)
        } else {
            DetailTextView(text: "Fetching \(tag) with args \(args.joined(separator: ","))")
                .onAppear(perform: loadData)
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
    
    var chapterIdx: Int? {
        Int(args[safe: 1] ?? "")
    }
    
    func loadData() {
        guard let bookType else { return }
        guard let bookId else { return }
        guard let chapterIdx else { return }
        
        Store.shared.book.loadChapter(from: bookId, index: chapterIdx, type: .from(bookType)) {
            result in
            
            if case let .failure(error) = result {
                print(error)
                return
            }
            
            chapterData = try! result.get()
        }
    }
}
