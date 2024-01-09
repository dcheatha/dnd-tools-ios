//
//  TaggedTextView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct TaggedTextView: View {
    var text: String
    var fontSize: CGFloat = 18
    
    static let padding: CGFloat = 8
    static var textPadding: EdgeInsets = EdgeInsets(
        top: TaggedTextView.padding,
        leading: TaggedTextView.padding,
        bottom: TaggedTextView.padding,
        trailing: TaggedTextView.padding
    )
    
    var body: some View {
        Text(text.tagged())
            .padding(TaggedTextView.textPadding)
            .font(
                .scalySans(size: fontSize)
            )
            .background(.regularMaterial)
            .cornerRadius(10)
    }
}

#Preview("PlainText") {
    TaggedTextView(text: "Test")
}

#Preview("Fake Tag") {
    TaggedTextView(text: "{@fake tag}")
}
