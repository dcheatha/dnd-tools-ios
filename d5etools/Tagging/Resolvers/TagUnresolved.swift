//
//  TagUnresolved.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation
import SwiftUI

class TagUnresolved: ResolvableTagRenderer {
    override var isLink: Bool { true }
    override var tags: [String] { [] }
}
