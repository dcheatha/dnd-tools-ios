//
//  DataWrapper.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

@dynamicMemberLookup
class Model<DataType: Decodable>: Decodable, Identifiable {
    private var generatedId: String = UUID().uuidString.hexHash()
    var id: String { generatedId }
    let data: DataType
    
    required init(from decoder: Decoder) throws {
        self.data = try decoder.singleValueContainer().decode(DataType.self)
    }
    
    init(_ data: DataType) {
        self.data = data
    }

    subscript<T>(dynamicMember keyPath: KeyPath<DataType, T>) -> T {
        data[keyPath: keyPath]
    }
}
