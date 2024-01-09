//
//  Store.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

class Store {
    static let shared = Store()
    let book = BookStore.shared
    let entry = EntryStore.shared
}
