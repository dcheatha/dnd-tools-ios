//
//  EntryOrTextModel.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation
import SwiftUI

class EntryOrTextModel: Model<EntryOrText> {
    public override var id: String {
        switch data {
        case .model(let model):
            return model.id
        case .text(let text):
            return text.hexHash()
        }
    }
    
    public var type: String {
        model?.type ?? "text"
    }
    
    public var hierarcy: HierarchyModel!
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        self.hierarcy = HierarchyModel(current: self)
        
        if let model {
            model.hierarcy = self.hierarcy
        }
    }
    
    var model: EntryModel? {
        if case let .model(model) = data {
            return model
        }
        
        return nil
    }
    
    var text: String? {
        if case let .text(text) = data {
            return text
        }
        
        return nil
    }
}

enum EntryOrText: Decodable {
    case text(String)
    case model(EntryModel)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let text = try? container.decode(String.self) {
            self = .text(text)
            return
        }
        
        if let number = try? container.decode(Int.self) {
            self = .text(String(number))
            return
        }
        
        do {
            let richModel = try container.decode(EntryModel.self)
            self = .model(richModel)
        } catch {
            throw error
        }
    }
}
