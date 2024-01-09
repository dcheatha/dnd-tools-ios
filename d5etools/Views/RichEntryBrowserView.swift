//
//  RichEntryBrowserView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct EntryBrowserView: View {
    var rootEntry: EntryModel
    @ObservedObject var viewModel: EntryBrowserViewModel
    
    var topMenuResizedDebouncer = Debounce()
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView {
                EntryView(model: rootEntry, viewModel: viewModel)
            }
            
            HStack(alignment: .top) {
//                if let entry = rootEntry.entry {
                    EntryFullPathTitleView(entry: rootEntry)
//                }
                Spacer()
            }
            .overlay {
                geometryReaderOverlay()
            }
            .background(.background)
            .frame(maxWidth: .infinity)
        }
    }
    
    func geometryReaderOverlay() -> some View {
        return GeometryReader { geometry in
            let maxY = geometry.frame(in: .global).maxY
            Color.clear
                .onAppear(perform: {
                    viewModel.traversableEntries.maxHeightToAppear = Float(maxY)
                })
                .onChange(of: geometry.frame(in: .global)) {
                    _, _ in
                    topMenuResizedDebouncer.debounce(interval: 0.1) {
                        viewModel.traversableEntries.maxHeightToAppear = Float(maxY)
                    }
                }
        }
    }
}

#Preview {
    guard let richEntry = SampleData().rootRichEntry() else { return EmptyView() }
    
    let viewModel = EntryBrowserViewModel(root: richEntry)
    
    return EntryBrowserView(rootEntry: richEntry, viewModel: viewModel)
}
