//
//  TraversableEntries.swift
//  d5etools
//
//  Created by Daria Cheatham.
//
import Foundation
import Combine

class VisibleEntryTracker: ObservableObject {
    var visibleEntries: Set<VisibleEntry> = []
    let updateTopViewPublisher = PassthroughSubject<(), Never>()
    var cancellable: AnyCancellable?

    @Published
    var topVisible: String?
    
    @Published
    var maxHeightToAppear: CGFloat = 0.0
    
    struct VisibleEntry: Hashable {
        let id: String
        var y: CGFloat?
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
    
    init() {
        cancellable = updateTopViewPublisher
            .throttle(for: .seconds(0.1), scheduler: DispatchQueue.main, latest: true)
            .sink(receiveValue: {
                self.updateTopVisible()
            })
    }
    
    public func didAppear(entry id: String) {
        let entry = visibleEntries.first { $0.id == id }
        guard entry == nil else { return }
        visibleEntries.insert(VisibleEntry(id: id))
    }
    
    public func didDisappear(entry id: String) {
        let entry = visibleEntries.first { $0.id == id }
        guard let entry else { return }
        visibleEntries.remove(entry)
    }
    
    public func didMove(entry id: String, y: CGFloat) {
        let newEntry = VisibleEntry(id: id, y: y)
        calculateMovement(newEntry: newEntry)
    }
    
    private func calculateMovement(newEntry: VisibleEntry) {
        let currentEntry = visibleEntries.first { $0.id == newEntry.id }
        guard var currentEntry else { return }

        visibleEntries.remove(currentEntry)
        currentEntry.y = newEntry.y
        visibleEntries.insert(currentEntry)
        
        updateTopViewPublisher.send(())
    }
    
    private func updateTopVisible() {
        let nonNilEntries = visibleEntries
            .filter { $0.y != nil }
        
        let scrolledPastEntries = nonNilEntries
                .filter { $0.y! < maxHeightToAppear }
                .sorted { $0.y! > $1.y! }
        
        topVisible = scrolledPastEntries.first?.id
    }
}
