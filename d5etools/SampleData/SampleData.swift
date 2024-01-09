//
//  SampleDataLoader.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

class SampleData {
    let store = EntryStore.shared
    
    struct ObjectFinder {
        let source: String
        let chapter: Int
        let type: String

        let offset: Int?
    }
    
    public func loadObject(matching finder: ObjectFinder) -> EntryOrTextModel? {
        guard let chapter = loadChapter(fromSource: finder.source, chapterIdx: finder.chapter) else { return nil }
        
        var filtered = chapter
            .filter { $0.type == finder.type }
        
        if let selected = filtered[safe: finder.offset ?? 0] {
            debugPrint(selected)
            return selected
        } else {
            return nil
        }
    }
    
    public func loadChapter(fromSource sourceName: String, chapterIdx: Int) -> [EntryOrTextModel]? {
        guard let source = loadSource(name: sourceName) else { return nil }
        
        return if let chapter = source.data[safe: chapterIdx] {
            store.loadEntries(for: sourceName, model: chapter)
        } else {
            nil
        }
    }
    
    private func loadSource(name: String) -> FetchEntryData? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            print("Could not read file")
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            print("Could not read sample data")
            return nil
        }
        
        do {
            return try JSONDecoder().decode(FetchEntryData.self, from: data)
        } catch {
            print("Could not parse model", error)
            return nil
        }
    }
}
