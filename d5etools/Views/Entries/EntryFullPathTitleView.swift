//
//  RichEntryRecursiveTitleView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct EntryFullPathTitleView: View {
    var hierarcy: HierarchyModel
    
    var displayableHierarcy: [HierarchyModel] {
        let familyTree = hierarcy.ancestors + [hierarcy.current]
        
        return familyTree
            .filter { $0.hierarcy.shouldDisplayHierarchy == true }
            .map { $0.hierarcy }
    }
    
    var body: some View {
        let data = displayableHierarcy
        
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(zip(data.indices, data)), id: \.1.current.id) {
                idx, hierarcyItem in
                
                if let model = hierarcyItem.current.model {
                    DepthView(hierarcy: hierarcyItem, depth: hierarcyItem.depth) {
                        EntryTitleView(entry: model)
                    }
                }
            }
        }
    }
}

