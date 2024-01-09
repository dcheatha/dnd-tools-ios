//
//  5eNetFetch.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

class DnDNetFetch {
    static let shared = DnDNetFetch()
    let netFetch = NetFetch.shared
    
    var baseUrl: String {
        "https://5e.tools/"
    }
    
    public func `as`<DecodableType: Decodable>(_ path: String, completion: @escaping NetFetchCompletion<DecodableType>) {
        netFetch.as(buildRequest(path: path), completion: completion)
    }
    
    public func raw(_ path: String, completion: @escaping NetFetchCompletion<Data>) {
        netFetch.raw(buildRequest(path: path), completion: completion)
    }
    
    public func url(_ path: String) -> URL? {
        var components = URLComponents(string: baseUrl)!
        var path = path
        
        if path.first != "/" {
            path = "/\(path)"
        }
        
        components.path = path
        
        return components.url
    }
    
    private func buildRequest(path: String) -> URLRequest {
        let url = url(path)
        print("fetch", url!)
        return URLRequest(url: url!, cachePolicy: .returnCacheDataElseLoad)
    }
}
