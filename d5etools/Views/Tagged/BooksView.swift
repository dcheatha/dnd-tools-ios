//
//  BooksView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct BookLibraryView: View, TaggedViewProtocol {
    static var tagInfo = TagInfo(prefixes: ["books", "adventures"], minArgs: 0)
    var tag: String
    
    @State var books: [BookModel] = []
    @EnvironmentObject var navigation: TaggedNavigationViewModel
    
    init(tag: String) {
        self.tag = tag
        self.books = []
    }
    
    var type: String {
        TagPreprocessor.shared.findFirstTag(text: tag) ?? "book"
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if books.count > 0 {
                HStack {
                    HeadlineTextView(text: "\(type.capitalized)s")
                    Spacer()
                    Text("\(books.count) known \(type.lowercased())s")
                        .font(.scalySans(size: 15))
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(books) {
                            book in
                            BookListItemView(book: book)
                                .onTapGesture {
                                    navigation.navigateTo(tag: "{@\(type)|\(book.data.id)}")
                                }
                        }
                    }.padding()
                }
            } else {
                Text("Loading...")
                    .onAppear(perform: loadData)
                    .navigationTitle(tag)
            }
        }
    }
    
    func loadData() {
        Store.shared.book.loadLibrary(of: .from(type)) {
            result in
            
            if case let .failure(error) = result {
                print(error)
                return
            }
            
            self.books = try! result.get()
        }
    }
}

//#Preview {
//    guard let books = SampleData().books() else { return EmptyView() }
//    
//    print(books.book)
//    
//    return BooksView(books: books)
//}
