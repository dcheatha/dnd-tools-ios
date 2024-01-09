//
//  HeadlineTextView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct HeadlineTextView: View {
    var text: String
    var color = Color.randomHue
    var fontSize: CGFloat = 22
    
    var body: some View {
        Text(text.tagged())
            .font(.mrEaves(size: fontSize))
            .foregroundStyle(color)
    }
}

#Preview {
    HeadlineTextView(text: "Headline")
}
