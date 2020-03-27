//
//  MusicDatasource.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 20/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

// MARK: - MusicListDatasourceProtocol
protocol MusicListDatasourceProtocol: Datasource {
	func fetch<T: Decodable>(with searchParameters: String, completion: @escaping(Result<T, Error>) ->Void)
}

// MARK: - MusicListDatasource
final class MusicListDatasource: MusicListDatasourceProtocol {
	private let networkClient: NetworkClient
	
	// MARK: Initialization
	init(with networkClient: NetworkClient) {
		self.networkClient = networkClient
	}
	
	// MARK: Protocol functions
	func fetch<T: Decodable>(with searchParameters: String, completion: @escaping (Result<T, Error>) -> Void) {
		networkClient.perform(requestType: .getMusic(parameters: searchParameters), completionHandler: completion)
	}
}
