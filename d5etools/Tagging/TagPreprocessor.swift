//
//  TextAnnotator.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation
import SwiftUI

class TagPreprocessor {
    static let shared = TagPreprocessor()
    static let tagPattern = #"\{\@(?<tag>\w+)((?<value>[^}]+))*\}"#
    lazy var tagMatcher = try! NSRegularExpression(pattern: TagPreprocessor.tagPattern)
    
    let resolver = TagResolver()
    
    private init() {}
    
    public func attribute(text: String) -> AttributedString? {
        var tags = findTags(text: text)
        
        for tagIndex in 0..<tags.count {
            resolver.attribute(tagMatch: &tags[tagIndex])
        }
        
        var attributedText = AttributedString(text)
        
        for tag in tags {
            guard let fullMatch = tag.fullMatch, 
                  let attributedResult = tag.attributedResult
                else { continue }
            
            guard let fullMatchRange = attributedText.range(of: fullMatch) 
                else { continue }
            
            attributedText.removeSubrange(fullMatchRange)
            attributedText.insert(attributedResult, at: fullMatchRange.lowerBound)
        }
        
        return attributedText
    }
    
    public func findFirstTag(text: String) -> String? {
        let tags = findTags(text: text)
        return tags.first?.tag
    }
    
    public func parseFirstTag(text: String) -> TagMatch? {
        findTags(text: text).first
    }
    
    private func findTags(text: String) -> [TagMatch] {
        let matchingRange = NSRange(location: 0, length: text.utf16.count)
        
        let rawMatches = tagMatcher.matches(in: text, range: matchingRange)
        
        return rawMatches.map {
            let tag = $0.copyRangeText(text, captureGroup: "tag")
            let value = $0.copyRangeText(text, captureGroup: "value")
            let fullMatch = $0.copyRangeText(text, captureGroup: nil)
            
            return TagMatch(
                tag: tag,
                value: value,
                fullMatch: fullMatch,
                attributedResult: nil
            )
        }
    }
        
}
