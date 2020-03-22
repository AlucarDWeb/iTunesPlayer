//
//  MusicListViewController.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 20/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import UIKit

final class MusicListViewController: UIViewController, BaseView {
	
	private let viewModel: MusicListViewModelProtocol
	
	required init(with viewModel: MusicListViewModelProtocol) {
		self.viewModel = viewModel
		
		super.init(nibName: Self.nameOfClass, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel.getMusicData()
		
		// Do any additional setup after loading the view.
	}
}
