//
//  TagMapper.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

class TagResolver {
    let unresolvedRender = TagUnresolved()
    
    let renderers: [ResolvableTagRenderer] = [
        TagBold(),
        TagArea(),
    ]
    
    func attribute(tagMatch: inout TagMatch) {
        guard let tag = tagMatch.tag else { return }
        guard let value = tagMatch.value else { return }
        guard let fullMatch = tagMatch.fullMatch else { return }
        
        var attributable = TagAttributable(
            tag: tag,
            value: value,
            fullMatch: fullMatch,
            attributedResult: AttributedString()
        )
        
        let matchingResolver = renderers
            .filter { $0.tags.contains(tag) }
            .first
        
        if let resolver = matchingResolver {
            resolver.attribute(tagMatch: &attributable)
        } else {
            unresolvedRender.attribute(tagMatch: &attributable)
        }
        
        tagMatch.attributedResult = attributable.attributedResult
    }
}
