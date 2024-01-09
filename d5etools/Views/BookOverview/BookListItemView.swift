//
//  BookListItemView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct BookListItemView: View {
    var book: BookModel
    @State var image: Image?
    
    var body: some View {
        HStack(alignment: .center) {
            image?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 50, maxHeight: 50)
            
            VStack(alignment: .leading) {
                Text(book.data.name)
                    .font(.scalySans(size: 18))
                
                HStack {
                    if let author = book.data.author {
                        Text(author)
                            .font(.scalySans(size: 16))
                    }
                    
                    Text(book.data.published)
                        .font(.scalySans(size: 16))
                }
            }.HPadding()
            Spacer()
        }
            .onAppear(perform: loadData)
            .background(.regularMaterial)
            .cornerRadius(5)
    }
    
    
    func loadData() {
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
