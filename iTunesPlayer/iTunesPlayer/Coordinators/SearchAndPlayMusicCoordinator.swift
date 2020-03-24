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
		let networkClient = NetworkClient(session: URLSession.shared)
		let musicDatasource = MusicDatasource(with: networkClient)
		let musicListviewModel = MusicListViewModel(with: musicDatasource)
		let musicListViewController = MusicListViewController(with: musicListviewModel)
		musicListviewModel.delegate = musicListViewController
		musicListViewController.delegate = self
		navigationController.pushViewController(musicListViewController, animated: true)
	}
}

extension SearchAndPlayMusicCoordinator: MusicListViewControllerDelegate {
	func musicListViewController(didSelect song: Song, from dataset: [Song]) {
		let songDetailViewModel = SongDetailViewModel(with: dataset, and: song)
		let songDetailViewController = SongDetailViewController(with: songDetailViewModel)
		navigationController.pushViewController(songDetailViewController, animated: true)
	}
}
