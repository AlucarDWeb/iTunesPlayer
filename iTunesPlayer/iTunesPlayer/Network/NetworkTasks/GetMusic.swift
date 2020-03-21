//
//  File.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 21/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

struct GetMusic: NetworkTask {
	var baseURL: String = ""
	
	var method: HTTPMethod = .get
	
	var queryItems: [URLQueryItem] = []
	
	init(parameters: String) {
		
	}
}
