//
//  SongPreviewDatasource.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 25/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

// MARK: - SongPreviewDatasourceProtocol
protocol SongPreviewDatasourceProtocol: Datasource {
	var songDownloadDestinationURL: URL? { get }
	
	func download(from URL: URL, to destinationURL: URL?, completionHandler: @escaping (Result<URL, Error>) -> Void)
	
}

// MARK: - SongPreviewDatasource
final class SongPreviewDatasource: SongPreviewDatasourceProtocol {
	
	var songDownloadDestinationURL: URL? {
		guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
		return documentsURL.appendingPathComponent("tempSong.m4a")
	}
	
	private let networkClient: NetworkClientProtocol
	
	// MARK: Initialization
	init(with networkClient: NetworkClientProtocol) {
		self.networkClient = networkClient
	}
	
	// MARK: Protocol functions
	func download(from URL: URL, to destinationURL: URL?, completionHandler: @escaping (Result<URL, Error>) -> Void) {
		networkClient.download(from: URL, to: destinationURL, completionHandler: completionHandler)
	}
}
