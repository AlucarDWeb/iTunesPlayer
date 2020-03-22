//
//  File.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 21/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

struct GetMusic: NetworkTask {
	let baseURL: String = "https://itunes.apple.com/search?"
	
	let method: HTTPMethod = .get
	
	var queryItems: [URLQueryItem]? {
		return [URLQueryItem(name: "term", value: parameters)]
	}
	
	private let parameters: String
	
	init(parameters: String) {
		self.parameters = parameters
	}
}
