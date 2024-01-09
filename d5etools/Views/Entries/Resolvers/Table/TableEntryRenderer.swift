//
//  TableEntryView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation
import SwiftUI

struct TableEntryRenderer: ResolvableEntryRenderer {
    static var types: [String] = ["table"]
    var entry: EntryModel
    
    init(entry: EntryModel) {
        self.entry = entry
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let caption = entry.data.caption {
                HeadlineTextView(text: caption, color: entry.hierarcy.color)
            }
            
            ScrollView(scrollDirection) {
                Grid(alignment: .leading) {
                    GridRow {
                        TableEntryHeaderRenderer(entry: entry)
                    }
                    
                    TableEntryBodyRenderer(entry: entry)
                }
            }
            
            if let footnotes = entry.data.footnotes {
                ForEach(Array(zip(footnotes.indices, footnotes)), id: \.0) {
                    idx, footnote in
                    EntryOrTextView(entry: footnote)
                }
            }
        }
    }
    
    var scrollDirection: Axis.Set {
        return if entry.colLabels?.count ?? 0 <= 3 {
            .vertical
        } else {
            .horizontal
        }
    }
}

#Preview("Optional Caption") {
    return ScrollView {
        AnyView(PreviewResolvableView(
            TableEntryRenderer.self,
            matching: .init(
                source: "sample",
                chapter: 0,
                type: "table",
                offset: 0
            )
        ))
    }
}


#Preview("Multiple Header Rows?") {
    return ScrollView {
        AnyView(PreviewResolvableView(
            TableEntryRenderer.self,
            matching: .init(
                source: "sample",
                chapter: 0,
                type: "table",
                offset: 1
            )
        ))
    }
}


#Preview("Rollable Table") {
    return ScrollView {
        AnyView(PreviewResolvableView(
            TableEntryRenderer.self,
            matching: .init(
                source: "sample",
                chapter: 0,
                type: "table",
                offset: 2
            )
        ))
    }
}

#Preview("PHB: Armor") {
    return ScrollView {
        AnyView(PreviewResolvableView(
            TableEntryRenderer.self,
            matching: .init(
                source: "phb",
                chapter: 5,
                type: "table",
                offset: 2
            )
        ))
    }
}

