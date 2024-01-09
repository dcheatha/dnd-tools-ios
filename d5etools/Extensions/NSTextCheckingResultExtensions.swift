//
//  NSTextCheckingResultExtensions.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

extension NSTextCheckingResult {
    func copyRangeText(_ text: String, captureGroup: String?) -> String? {
        
        let range = if let captureGroup {
            Range(range(withName: captureGroup), in: text)
        } else {
            Range(range, in: text)
        }
        
        if let range {
            return String(text[range])
        } else {
            return nil
        }
    }
}
