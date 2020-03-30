//
//  MusicListDatasourceMock.swift
//  iTunesPlayerTests
//
//  Created by Ferdinando Furci on 27/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation
@testable import iTunesPlayer

final class MusicListDatasourceMock: MusicListDatasourceProtocol {
	init(with networkClient: NetworkClientProtocol) {}
	
	func fetch(with searchParameters: String, completion: @escaping (Result<Songlist, Error>) -> Void) {
		completion(.success(Songlist(results: MocksProvider().mockedDataset())))
	}
}
