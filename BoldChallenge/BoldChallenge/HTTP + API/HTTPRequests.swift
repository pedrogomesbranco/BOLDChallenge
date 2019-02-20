//
//  HTTPRequests.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 13/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import Foundation
import UIKit

enum HTTPRequestsError: Error {
    case CouldNotFormURL
    case CouldNotParseResponse
    case Failure(String)
    case Unknown(String)
}

class HTTPRequests {
    
    /// Performs a GET operation at the specified url and returns a JSON.
    ///
    /// - Parameters:
    ///   - url: Url to be visited.
    ///   - completion: The completion handler to call when the load request is complete.
    public func getHTTP<T : Decodable>(at url: String, withCompletion completion: @escaping (T?, HTTPRequestsError?) -> Void) {
        guard let url = URL(string: url) else {
            completion(nil, .CouldNotFormURL)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, .Failure(error.localizedDescription))
            } else if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let obj = try jsonDecoder.decode(T.self, from: data)
                    
                    completion(obj, nil)
                }
                catch let error {
                    completion(nil, .Unknown(error.localizedDescription))
                }
            } else {
                completion(nil, .CouldNotParseResponse)
            }
            }.resume()
    }
    
    public func getHTTPPhoto(at url: URL, withCompletion completion: @escaping (Data?, HTTPRequestsError?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, .Failure(error.localizedDescription))
            } else if let photoData = data {
                completion(photoData, nil)
            } else {
                completion(nil, .CouldNotParseResponse)
            }
            }.resume()
    }
}
