//
//  MussicListViewModel.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 20/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

final class MusicListViewModel: ViewModel {
	
	private let datasource: Datasource
	
	init(with dataSource: Datasource) {
		self.datasource = dataSource
	}
}
