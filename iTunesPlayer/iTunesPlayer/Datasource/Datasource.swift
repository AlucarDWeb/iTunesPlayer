//
//  Datasource.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 20/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

protocol Datasource {
	
	init (with networkClient: NetworkClient)
	
	func fetch<T: Decodable>(with searchParameters: String, completion: @escaping(Result<T, Error>) ->Void)
}
