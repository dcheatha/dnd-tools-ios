//
//  ViewExtensions.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation
import SwiftUI

extension View {
    public func standardPadding() -> some View {
        return padding(
            EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 5)
        )
    }
    
    
    public func VPadding() -> some View {
        return padding(
            EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        )
    }
    
    
    public func HPadding() -> some View {
        return padding(
            EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        )
    }
}
