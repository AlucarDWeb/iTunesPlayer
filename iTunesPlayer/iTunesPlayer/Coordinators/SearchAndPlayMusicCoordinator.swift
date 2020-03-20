//
//  SearchAndPlayMusicCoordinator.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 20/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import UIKit

// MARK: - SearchAndPlayMusicCoordinator
final class SearchAndPlayMusicCoordinator: Coordinator {
	
	let navigationController: UINavigationController
	
	init(with navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		let networkClient = ITunesSearchNetworkClient()
		let datasource = MusicDatasource(with: networkClient)
		let viewModel = MusicListViewModel(with: datasource)
		let viewController = MusicListViewController(with: viewModel)
		navigationController.pushViewController(viewController, animated: true)
	}
}