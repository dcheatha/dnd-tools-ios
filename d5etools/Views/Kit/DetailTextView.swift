//
//  DetailTextView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct DetailTextView: View {
    var text: String
    var fontSize: CGFloat = 15
    
    var body: some View {
        Text(text.tagged())
            .font(.scalySans(size: fontSize))
    }
}

#Preview {
    DetailTextView(text: "Text")
}
