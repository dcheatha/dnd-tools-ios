//
//  entryMapperView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct EntryResolverView: View {
    var entry: EntryModel
    var viewModel: EntryBrowserViewModel?
    
    let renders: [any ResolvableEntryRenderer.Type] = [
        ImageEntryRenderer.self,
        QuoteEntryRenderer.self,
        RollEntryRenderer.self,
        TableEntryRenderer.self,
        TableRowRenderer.self,
        EmptyResolverView.self,
    ]
    
    var body: some View {
        VStack {
            //        Text("\(entry.data.type) \(entry.id) depth=\(entry.hierarcy.depth) children=\(entry.hierarcy.children.count)")
            //            .font(.scalySans(size: 15))
            render()
        }
    }
    
    func render() -> AnyView {
        let renderer = renders
            .filter { $0.types.contains(entry.type) }
            .first
        
        guard let renderer else {
            return AnyView(FallbackEntryRenderer(entry: entry))
        }
        
        let view: any View = renderer.init(entry: entry)
        return AnyView(view)
    }
}

