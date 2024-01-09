//
//  TableEntryHeaderRenderer.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation
import SwiftUI

struct TableEntryHeaderRenderer: ResolvableEntryRenderer {
    static var types: [String] = ["table"]
    var entry: EntryModel
    
    init(entry: EntryModel) {
        self.entry = entry
    }
    
    var body: some View {
        if let labels = entry.data.colLabels {
            ForEach(Array(zip(labels.indices, labels)), id: \.0) {
                index, item in
                HStack(spacing: 0) {
                    
                    HeadlineTextView(text: item, color: entry.hierarcy.color, fontSize: 18)
                    
                    if index < labels.count - 1 {
                        Spacer()
                        Divider()
                            .gridCellUnsizedAxes(.vertical)
                            .frame(width: 1)
                            .overlay(entry.hierarcy.color.opacity(0.5))
                    }
                }
            }
        }
    }
}

#Preview("Race Heights") {
    return ScrollView {
        AnyView(PreviewResolvableView(
            TableEntryHeaderRenderer.self,
            matching: .init(
                source: "phb",
                chapter: 4,
                type: "table",
                offset: nil
            )
        ))
    }
}

#Preview("Archdevil Lair Actions") {
    return ScrollView {
        AnyView(PreviewResolvableView(
            TableEntryHeaderRenderer.self,
            matching: .init(
                source: "coa",
                chapter: 13,
                type: "table",
                offset: nil
            )
        ))
    }
}
