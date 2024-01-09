//
//  ContentView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct MainNavigationStackView: View {
    @EnvironmentObject var navigation: TaggedNavigationViewModel

    var body: some View {
        NavigationStack(path: $navigation.navPath) {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack {
                    MainMenuView()
                    Spacer()
                }.navigationDestination(for: String.self) {
                    tag in
                    MainResolverView(tag: tag)
                        .toolbar {
                            ToolbarItem(placement: .principal) {
                                VStack {
                                    HeadlineTextView(text: tag)
                                }
                            }
                        }
                }
            }
        }
    }
}
