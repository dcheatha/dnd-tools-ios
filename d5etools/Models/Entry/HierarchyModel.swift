//
//  HierarchyModel.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation
import SwiftUI

class HierarchyModel {
    let color: Color
    var depth = 0
    
    var current: EntryOrTextModel
    
    var parent: EntryOrTextModel?
    var hasParent: Bool { parent != nil }

    var ancestors: [EntryOrTextModel] {
        if let parent {
            return (parent.hierarcy?.ancestors ?? []) + [parent]
        } else {
            return []
        }
    }
    
    var isRenderedNested: Bool {
        firstAncestor(ofType: "table") != nil
    }
    
    var children: [EntryOrTextModel] {
        guard case let .model(model) = current.data else { return [] }
        
        let rowChildren: [EntryOrTextModel] =
            model.rows?.map { $0.children }.flatMap { $0 } ?? []
        
        return [
            model.entries ?? [],
            model.items ?? [],
            model.row ?? [],
            rowChildren
        ].flatMap { $0 }
    }
    
    var shouldDisplayHierarchy: Bool {
        !isRenderedNested && current.model?.name != nil
    }
    
    init(current: EntryOrTextModel) {
        self.current = current
        self.color = .randomHue
    }
    
    func firstAncestor(ofType type: String) -> EntryOrTextModel? {
        self.ancestors.first { $0.model?.type == type }
    }
}
