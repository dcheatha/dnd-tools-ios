//
//  RichEntryBrowserView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct EntryBrowserView: View {
    var entries: [EntryOrTextModel]
    
    @ObservedObject
    var browserViewModel = EntryBrowserViewModel()
    
    var currentEntry: EntryOrTextModel? {
        guard let topVisibleId = browserViewModel.tracker.topVisible ?? entries.first?.id else { return nil }
        return entries.first { $0.id == topVisibleId }
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(entries) { entryOrTextModel in
                        if !entryOrTextModel.hierarcy.isRenderedNested {
                            EntryOrTextView(entry: entryOrTextModel)
                        }
                    }
                }
            }
            
            HStack(alignment: .top) {
                if let currentEntry {
                    EntryFullPathTitleView(hierarcy: currentEntry.hierarcy)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(.background)
            .overlay {
                GeometryReader { geometry in
                    let maxY = geometry.frame(in: .global).maxY
                    Color.clear
                        .onChange(of: maxY) {
                            _, _ in
                            browserViewModel.tracker.maxHeightToAppear = maxY
                        }
                }
            }
        }
            .environmentObject(browserViewModel)
    }
    
}
