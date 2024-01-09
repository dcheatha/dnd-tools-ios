//
//  EntryImageView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct ImageEntryRenderer: ResolvableEntryRenderer {
    static var types: [String] = [ "image" ]
    var entry: EntryModel
    @State var image: Image?
    
    init(entry: EntryModel) {
        self.entry = entry
    }
    
    var body: some View {
        VStack(alignment: .center) {
            if let image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(5)
            } else {
                ProgressView().padding()
            }
            
            if let title = entry.data.title {
                Text(title.tagged())
                    .font(.scalySans(size: 16))
                    .multilineTextAlignment(.center)
            }
        }.onAppear(perform: loadImage)
    }
    
    func loadImage() {
        if let path = entry.data.href?.imagePath {
            DnDNetFetch.shared.raw(path) {
                result in
                
                if case let .success(data) = result {
                    self.image = Image.from(data: data)
                } else {
                    self.image = Image(systemName: "exclamationmark.triangle")
                }
            }
        }
    }
}


#Preview("Image") {
    return PreviewResolvableView(
        ImageEntryRenderer.self,
        matching: .init(
            source: "sample",
            chapter: 0,
            type: "image",
            offset: nil
        )
    )
}
