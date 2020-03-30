//
//  SongPreviewViewModelTests.swift
//  iTunesPlayerTests
//
//  Created by Ferdinando Furci on 30/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import XCTest
@testable import iTunesPlayer

final class SongPreviewViewModelTests: XCTestCase {
	private lazy var mocksProvider: MocksProvider = MocksProvider()
	private var songPreviewViewModel: SongPreviewViewModel!
	private var datasource: SongPreviewDatasourceProtocol!
	private var delegate: SongPreviewViewModelDelegateMock!
	
	override func setUp() {
		datasource = mocksProvider.songPreviewDatasource()
		delegate = SongPreviewViewModelDelegateMock()
		songPreviewViewModel = SongPreviewViewModel(with: mocksProvider.mockedDataset(), selectedIndex: 0, and: datasource)
		songPreviewViewModel.delegate = delegate
	}
	
	override func tearDown() {
		datasource = nil
		songPreviewViewModel = nil
		delegate = nil
	}
	
	func testShareDataNotNil() {
		XCTAssertNotNil(songPreviewViewModel.shareData)
	}
	
	func testPlayActionWithNewSongActivatedSuccessfully() {
		(datasource as? SongPreviewDatasourceMock)?.fileDownloadedSuccessfully = true
		songPreviewViewModel.downloadAndPlay()
		XCTAssertTrue(delegate.previewURLCalled)
	}
	
	func testPlayActionWithNewSongNotActivatedSuccessfully() {
		(datasource as? SongPreviewDatasourceMock)?.fileDownloadedSuccessfully = false
		songPreviewViewModel.downloadAndPlay()
		XCTAssertTrue(delegate.showErrorCalled)
	}
	
	func testPlayActionWithAlreadyDownloadedSongActivatedSuccessfully() {
		songPreviewViewModel.play()
		XCTAssertTrue(delegate.previewURLCalled)
	}
	
	func testPauseActionActivatedSuccessfully() {
		songPreviewViewModel.pause()
		XCTAssertTrue(delegate.pausePlayingCalled)
	}
	
	func testSwitchSongForwardSuccessfully() {
		songPreviewViewModel.switchSong(status: .forward)
		XCTAssertTrue(delegate.updatedSongCalled)
	}
	
	func testSwitchSongBackwardSuccessfully() {
		let viewModel = SongPreviewViewModel(with: mocksProvider.mockedDataset(), selectedIndex: 1, and: datasource)
		viewModel.delegate = delegate
		viewModel.switchSong(status: .backward)
		XCTAssertTrue(delegate.updatedSongCalled)
	}
	
	func testSwitchSongForwardEndOfPlaylistSuccessfully() {
		let viewModel = SongPreviewViewModel(with: mocksProvider.mockedDataset(), selectedIndex: 2, and: datasource)
		viewModel.delegate = delegate
		viewModel.switchSong(status: .forward)
		XCTAssertFalse(delegate.updatedSongCalled)
	}
	
	func testSwitchSongBackwardEndOfPlaylistSuccessfully() {
		songPreviewViewModel.switchSong(status: .backward)
		XCTAssertFalse(delegate.updatedSongCalled)
	}
}

final class SongPreviewViewModelDelegateMock: SongPreviewViewModelDelegate {
	var updatedSongCalled = false
	var previewURLCalled = false
	var pausePlayingCalled = false
	var showErrorCalled = false
	
	func songPreviewViewModel(updatedSong: Song) {
		updatedSongCalled = true
	}
	
	func songPreviewViewModel(preview URL: URL) {
		previewURLCalled = true
	}
	
	func songPreviewViewModel(willPausePlaying: Bool) {
		pausePlayingCalled = true
	}
	
	func songPreviewViewModel(willShow error: Error?) {
		showErrorCalled = true
	}
}
