//
//  ResolvableTagRenderer.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation
import SwiftUI

class ResolvableTagRenderer {
    var tags: [String] { [] }
    var isLink: Bool { false }
    var color: Color = .randomHue
    var container: AttributeContainer { AttributeContainer().foregroundColor(color) }
    
    func displayText(tagMatch: inout TagAttributable) -> AttributedString {
        AttributedString(tagMatch.displayText)
    }
    
    func attribute(tagMatch: inout TagAttributable) {
        color = .signatureHue(tagMatch.value)
        
        var displayText = displayText(tagMatch: &tagMatch)
        
        var containerToRender = container
        
        if isLink, let url = URL(string: "dndtools://tag/\(tagMatch.fullMatch)") {
            containerToRender = containerToRender
                .link(url)
                .underlineStyle(Text.LineStyle(pattern: .dot, color: color)
            )
        }
        
        displayText.setAttributes(containerToRender)
        
        tagMatch.attributedResult += displayText
    }
}
