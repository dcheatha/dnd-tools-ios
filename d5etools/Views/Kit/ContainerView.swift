//
//  RichEntryView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

import SwiftUI

struct ContainerView<Content: View>: View {
    var color: Color
    var leadingPadding: CGFloat = 5
    var overlayWidth: CGFloat = 3
    
    @ViewBuilder let content: Content
    
    var outerPadding: EdgeInsets {
        return EdgeInsets(top: 0, leading: leadingPadding, bottom: 0, trailing: 0)
    }
    
    var innerPadding: EdgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    var body: some View {
        VStack(alignment: .leading) {
            content
        }
        .padding(outerPadding)
        .overlay(
            Rectangle().frame(
                width: overlayWidth, height: nil, alignment: .leading
            )
            .foregroundColor(color), alignment: .leading
        )
        .padding(innerPadding)
    }
}
