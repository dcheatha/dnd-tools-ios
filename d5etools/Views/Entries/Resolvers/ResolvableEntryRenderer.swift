//
//  ResolvableEntryRenderer.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation
import SwiftUI

protocol ResolvableEntryRenderer: View {
    static var types: [String] { get }
    
    var entry: EntryModel { get set }
    init(entry: EntryModel)
}

func PreviewResolvableView(_ type: any ResolvableEntryRenderer.Type, matching: SampleData.ObjectFinder) -> any View {
    guard let model = SampleData().loadObject(matching: matching)?.model else {
        return DetailTextView(text: "Could not locate object matching \(matching)")
    }
    
    @ObservedObject
    var browserViewModel = EntryBrowserViewModel()
    
    return type.init(entry: model)
            .environmentObject(browserViewModel)
}

