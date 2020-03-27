//
//  ViewModel.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 20/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

// MARK: - SongViewModel
protocol SongViewModel {
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
