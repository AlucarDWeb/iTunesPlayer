//
//  Song.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 21/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

// MARK: - CurrencyUnit
enum CurrencyUnit: String, Decodable {
	case USD
}

// MARK: - Songlist
struct Songlist: Decodable {
	let results: [Song]
}

// MARK: - Song
struct Song: Decodable {
	let artistName: String
	let trackName: String?
	let collectionName: String?
	let releaseDate: Date
	let thumbnail: URL // artworkUrl60
	let coverDetail: URL // artworkUrl100
	let trackPrice: Double?
	let genre: String //primaryGenreName
	private let trackTimeMillis: Double?
	let previewUrl: URL?
	let currency: CurrencyUnit
	
	var duration: String {
		return DateFormatter.millisecondsConvertionToMinutes(rawMillis: trackTimeMillis ?? 0)
	}
	
	private enum CodingKeys: String, CodingKey {
		case artistName
		case trackName
		case collectionName
		case releaseDate
		case thumbnail = "artworkUrl60"
		case coverDetail = "artworkUrl100"
		case trackPrice
		case genre = "primaryGenreName"
		case trackTimeMillis
		case previewUrl
		case currency
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		artistName = try container.decode(String.self, forKey: .artistName)
		trackName = try container.decodeIfPresent(String.self, forKey: .trackName)
		collectionName = try container.decodeIfPresent(String.self, forKey: .collectionName)
		releaseDate = try container.decode(Date.self, forKey: .releaseDate)
		thumbnail = try container.decode(URL.self, forKey: .thumbnail)
		coverDetail = try container.decode(URL.self, forKey: .coverDetail)
		trackPrice = try container.decodeIfPresent(Double.self, forKey: .trackPrice)
		genre = try container.decode(String.self, forKey: .genre)
		trackTimeMillis = try container.decodeIfPresent(Double.self, forKey: .trackTimeMillis)
		previewUrl = try container.decodeIfPresent(URL.self, forKey: .previewUrl)
		currency = try container.decode(CurrencyUnit.self, forKey: .currency)
	}
	
	init(artistName: String,
		 trackName: String,
		 collectionName: String,
		 releaseDate: Date,
		 thumbnail: URL,
		 coverDetail: URL,
		 trackPrice: Double,
		 genre: String,
		 trackTimeMillis: Double,
		 previewUrl: URL,
		 currency: CurrencyUnit) {
		self.artistName = artistName
		self.trackName = trackName
		self.collectionName = collectionName
		self.releaseDate = releaseDate
		self.thumbnail = thumbnail
		self.coverDetail = coverDetail
		self.trackPrice = trackPrice
		self.genre = genre
		self.trackTimeMillis = trackTimeMillis
		self.previewUrl = previewUrl
		self.currency = currency
	}
}
