//
//  RollEntryView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

import SwiftUI

struct RollEntryRenderer: ResolvableEntryRenderer {
    static var types: [String] = ["roll", "cell"]
    var entry: EntryModel
    
    init(entry: EntryModel) {
        self.entry = entry
    }
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            if let roll = entry.data.roll {
                if let min = roll.min, let max = roll.max {
                    Text("\(min)-\(max)")
                        .font(.mrEaves(size: 26))
                }
                
                if let exact = roll.exact {
                    Text("\(exact)")
                        .font(.mrEaves(size: 26))
                }
            }
            
            if let entry = entry.entry {
                Text(entry)
            }
            
            Spacer()
        }
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

