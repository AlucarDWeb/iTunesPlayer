//
//  MusicListCellViewModel.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 23/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import UIKit

protocol MusicListCellViewModelProtocol: ViewModel {
	init(with song: Song)
	
	var title: String { get }
	var artist: String { get }
	var albumTitle: String { get }
	var releaseDate: String { get }
	var songLength: String { get }
	var genre: String { get }
	var price: String { get }
	var coverImageURL: URL { get }
}

struct MusicListCellViewModel: MusicListCellViewModelProtocol {
	private let song: Song
	
	init(with song: Song) {
		self.song = song
	}
	
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
		return song.trackPrice?.description ?? ""
	}
	
	var coverImageURL: URL {
		return song.coverDetail
	}
}

