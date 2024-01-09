//
//  MainResolverView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct MainResolverView: View {
    var tag: String
    
    @EnvironmentObject var navigation: TaggedNavigationViewModel
    
    let taggableViews: [any ResolvableTagViewProtocol.Type] = [
        BookChapterView.self,
        BookTableOfContentsView.self,
        BookLibraryView.self,
    ]
    
    var body: some View {
        if let view = resolveTaggedView() {
            AnyView(view)
        } else {
            ErrorTextView(text: "No tagged view to resolve \(tag) \(tag.tagId())")
        }
    }
    
    func resolveTaggedView() -> (any ResolvableTagViewProtocol)? {
        guard let match = TagPreprocessor.shared.parseFirstTag(text: tag) else {
            return nil
        }
        
        guard let tagId = match.tag else { return nil }
        let argCount = match.args().count
        
        let viewType = taggableViews
            .filter { $0.tagInfo.prefixes.contains(tagId) }
            .filter { $0.tagInfo.minArgs <= argCount }
            .first
        
        return if let viewType {
            viewType.init(tag: tag)
        } else {
            nil
        }
    }
}
