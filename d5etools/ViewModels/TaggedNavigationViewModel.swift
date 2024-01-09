//
//  TaggedNavigationViewModel.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation
import SwiftUI

class TaggedNavigationViewModel: ObservableObject {
    @Published var navPath: NavigationPath = NavigationPath()
    
    public func navigateTo(tag: String) {
        print("Navigating to \(tag)")
        navPath.append(tag)
    }
}
