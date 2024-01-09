//
//  ErrorTextView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct ErrorTextView: View {
    let text: String
    
    var body: some View {
        TaggedTextView(text: text, fontSize: 15)
            .background(.red)
            .cornerRadius(10)
    }
}

#Preview {
    TaggedTextView(text: "Test")
}
