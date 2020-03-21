//
//  URLExtension.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 21/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

 // MARK: - URL
extension URL {
    func appending(queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
        return urlComponents.url
    }
}
