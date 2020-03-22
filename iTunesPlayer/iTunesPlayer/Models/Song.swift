//
//  Song.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 21/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

struct Songlist: Decodable {
	let results: [Song]
}

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
	let previewUrl: URL
	
	var duration: String {
		return millisConvertionToMinutes(rawMillis: trackTimeMillis ?? 0)
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
		previewUrl = try container.decode(URL.self, forKey: .previewUrl)
	}
}

private extension Song {
	func millisConvertionToMinutes(rawMillis: Double) -> String {
		let date = Date(timeIntervalSince1970: rawMillis / 1000)
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone(identifier: "UTC")
		formatter.dateFormat = "HH:mm:ss"
		return formatter.string(from: date)
	}
}
