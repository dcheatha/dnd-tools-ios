//
//  TableRowRenderer.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct TableRowRenderer: ResolvableEntryRenderer {
    static var types: [String] = ["row"]
    
    var entry: EntryModel
    
    init(entry: EntryModel) {
        self.entry = entry
    }
    
    var body: some View {
        if let row = entry.row {
            GridRow {
                ForEach(Array(zip(row.indices, row)), id: \.0) {
                    colIndex, column in
                    HStack(spacing: 0) {
                        
                        if colIndex == 0 {
                            Spacer()
                        }
                        
                        EntryOrTextView(entry: column)
                        
                        if colIndex != 0 {
                            Spacer()
                        }
                        
                        if colIndex < row.count - 1 {
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

