//
//  Coordinator.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 20/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import UIKit

// MARK: - Coordinator
protocol Coordinator {
	var navigationController: UINavigationController { get }
	
	init(with navigationController: UINavigationController)
	
	func start()
}
