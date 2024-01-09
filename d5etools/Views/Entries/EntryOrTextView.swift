//
//  EntryView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct EntryOrTextView: View {
    var entry: EntryOrTextModel
    @EnvironmentObject var browserViewModel: EntryBrowserViewModel
    
    var body: some View {
        DepthView(hierarcy: entry.hierarcy, depth: entry.hierarcy.depth) {
            if let model = entry.model {
                EntryView(model: model)
            } else if let text = entry.text {
                if entry.hierarcy.isRenderedNested {
                    DetailTextView(text: text, fontSize: 16)
                        .padding(.init(2))
                } else {
                    TaggedTextView(text: text)
                }
            }
        }
        .onAppear {
            browserViewModel.tracker.didAppear(entry: entry.id)
        }
        .onDisappear {
            browserViewModel.tracker.didDisappear(entry: entry.id)
        }
        .overlay {
            GeometryReader { geometry in
                let y = geometry.frame(in: .global).minY
                Color.clear
                    .onChange(of: geometry.frame(in: .global).minY) {
                        _, _ in
                        browserViewModel.tracker.didMove(
                            entry: entry.id,
                            y: y
                        )
                }
            }
        }

    }
}
