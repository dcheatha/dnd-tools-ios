//
//  EntrySectionView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct EntryTitleView: View {
    var entry: EntryModel
    
    var font: Font {
        if entry.hierarcy?.depth ?? 0 == 0 {
            return .mrEaves(size: 22)
        }
        
        return .mrEaves(size: 20)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                if let name = entry.name {
                    Text(name)
                        .font(font)
                        .foregroundStyle(entry.hierarcy?.color ?? .black)
                }
                Spacer()
                if let page = entry.data.page {
                        Text("Page \(page)")
                            .font(.scalySans(size: 15))
                }
            }
        }
    }
}
