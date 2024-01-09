//
//  TagArea.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

class TagArea: ResolvableTagRenderer {
    override var isLink: Bool { true }
    override var tags: [String] { ["area"] }
    
    override func displayText(tagMatch: inout TagAttributable) -> AttributedString {
        AttributedString("Area \(tagMatch.displayText)")
    }
}
