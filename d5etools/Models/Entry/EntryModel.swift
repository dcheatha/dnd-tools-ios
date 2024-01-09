//
//  RichEntryModel.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation
import SwiftUI

class EntryModel: Model<EntryData> {
    public var hierarcy: HierarchyModel!
}

enum EntryOrManyEntryModel: Decodable {
    case one(EntryOrTextModel)
    case many([EntryOrTextModel])
    
    var children: [EntryOrTextModel] {
        switch self {
        case .one(let model): return [model]
        case .many(let models): return models
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let text = try? container.decode(EntryOrTextModel.self) {
            self = .one(text)
            return
        }
        
        do {
            let model = try container.decode([EntryOrTextModel].self)
            self = .many(model)
        } catch {
            throw error
        }
    }
}

struct EntryData: Decodable {
    let type: String
    
    let name: String?
    let page: Int?
    
    let caption: String?
    
    let entries: [EntryOrTextModel]?
    let items: [EntryOrTextModel]?
    let rows: [EntryOrManyEntryModel]?
    let row: [EntryOrTextModel]?
    let roll: Roll?
    
    let colLabels: [String]?
    let footnotes: [EntryOrTextModel]?
    
    let title: String?
    let credit: String?
    let href: Href?
    
    let entry: String?
    
    let by: String?
}
