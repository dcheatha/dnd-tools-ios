//
//  DepthView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct DepthView<Content: View>: View {
    var hierarcy: HierarchyModel
    var depth: Int
    @ViewBuilder let content: Content
    
    var nextParent: HierarchyModel? {
        let familyPath = hierarcy.ancestors + [hierarcy.current]
        return familyPath.reversed()[safe: depth - 1]?.hierarcy
    }
    
    var body: some View {
        if hierarcy.isRenderedNested {
            return AnyView(content)
        }
        
        return containerOrContent
    }
    
    var containerOrContent: AnyView {
        if let nextParent, nextParent.shouldDisplayHierarchy {
            return AnyView(ContainerView(color: nextParent.color) {
                DepthView(hierarcy: hierarcy, depth: depth - 1) {
                    content
                }
            })
        } else {
            return AnyView(content
                .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0)))
        }
    }
}
