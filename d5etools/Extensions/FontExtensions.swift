//
//  FontExtensions.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import SwiftUI

extension Font {
    static func scalySans(size: CGFloat) -> Font  {
        .custom("ScalySansRemakeRegular", size: size)
    }
    
    static func mrEaves(size: CGFloat) -> Font {
        .custom("MrEavesSCRemakeMedium", size: size)
    }
    
    static func zatannaMisdirection(size: CGFloat) -> Font {
        .custom("ZatannaMisdirection", size: size)
    }
}
