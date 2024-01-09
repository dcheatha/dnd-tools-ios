//
//  ImageExtensions.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

extension Image {
    static func from(data: Data) -> Image {
    #if canImport(UIKit)
        let imageWithData: UIImage = UIImage(data: data) ?? UIImage()
        return Image(uiImage: imageWithData)
    #elseif canImport(Cocoa)
        let imageWithData: NSImage = NSImage(data: data) ?? NSImage()
        return Image(nsImage: imageWithData)
    #endif
    }
}
