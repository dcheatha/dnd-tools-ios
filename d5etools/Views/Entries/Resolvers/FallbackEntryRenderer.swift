//
//  FallbackEntryView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct FallbackEntryRenderer: ResolvableEntryRenderer {
    static var types: [String] = []
    var entry: EntryModel
    
    init(entry: EntryModel) {
        self.entry = entry
    }
    
    var body: some View {
        ErrorTextView(
            text: "entryResolver: No assoicated EntryView for \(entry.data.type) \n(id: \(entry.id))"
        )
    }
}

#Preview("Fallback") {
    return PreviewResolvableView(
        FallbackEntryRenderer.self,
        matching: .init(
            source: "sample",
            chapter: 0,
            type: "table",
            offset: nil
        )
    )
}
