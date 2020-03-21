//
//  NetworkTask.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 21/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation



// MARK: - NetworkTask
protocol NetworkTask {
	var baseURL: String { get }
	var method: HTTPMethod { get }
	var queryItems: [URLQueryItem] { get }
	
	init(parameters: String)
}

// MARK: - NetworkError
enum NetworkError: Error {
    case unknown
    case malformedURL
    case noNetwork
    case noResults
    case invalidResponse
    case invalidData(statusCode: Int)
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            return NSLocalizedString("An unknown error has occured", comment: "general")
        case .malformedURL:
            return NSLocalizedString("An error has occured while providing the url", comment: "malformed url")
        case .noNetwork:
            return NSLocalizedString("No internet connection", comment: "no internet connection")
        case.noResults:
            return NSLocalizedString("No results", comment: "No results")
        case .invalidResponse:
            return NSLocalizedString("The response is not valid", comment: "The response is not valid")
        case .invalidData(let statusCode):
            return NSLocalizedString("The returned data is not valid. Status code: \(statusCode)", comment: "invalid data")
        }
    }
}

// MARK: - HTTPMethod
enum HTTPMethod: String {
    case get = "GET"
}

// MARK: - NetworkTaskType
enum NetworkTaskType {
	case getMusic(parameters: String)
	
	func task() -> NetworkTask {
		switch self {
		case .getMusic(let parameters):
			return GetMusic(parameters: parameters)
		}
	}
}
