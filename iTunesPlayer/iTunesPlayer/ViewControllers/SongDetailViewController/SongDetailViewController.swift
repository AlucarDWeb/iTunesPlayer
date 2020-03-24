//
//  SongDetailViewController.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 24/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import UIKit
import WebKit

// MARK: - SongDetailViewController
final class SongDetailViewController: UIViewController, BaseView {
	
	private let viewModel: SongDetailViewModelProtocol
	
	required init(with viewModel: SongDetailViewModelProtocol) {
		self.viewModel = viewModel
		
		super.init(nibName: Self.nameOfClass, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.prefersLargeTitles = false
	}
}

