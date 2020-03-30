//
//  SongDetailViewModel.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 24/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

// MARK: - SongSwitchStatus
enum SongSwitchStatus {
	case forward
	case backward
}

// MARK: - SongPreviewViewModelProtocol
protocol SongPreviewViewModelProtocol {
	var playlist: [Song] { get }
	var selectedSong: Song { get }
	var shareData: [Any] { get }
	
	init (with dataset: [Song], selectedIndex: Int, and datasource: SongPreviewDatasourceProtocol)
	
	func play()
	func downloadAndPlay()
	func pause()
	func switchSong(status: SongSwitchStatus)
}

// MARK: - SongPreviewViewModelDelegate
protocol SongPreviewViewModelDelegate: class {
	func songPreviewViewModel(updatedSong: Song)
	func songPreviewViewModel(preview URL: URL)
	func songPreviewViewModel(willPausePlaying: Bool)
	func songPreviewViewModel(willShow error: Error?)
}

// MARK: - SongPreviewViewModel
final class SongPreviewViewModel: SongPreviewViewModelProtocol {
	
	// MARK: Private properties
	private let datasource: SongPreviewDatasourceProtocol
	private var selectedIndex: Int
	
	// MARK: Public properties
	let playlist: [Song]
	var selectedSong: Song
	
	weak var delegate: SongPreviewViewModelDelegate?
	
	var shareData: [Any] {
		let shareText = "\(selectedSong.trackName ?? "") from \(selectedSong.artistName)"
		return [shareText, selectedSong.previewUrl as Any].compactMap { $0 }
	}
	
	// MARK: Initialization
	init(with playlist: [Song], selectedIndex: Int, and datasource: SongPreviewDatasourceProtocol) {
		self.playlist = playlist
		self.selectedIndex = selectedIndex
		self.datasource = datasource
		self.selectedSong = playlist[selectedIndex]
	}
	
	// MARK: Protocol functions
	func downloadAndPlay() {
		guard let previewURL = selectedSong.previewUrl else { return }
		
		datasource.download(from: previewURL, to: datasource.songDownloadDestinationURL) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let localPreviewURL):
				self.delegate?.songPreviewViewModel(preview: localPreviewURL)
			case .failure(let error):
				self.delegate?.songPreviewViewModel(willShow: error)
			}
		}
	}
	
	func play() {
		guard let destinationURL = datasource.songDownloadDestinationURL else { return }
		delegate?.songPreviewViewModel(preview: destinationURL)
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
