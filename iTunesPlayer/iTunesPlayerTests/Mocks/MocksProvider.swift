//
//  MocksProvider.swift
//  iTunesPlayerTests
//
//  Created by Ferdinando Furci on 27/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation
@testable import iTunesPlayer

protocol MocksProviderProtocol {
	func songPreviewDatasource() -> SongPreviewDatasourceProtocol
	func musicListDatasource() -> MusicListDatasourceProtocol
	func networkClient() -> NetworkClientProtocol
	func mockedSong() -> Song
	func mockedDataset() -> [Song]
}

final class MocksProvider: MocksProviderProtocol {
	
	func songPreviewDatasource() -> SongPreviewDatasourceProtocol {
		return SongPreviewDatasourceMock(with: networkClient())
	}
	
	func musicListDatasource() -> MusicListDatasourceProtocol {
		return MusicListDatasourceMock(with: networkClient())
	}
	
	func networkClient() -> NetworkClientProtocol {
		let configuration = URLSessionConfiguration.default
		configuration.protocolClasses = [MockedURLProtocol.self]
		let urlSession = URLSession.init(configuration: configuration)
		return NetworkClientMock(session: urlSession)
	}
	
	func mockedSong() -> Song {
		return Song(artistName: "Michael Jackson",
					trackName: "Billie Jean",
					collectionName: "The Essential Michael Jackson",
					releaseDate: Date(),
					thumbnail: URL(fileURLWithPath: "https://is2-ssl.mzstatic.com/image/thumb/Music127/v4/8a/65/be/8a65bef2-f23d-e43d-9124-f5e4293513f7/source/100x100bb.jpg"),
					coverDetail: URL(fileURLWithPath: "https://is2-ssl.mzstatic.com/image/thumb/Music127/v4/8a/65/be/8a65bef2-f23d-e43d-9124-f5e4293513f7/source/100x100bb.jpg"),
					trackPrice: 1.89,
					genre: "Pop",
					trackTimeMillis: 294601,
					previewUrl: URL(fileURLWithPath: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview122/v4/c6/50/11/c6501132-e865-3711-175a-ddb79114e42f/mzaf_3806132797788612279.plus.aac.p.m4a"),
					currency: .USD)
	}
	
	func mockedDataset() -> [Song] {
		return [Song(artistName: "Michael Jackson",
					 trackName: "Billie Jean",
					 collectionName: "The Essential Michael Jackson",
					 releaseDate: Date(),
					 thumbnail: URL(fileURLWithPath: "https://is2-ssl.mzstatic.com/image/thumb/Music127/v4/8a/65/be/8a65bef2-f23d-e43d-9124-f5e4293513f7/source/100x100bb.jpg"),
					 coverDetail: URL(fileURLWithPath: "https://is2-ssl.mzstatic.com/image/thumb/Music127/v4/8a/65/be/8a65bef2-f23d-e43d-9124-f5e4293513f7/source/100x100bb.jpg"),
					 trackPrice: 1.89,
					 genre: "Pop",
					 trackTimeMillis: 294601,
					 previewUrl: URL(fileURLWithPath: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview122/v4/c6/50/11/c6501132-e865-3711-175a-ddb79114e42f/mzaf_3806132797788612279.plus.aac.p.m4a"),
					 currency: .USD),
				Song(artistName: "Metallica",
					 trackName: "The Unforgiven",
					 collectionName: "Metallica",
					 releaseDate: Date(),
					 thumbnail: URL(fileURLWithPath: "https://is2-ssl.mzstatic.com/image/thumb/Music127/v4/8a/65/be/8a65bef2-f23d-e43d-9124-f5e4293513f7/source/100x100bb.jpg"),
					 coverDetail: URL(fileURLWithPath: "https://is2-ssl.mzstatic.com/image/thumb/Music127/v4/8a/65/be/8a65bef2-f23d-e43d-9124-f5e4293513f7/source/100x100bb.jpg"),
					 trackPrice: 2.99,
					 genre: "Metal",
					 trackTimeMillis: 274601,
					 previewUrl: URL(fileURLWithPath: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview122/v4/c6/50/11/c6501132-e865-3711-175a-ddb79114e42f/mzaf_3806132797788612279.plus.aac.p.m4a"),
					 currency: .USD),
				Song(artistName: "Nirvana",
					 trackName: "Smells like teen spirit",
					 collectionName: "Nevermind",
					 releaseDate: Date(),
					 thumbnail: URL(fileURLWithPath: "https://is2-ssl.mzstatic.com/image/thumb/Music127/v4/8a/65/be/8a65bef2-f23d-e43d-9124-f5e4293513f7/source/100x100bb.jpg"),
					 coverDetail: URL(fileURLWithPath: "https://is2-ssl.mzstatic.com/image/thumb/Music127/v4/8a/65/be/8a65bef2-f23d-e43d-9124-f5e4293513f7/source/100x100bb.jpg"),
					 trackPrice: 0.99,
					 genre: "Rock",
					 trackTimeMillis: 284601,
					 previewUrl: URL(fileURLWithPath: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview122/v4/c6/50/11/c6501132-e865-3711-175a-ddb79114e42f/mzaf_3806132797788612279.plus.aac.p.m4a"),
					 currency: .USD)]
	}
}
