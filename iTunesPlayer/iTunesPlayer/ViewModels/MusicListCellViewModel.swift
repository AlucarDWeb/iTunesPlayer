//
//  MusicListCellViewModel.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 23/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import UIKit

// MARK: - MusicListCellViewModel
struct MusicListCellViewModel: SongViewModel {
	private let song: Song
	
	// MARK: Initialization
	init(with song: Song) {
		self.song = song
	}
	
	// MARK: Public properties
	var title: String {
		return song.trackName ?? ""
	}
	
	var artist: String {
		return song.artistName
	}
	
	var albumTitle: String {
		return song.collectionName ?? ""
	}
	
	var releaseDate: String {
		let calendar = Calendar.current
		let components = calendar.dateComponents([.year], from: song.releaseDate)
		let year = components.year ?? 0
		return "\(year)"
	}
	
	var songLength: String {
		return song.duration
	}
	
	var genre: String {
		return song.genre
	}
	
	var price: String {
		let price = song.trackPrice?.description ?? ""
		return "\(price)\(currency)"
	}
	
	var coverImageURL: URL {
		return song.coverDetail
	}
	
	private var currency: String {
		switch song.currency {
		case .USD:
			return "$"
		}
	}
}

