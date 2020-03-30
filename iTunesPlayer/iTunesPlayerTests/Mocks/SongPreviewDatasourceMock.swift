//
//  SongPreviewDatasourceMock.swift
//  iTunesPlayerTests
//
//  Created by Ferdinando Furci on 27/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation
@testable import iTunesPlayer

final class SongPreviewDatasourceMock: SongPreviewDatasourceProtocol {
	var songDownloadDestinationURL: URL? {
		guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
		return documentsURL.appendingPathComponent("testSong.m4a")
	}
	
	var fileDownloadedSuccessfully = false
	
	init(with networkClient: NetworkClientProtocol) {}
	
	func download(from URL: URL, to destinationURL: URL?, completionHandler: @escaping (Result<URL, Error>) -> Void) {
		fileDownloadedSuccessfully ? completionHandler(.success(songDownloadDestinationURL!)) : completionHandler(.failure(NetworkError.unknown))
	}
}
