//
//  BookView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct BookView: View {
    var type: String
    var id: String
    
    @EnvironmentObject var navigation: TaggedNavigationViewModel
    
    var book: BookModel
    @State var image: Image?
    
    var body: some View {
        VStack(alignment: .leading) {
                HeadlineTextView(text: book.data.name, fontSize: 26)
                    .onAppear(perform: loadCoverImage)
            
                ScrollView {
                    image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(15)
                    
                    VStack(alignment: .leading) {
                        let contents = book.data.contents
                        ForEach(Array(zip(contents.indices, contents)), id: \.0) {
                            idx, item in
                            VStack(alignment: .leading) {
                                let color = Color.randomHue
                                
                                HStack {
                                    HeadlineTextView(text: item.name, color: color)
                                    
                                    Spacer()
                                    
                                    if let ordinal = item.ordinal {
                                        DetailTextView(text: ordinal.type.capitalized)
                                        switch ordinal.identifier {
                                        case .text(let text):
                                            DetailTextView(text: text)
                                        case .int(let num):
                                            DetailTextView(text: "\(num)")
                                        case .none:
                                            EmptyView()
                                        }
                                    }
                                }
                                
                                ContainerView(color: color) {
                                    if let items = item.headers {
                                        ForEach(Array(zip(items.indices, items)), id: \.0) { index, item in
                                            if case let .text(text) = item {
                                                TaggedTextView(text: text)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(5)
                            .cornerRadius(5)
                            .onTapGesture(perform: {
                                navigation.navigateTo(
                                    tag: "{@\(type) |\(id)|\(idx)}"
                                )
                            })
                        }
                    }
                }
            }
        }
    
    func loadCoverImage() {
        DnDNetFetch.shared.raw(book.coverUrl) {
            result in
            
            if case let .success(data) = result {
                self.image = Image.from(data: data)
            } else {
                self.image = Image(systemName: "exclamationmark.triangle")
            }
        }
    }
}

//#Preview {
//    let book = SampleData().sampleBook()
//    return BookView(type: "book", id: "scag", book: book!)
//}
