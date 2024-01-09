//
//  StringExtensions.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

extension String {
    func tagged() -> AttributedString {
        if let attributed = TagPreprocessor.shared.attribute(text: self) {
            attributed
        } else {
            AttributedString(self)
        }
    }
    
    func tagName() -> String {
        TagPreprocessor.shared.parseFirstTag(text: self)?.args().first ?? self
    }
    
    func tagId() -> String {
        TagPreprocessor.shared.parseFirstTag(text: self)?.tag ?? self
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func hexHash() -> String {
        String(format:"%02X", self.hashValue)
    }
}
