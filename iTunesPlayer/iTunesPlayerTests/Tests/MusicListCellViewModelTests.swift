//
//  MusicListCellViewModelTests.swift
//  iTunesPlayerTests
//
//  Created by Ferdinando Furci on 30/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import XCTest
@testable import iTunesPlayer

final class MusicListCellViewModelTests: XCTestCase {
	
	private lazy var mockedSong = MocksProvider().mockedSong()
	private var viewModel: MusicListCellViewModel!

    override func setUp() {
		viewModel = MusicListCellViewModel(with: mockedSong)
	}

    override func tearDown() {
		viewModel = nil
	}
	
	func testArtistNameSetProperly() {
		XCTAssertNotNil(viewModel.artist)
	}
	
	func testReleaseDateSetProperly() {
		XCTAssertNotNil(viewModel.releaseDate)
	}
	
	func testCoverDetailURLSetProperly() {
		XCTAssertNotNil(viewModel.coverImageURL)
	}
	
	func testGenreSetProperly() {
		XCTAssertNotNil(viewModel.genre)
	}
	
	func testPriceSetProperly() {
		XCTAssertNotNil(viewModel.price)
	}
	
	func testSongLengthSetProperly() {
		XCTAssertNotNil(viewModel.songLength)
	}
}
