//
//  AppCoordinator.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 20/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import UIKit

// MARK: - AppCoordinator
final class AppCoordinator: Coordinator {
	let navigationController: UINavigationController
	var searchAndPlayMusicCoordinator: SearchAndPlayMusicCoordinator?
	
	init(with navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		searchAndPlayMusicCoordinator = SearchAndPlayMusicCoordinator(with: navigationController)
		searchAndPlayMusicCoordinator?.start()
	}
}

