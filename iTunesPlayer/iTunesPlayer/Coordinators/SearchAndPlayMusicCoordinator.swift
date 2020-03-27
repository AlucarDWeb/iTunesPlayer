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
	
	// MARK: Initialization
	init(with navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	// MARK: Protocol functions
	func start() {
		let networkClient = NetworkClient(session: URLSession.shared)
		let musicDatasource = MusicListDatasource(with: networkClient)
		let musicListviewModel = MusicListViewModel(with: musicDatasource)
		let musicListViewController = MusicListViewController(with: musicListviewModel)
		musicListviewModel.delegate = musicListViewController
		musicListViewController.delegate = self
		navigationController.pushViewController(musicListViewController, animated: true)
	}
}

// MARK: - MusicListViewControllerDelegate
extension SearchAndPlayMusicCoordinator: MusicListViewControllerDelegate {
	func musicListViewController(didSelectElementAt index: Int, from dataset: [Song]) {
		let networkClient = NetworkClient(session: URLSession.shared)
		let songPreviewDatasource = SongPreviewDatasource(with: networkClient)
		let songPreviewViewModel = SongPreviewViewModel(with: dataset, selectedIndex: index, and: songPreviewDatasource)
		let songPreviewViewController = SongPreviewViewController(with: songPreviewViewModel)
		songPreviewViewController.delegate = self
		songPreviewViewModel.delegate = songPreviewViewController
		navigationController.pushViewController(songPreviewViewController, animated: true)
	}
}

// MARK: - SongPreviewViewControllerDelegate
extension SearchAndPlayMusicCoordinator: SongPreviewViewControllerDelegate {
	func songPreviewViewController(_ controller: UIViewController, share items: [Any]) {
		let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
		controller.present(activityViewController, animated: true, completion: nil)
	}
}
