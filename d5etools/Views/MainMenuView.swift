//
//  MainMenuView.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

struct MainMenuView: View {
    @EnvironmentObject var navigation: TaggedNavigationViewModel
    
    var mainMenu = MainMenuCategory.build()
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                VStack {
                    HeadlineTextView(text: "5e Mobile Handbook", fontSize: 30)
                }
                .safeAreaPadding()
                
                HStack(alignment: .top) {
                    ForEach(mainMenu) { category in
                        VStack(alignment: .leading) {
                            let color: Color = .randomHue
                            HeadlineTextView(text: category.name, color: color)
                            ContainerView(color: color) {
                                ForEach(category.items) { item in
                                    TaggedTextView(text: item.name)
                                        .onTapGesture {
                                            navigation.navigateTo(tag: item.tag)
                                        }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

