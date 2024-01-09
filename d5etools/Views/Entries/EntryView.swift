//
//  RichEntryComposedView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct EntryView: View {
    var model: EntryModel
    var viewModel: EntryBrowserViewModel?
    
    var body: some View {
        if model.name != nil, model.hierarcy?.shouldDisplayHierarchy == true {
            EntryTitleView(entry: model)
        }
        
        EntryResolverView(entry: model, viewModel: viewModel)
    }
}

#Preview {
    let finder = SampleData.ObjectFinder(
        source: "phb",
        chapter: 2,
        type: "entry",
        offset: nil
    )
    
    guard let model = SampleData().loadObject(matching: finder)?.model else { return DetailTextView(text: "Could not locate object") }
    
    return EntryView(model: model)
}
