//
//  EdgeInsetsExtension.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation
import SwiftUI

extension EdgeInsets {
    init(_ value: CGFloat) {
        self.init(top: value, leading: value, bottom: value, trailing: value)
    }
}
