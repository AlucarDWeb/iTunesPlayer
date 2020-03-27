//
//  File.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 21/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

// MARK: - GetMusic
struct GetMusic: NetworkTask {
	private let parameters: String
	
	let baseURL: String = "https://itunes.apple.com/search?"
	let method: HTTPMethod = .get
	
	var queryItems: [URLQueryItem]? {
		return [URLQueryItem(name: "term", value: parameters)]
	}
	
	// MARK: Initialization
	init(parameters: String) {
		self.parameters = parameters
	}
}
