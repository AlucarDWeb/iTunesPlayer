//
//  MusicListViewModelTests.swift
//  iTunesPlayerTests
//
//  Created by Ferdinando Furci on 30/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import XCTest
@testable import iTunesPlayer

final class MusicListViewModelTests: XCTestCase {
	private var musicListViewModel: MusicListViewModelProtocol!
	private lazy var mocksProvider: MocksProvider = MocksProvider()
	private var datasource: MusicListDatasourceProtocol!
	
	override func setUp() {
		datasource = mocksProvider.musicListDatasource()
		musicListViewModel = MusicListViewModel(with: datasource)
		musicListViewModel.getMusicData(with: "test")
	}
	
	override func tearDown() {
		musicListViewModel = nil
		datasource = nil
	}
	
	func testSortDatasetByLengthSuccessfully() {
		musicListViewModel.sortDataset(sortingOption: .length)
		XCTAssertTrue(musicListViewModel.dataset[0].artistName == "Metallica")
	}
	
	func testSortDatasetByGenreSuccessfully() {
		musicListViewModel.sortDataset(sortingOption: .genre)
		XCTAssertTrue(musicListViewModel.dataset[0].artistName == "Metallica")
	}
	
	func testSortDatasetByPriceSuccessfully() {
		musicListViewModel.sortDataset(sortingOption: .price)
		XCTAssertTrue(musicListViewModel.dataset[0].artistName == "Nirvana")
	}
}
