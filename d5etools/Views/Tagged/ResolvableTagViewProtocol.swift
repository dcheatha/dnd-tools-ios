//
//  TaggedView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation
import SwiftUI

protocol ResolvableTagViewProtocol: View {
    static var tagInfo: TagInfo { get }
    
    init(tag: String)
}

struct TagInfo {
    var prefixes: [String]
    var minArgs: Int
}
