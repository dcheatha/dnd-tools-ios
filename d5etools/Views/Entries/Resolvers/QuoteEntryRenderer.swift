//
//  QuoteEntryView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct QuoteEntryRenderer: ResolvableEntryRenderer {
    static var types: [String] = ["quote", "insetReadaloud"]
    var entry: EntryModel
    
    init(entry: EntryModel) {
        self.entry = entry
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            if entry.type == "insetReadaloud" {
                Text("Read outloud")
                    .font(.zatannaMisdirection(size: 15))
            }
                
            if let by = entry.data.by {
                Text("— " + by.tagged())
                    .font(.zatannaMisdirection(size: 15))
            }
        }
    }
}

#Preview("Read outloud") {
    return PreviewResolvableView(
        QuoteEntryRenderer.self,
        matching: .init(
            source: "sample",
            chapter: 0,
            type: "insetReadaloud",
            offset: nil
        )
    )
}

#Preview("By") {
    return PreviewResolvableView(
        QuoteEntryRenderer.self,
        matching: .init(
            source: "sample",
            chapter: 0,
            type: "quote",
            offset: nil
        )
    )
}
