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
	func fetch(with searchParameters: String, completion: @escaping(Result<Songlist, Error>) ->Void)
}

// MARK: - MusicListDatasource
final class MusicListDatasource: MusicListDatasourceProtocol {
	private let networkClient: NetworkClientProtocol
	
	// MARK: Initialization
	init(with networkClient: NetworkClientProtocol) {
		self.networkClient = networkClient
	}
	
	// MARK: Protocol functions
	func fetch(with searchParameters: String, completion: @escaping (Result<Songlist, Error>) -> Void) {
		networkClient.perform(requestType: .getMusic(parameters: searchParameters), completionHandler: completion)
	}
}
