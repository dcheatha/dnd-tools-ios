//
//  Href.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

class Href: Decodable {
    let type: String?
    let path: String?
    
    var imagePath: String? {
        if let path {
            return "/img/\(path)"
        }
        
        return nil
    }
}
