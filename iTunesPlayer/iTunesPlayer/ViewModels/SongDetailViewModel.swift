//
//  SongDetailViewModel.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 24/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

protocol SongDetailViewModelProtocol {
	var dataset: [Song] { get }
	var selectedSong: Song { get }
	
	init (with dataset: [Song], and selectedSong: Song)
}

final class SongDetailViewModel: SongDetailViewModelProtocol {
	let dataset: [Song]
	let selectedSong: Song
	
	init(with dataset: [Song], and selectedSong: Song) {
		self.dataset = dataset
		self.selectedSong = selectedSong
	}
}
