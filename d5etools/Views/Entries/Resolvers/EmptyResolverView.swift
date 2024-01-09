//
//  EmptyResolverView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct EmptyResolverView: ResolvableEntryRenderer {
    static var types: [String] = ["section", "entries", "list"]
    
    var entry: EntryModel
    
    init(entry: EntryModel) {
        self.entry = entry
    }
    
    var body: some View {
        EmptyView()
    }
}
