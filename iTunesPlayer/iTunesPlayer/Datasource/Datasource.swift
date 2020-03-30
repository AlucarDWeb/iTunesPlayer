//
//  Datasource.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 20/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

// MARK: - Datasource
protocol Datasource {
	init (with networkClient: NetworkClientProtocol)
}
