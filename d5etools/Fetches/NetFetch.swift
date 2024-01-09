//
//  Fetch.swift
//  d5etools
//
//  Created by Daria Cheatham.
//

import Foundation

typealias NetFetchResult<T> = Result<T, Error>
typealias NetFetchCompletion<T> = (Result<T, Error>) -> Void

class NetFetch {
    static let shared = NetFetch()
    static let decoder = JSONDecoder()
    
    enum FetchError: Error {
        case emptyData
    }
    
    private init() {
        URLCache.shared.diskCapacity = 1_000_000_000
    }
    
    func `as`<DecodableType: Decodable>(_ req: URLRequest, completion: @escaping NetFetchCompletion<DecodableType>) {
        raw(req) {
            result in
            
            if case .failure(let failure) = result {
                completion(.failure(failure))
                return
            }

            do {
                let data = try result.get()
                let parsedData = try NetFetch.decoder.decode(DecodableType.self, from: data)
                completion(.success(parsedData))
            }
            catch {
                print("Failed to decode: ", error)
                completion(.failure(error))
            }
        }
    }
    
    func raw(_ req: URLRequest, completion: @escaping NetFetchCompletion<Data>) {
        URLSession.shared.dataTask(with: req) {
            data, urlResponse, error in
            
            if let error {
                print("Failed to fetch: ", error)
                completion(.failure(error));
                return;
            }
            
            if let data {
                completion(.success(data))
            } 
            else {
                completion(.failure(FetchError.emptyData))
            }
        }.resume()
    }
}
