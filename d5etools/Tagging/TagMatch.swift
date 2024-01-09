//
//  TagMatch.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

struct TagMatch {
    let tag: String?
    let value: String?
    let fullMatch: String?
    var attributedResult: AttributedString?
    
    func args() -> [String] {
        guard let value else { return [] }
        let components = value.components(separatedBy: "|")
        return Array(components.dropFirst())
    }
}
