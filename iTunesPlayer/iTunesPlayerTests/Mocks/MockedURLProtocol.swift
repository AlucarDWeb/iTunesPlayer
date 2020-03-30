//
//  MockedURLProtocol.swift
//  iTunesPlayerTests
//
//  Created by Ferdinando Furci on 27/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation
@testable import iTunesPlayer

final class MockedURLProtocol: URLProtocol {
	static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?
	
	override class func canInit(with request: URLRequest) -> Bool {
		return true
	}
	
	override class func canonicalRequest(for request: URLRequest) -> URLRequest {
		return request
	}
	
	override func startLoading() {
		guard let handler = MockedURLProtocol.requestHandler else {
			fatalError("Handler is unavailable.")
		}
		
		do {
			// Call handler with received request and capture the tuple of response and data.
			let (response, data) = try handler(request)
			
			// Send received response to the client.
			client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
			
			if let data = data {
				// Send received data to the client.
				client?.urlProtocol(self, didLoad: data)
			}
			
			// Notify request has been finished.
			client?.urlProtocolDidFinishLoading(self)
		} catch {
			// Notify received error.
			client?.urlProtocol(self, didFailWithError: error)
		}
	}
	
	override func stopLoading() {
		// This is called if the request gets canceled or completed.
	}
}

