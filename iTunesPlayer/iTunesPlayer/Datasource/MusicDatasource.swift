//
//  MusicDatasource.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 20/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

final class MusicDatasource: Datasource {
	private let networkClient: NetworkClient
	
	init(with networkClient: NetworkClient) {
		self.networkClient = networkClient
	}
}
