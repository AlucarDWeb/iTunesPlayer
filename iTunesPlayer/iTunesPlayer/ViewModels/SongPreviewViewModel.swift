//
//  SongDetailViewModel.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 24/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

enum SongSwitchStatus {
	case forward
	case backward
}

protocol SongPreviewViewModelProtocol {
	var playlist: [Song] { get }
	var selectedSong: Song { get }
	
	init (with dataset: [Song], selectedIndex: Int, and datasource: SongPreviewDatasourceProtocol)
	
	func play(newSong: Bool)
	func pause()
	func switchSong(status: SongSwitchStatus)
}

protocol SongPreviewViewModelDelegate: class {
	func songPreviewViewModel(updatedSong: Song)
	func songPreviewViewModel(preview URL: URL)
	func songPreviewViewModel(willPausePlaying: Bool)
	func songPreviewViewModel(willShow error: Error?)
}

final class SongPreviewViewModel: SongPreviewViewModelProtocol {
	let playlist: [Song]
	var selectedSong: Song
	
	weak var delegate: SongPreviewViewModelDelegate?
	
	private let datasource: SongPreviewDatasourceProtocol
	private var selectedIndex: Int
	
	init(with playlist: [Song], selectedIndex: Int, and datasource: SongPreviewDatasourceProtocol) {
		self.playlist = playlist
		self.selectedIndex = selectedIndex
		self.datasource = datasource
		self.selectedSong = playlist[selectedIndex]
	}
	
	func play(newSong: Bool) {
		if !newSong {
			guard let destinationURL = datasource.songDownloadDestinationURL else { return }
			
			delegate?.songPreviewViewModel(preview: destinationURL)
			return
		}
		
		guard let localPreviewURL = selectedSong.previewUrl else { return }
		
		datasource.download(from: localPreviewURL, to: datasource.songDownloadDestinationURL) { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success(let localPreviewURL):
				self.delegate?.songPreviewViewModel(preview: localPreviewURL)
			case .failure(let error):
				self.delegate?.songPreviewViewModel(willShow: error)
			}
		}
	}
	
	func pause() {
		delegate?.songPreviewViewModel(willPausePlaying: true)
	}
	
	func switchSong(status: SongSwitchStatus) {
		switch status {
		case .forward:
			let nextIndex = selectedIndex + 1
			guard playlist.indices.contains(nextIndex) else { return }
			
			selectedIndex = nextIndex
			selectedSong = playlist[nextIndex]
			delegate?.songPreviewViewModel(updatedSong: selectedSong)
		case .backward:
			let nextIndex = selectedIndex - 1
			guard playlist.indices.contains(nextIndex) else { return }
			
			selectedIndex = nextIndex
			selectedSong = playlist[nextIndex]
			delegate?.songPreviewViewModel(updatedSong: selectedSong)
		}
	}
}