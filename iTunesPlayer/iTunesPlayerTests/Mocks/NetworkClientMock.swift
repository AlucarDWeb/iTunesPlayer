//
//  NetworkClientMock.swift
//  iTunesPlayerTests
//
//  Created by Ferdinando Furci on 27/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation
@testable import iTunesPlayer

final class NetworkClientMock: NetworkClientProtocol {
	init(session: URLSession) {}
	
	func perform<T>(requestType: NetworkTaskType, completionHandler: @escaping (Result<T, Error>) -> Void) where T : Decodable {}
	
	func download(from URL: URL, to destinationURL: URL?, completionHandler: @escaping (Result<URL, Error>) -> Void) {}
}
