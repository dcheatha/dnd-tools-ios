//
//  TableEntryBodyRenderer.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation
import SwiftUI

struct TableEntryBodyRenderer: ResolvableEntryRenderer {
    static var types: [String] = ["table"]
    var entry: EntryModel
    
    init(entry: EntryModel) {
        self.entry = entry
    }
    
    var body: some View {
        if let rows = entry.data.rows {
            ForEach(Array(zip(rows.indices, rows)), id: \.0) {
                rowIndex, row in
                
                Divider()
                    .gridCellUnsizedAxes(.horizontal)
                    .frame(height: 1)
                    .overlay(entry.hierarcy.color.opacity(0.5))
                
                if case let .many(columns) = row {
                    GridRow {
                        ForEach(Array(zip(columns.indices, columns)), id: \.0) {
                            colIndex, column in
                            HStack(spacing: 0) {
                                EntryOrTextView(entry: column)
                                
                                Spacer()
                                
                                if colIndex < columns.count - 1 {
                                    Divider()
                                        .gridCellUnsizedAxes(.vertical)
                                        .frame(width: 1)
                                        .overlay(entry.hierarcy.color.opacity(0.5))
                                }
                            }
                        }
                    }
                } else {
                    tableRowOrSubEntry(row: row)
                }
            }
        }
    }
    
    func tableRowOrSubEntry(row: EntryOrManyEntryModel) -> AnyView {
        if case let .one(column) = row {
            return if column.type == "row" {
                AnyView(TableRowRenderer(entry: column.model!))
            } else {
                AnyView(EntryOrTextView(entry: column))
            }
        }
        
        return AnyView(EmptyView())
    }
}

#Preview("Race Heights") {
    return ScrollView {
        Grid {
            AnyView(PreviewResolvableView(
                TableEntryBodyRenderer.self,
                matching: .init(
                    source: "phb",
                    chapter: 4,
                    type: "table",
                    offset: nil
                )
            ))
        }
    }
}

#Preview("Archdevil Lair Actions") {
    return ScrollView {
        Grid {
            AnyView(PreviewResolvableView(
                TableEntryBodyRenderer.self,
                matching: .init(
                    source: "coa",
                    chapter: 13,
                    type: "table",
                    offset: nil
                )
            ))
        }
    }
}
