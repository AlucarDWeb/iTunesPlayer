//
//  MusicDatasource.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 20/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

protocol MusicListDatasourceProtocol: Datasource {
	func fetch<T: Decodable>(with searchParameters: String, completion: @escaping(Result<T, Error>) ->Void)
}

final class MusicListDatasource: MusicListDatasourceProtocol {
	
	private let networkClient: NetworkClient
	
	init(with networkClient: NetworkClient) {
		self.networkClient = networkClient
	}
	
	func fetch<T: Decodable>(with searchParameters: String, completion: @escaping (Result<T, Error>) -> Void) {
		networkClient.perform(requestType: .getMusic(parameters: searchParameters), completionHandler: completion)
	}
}