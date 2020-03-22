//
//  MussicListViewModel.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 20/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

protocol MusicListViewModelProtocol: ViewModel {
	func getMusicData()
}

final class MusicListViewModel: MusicListViewModelProtocol {
	private let datasource: Datasource
	
	init(with dataSource: Datasource) {
		self.datasource = dataSource
	}
	
	func getMusicData() {
		datasource.fetch(with: "M") { (result: Result<Songlist, Error>) in
			switch result {
			case .success(let songs):
				print(songs.results)
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
}
