//
//  RichEntryBrowserViewModel.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation
import Combine

class EntryBrowserViewModel: ObservableObject {
    let tracker = VisibleEntryTracker()
    
    private var objectUpdateStore = Set<AnyCancellable>()

    init() {
        tracker.objectWillChange.sink {
            [weak self] _ in
            self?.objectWillChange.send()
        }.store(in: &objectUpdateStore)
    }
}
