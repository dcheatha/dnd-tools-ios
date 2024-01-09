//
//  CollectionExtensions.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
