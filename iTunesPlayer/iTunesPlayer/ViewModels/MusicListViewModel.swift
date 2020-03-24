//
//  MussicListViewModel.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 20/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation


enum SortingOptions: Int {
	case length = 0
	case genre = 1
	case price = 2
}

protocol MusicListViewModelProtocol: ViewModel {
	var dataset: [Song] { get }
	
	init(with dataSource: Datasource)
	
	func getMusicData(with parameters: String)
	func sortDataset(sortingOption: SortingOptions)
}

protocol MusicListViewModelDelegate: class {
	func MusicListViewModel(didUpdate songs: [Song])
    func MusicListViewModel(shouldShowActivityIndicator: Bool)
    func MusicListViewModel(willShow error: Error?)
}

final class MusicListViewModel: MusicListViewModelProtocol {
	
	private (set)var dataset: [Song] = []
	private let datasource: Datasource
	
	weak var delegate: MusicListViewModelDelegate?
	
	init(with dataSource: Datasource) {
		self.datasource = dataSource
	}
	
	func getMusicData(with parameters: String) {
		guard !parameters.isEmpty else { return }
		
		self.delegate?.MusicListViewModel(shouldShowActivityIndicator: true)
		datasource.fetch(with: parameters) { [weak self] (result: Result<Songlist, Error>) in
			guard let self = self else { return }
			
			self.delegate?.MusicListViewModel(shouldShowActivityIndicator: false)
			
			switch result {
			case .success(let songs):
				self.delegate?.MusicListViewModel(willShow: nil)
				self.dataset = songs.results
				self.delegate?.MusicListViewModel(didUpdate: songs.results)
			case .failure(let error):
				self.delegate?.MusicListViewModel(willShow: error)
			}
		}
	}
	
	func sortDataset(sortingOption: SortingOptions) {
		switch sortingOption {
		case .length:
			dataset.sort { $0.duration.localizedStandardCompare($1.duration) == .orderedAscending }
			delegate?.MusicListViewModel(didUpdate: dataset)
		case .genre:
			dataset.sort { $0.genre < $1.genre }
			delegate?.MusicListViewModel(didUpdate: dataset)
		case .price:
			dataset.sort { $0.trackPrice ?? 0 < $1.trackPrice ?? 0 }
			delegate?.MusicListViewModel(didUpdate: dataset)
		}
	}
}
