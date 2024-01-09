//
//  MainView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct MainView: View {
    var navigation = TaggedNavigationViewModel()
    
    var body: some View {
        MainNavigationStackView()
            .environmentObject(navigation)
            .onOpenURL { incomingURL in
                print("App was opened via URL: \(incomingURL)")
                navigation.navigateTo(tag: incomingURL.lastPathComponent)
            }
    }
}

#Preview {
    MainView()
}
