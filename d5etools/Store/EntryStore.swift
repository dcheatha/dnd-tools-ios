//
//  EntryStore.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

class EntryStore {
    static let shared = EntryStore()
    var entries: [String: [EntryOrTextModel]] = [:]
    
    public func loadEntries(for id: String, model: EntryOrTextModel) -> [EntryOrTextModel] {
        if let entry = entries[id] {
            return entry
        }
        
        let flattened = flatten(model: model, depth: 0)
        entries[id] = flattened
        return flattened
    }
    
    private func flatten(model: EntryOrTextModel, depth: Int) -> [EntryOrTextModel] {
        guard let hierarcy = model.hierarcy else { return [] }
        
        hierarcy.depth = depth
        
        if case .text = model.data {
            return [model]
        }
        
        for child in hierarcy.children {
            child.hierarcy.parent = model
        }
        
        let flattenedChildren = hierarcy.children
            .map { flatten(model: $0, depth: depth + 1) }
            .flatMap { $0 }
        
        return [model] + flattenedChildren
    }
}
