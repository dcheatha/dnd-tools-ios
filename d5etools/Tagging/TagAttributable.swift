//
//  TagAttributer.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

struct TagAttributable {
    let tag: String
    let value: String
    let fullMatch: String
    var attributedResult: AttributedString
    
    var displayText: String {
        (args.first ?? value).trim()
    }
    
    var args: [String] {
        let components = value.components(separatedBy: "|")
        return Array(components)
    }
}
