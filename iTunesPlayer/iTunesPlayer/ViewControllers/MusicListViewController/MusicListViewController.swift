//
//  MusicListViewController.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 20/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import UIKit

// MARK: - MusicListViewControllerDelegate
protocol MusicListViewControllerDelegate: class {
	func musicListViewController(didSelectElementAt index: Int, from dataset: [Song])
}

// MARK: - MusicListViewController
final class MusicListViewController: UIViewController, BaseView {
	
	// MARK: Private properties
	private let viewModel: MusicListViewModelProtocol
	private let searchController = UISearchController(searchResultsController: nil)
	
	private struct CollectionViewConfigurationData {
		static let cellIdentifier = "musicCell"
		static let numberOfSections = 1
		static let itemFractionalWidth: CGFloat = 1
		static let itemEstimatedHeight: CGFloat = 350
		static let contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
		static let interGroupSpacing: CGFloat = 10
	}
	
	// MARK: IBOutlets
	@IBOutlet private weak var noResultsView: UIView!
	@IBOutlet private weak var collectionView: UICollectionView!
	
	weak var delegate: MusicListViewControllerDelegate?
	
	// MARK: Initialization
	required init(with viewModel: MusicListViewModelProtocol) {
		self.viewModel = viewModel
		
		super.init(nibName: Self.nameOfClass, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: View controller lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupSearchController()
		setupViews()
		setupCollectionView()
		viewModel.getMusicData(with: "Rock")
	}
	
	// MARK: IBActions
	@IBAction private func filterAction(_ sender: UISegmentedControl) {
		viewModel.sortDataset(sortingOption: SortingOptions(rawValue: sender.selectedSegmentIndex) ?? SortingOptions.length)
	}
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource
extension MusicListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return CollectionViewConfigurationData.numberOfSections
	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		collectionView?.collectionViewLayout.invalidateLayout()
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.dataset.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewConfigurationData.cellIdentifier,
															for: indexPath) as? MusicListCollectionViewCell else {
			print("Cannot dequeue MusicListCollectionViewCell. An error occurred")
			return UICollectionViewCell()
		}
		
		let cellViewModel = MusicListCellViewModel(with: viewModel.dataset[indexPath.row])
		cell.viewModel = cellViewModel
		cell.configure()
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		delegate?.musicListViewController(didSelectElementAt: indexPath.row, from: viewModel.dataset)
	}
}

// MARK: - UISearchBarDelegate
extension MusicListViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let searchText = searchController.searchBar.text else { return }
		
		viewModel.getMusicData(with: searchText)
	}
}

// MARK: - MusicListViewModelDelegate
extension MusicListViewController: MusicListViewModelDelegate {
	func MusicListViewModel(didUpdate songs: [Song]) {
		DispatchQueue.main.async {
			self.noResultsView.isHidden = !songs.isEmpty
			self.collectionView.reloadData()
		}
	}
	
	func MusicListViewModel(shouldShowActivityIndicator: Bool) {
		DispatchQueue.main.async {
			shouldShowActivityIndicator == true ? self.showLoadingIndicator() : self.hideLoadingIndicator()
		}
	}
	
	func MusicListViewModel(willShow error: Error?) {
		DispatchQueue.main.async {
			guard let error = error else { return }
			self.showErrorPopup(with: error)
		}
	}
}

// MARK: - Private functions
private extension MusicListViewController {
	func setupViews() {
		self.title = NSLocalizedString("iTunes Music search", comment: "list title")
	}
	
	func setupSearchController() {
		searchController.searchBar.delegate = self
		searchController.definesPresentationContext = true
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.searchBar.placeholder =  NSLocalizedString("Search by artists, songs, albums, genres", comment: "search bar placeholder")
		navigationItem.searchController = searchController
		definesPresentationContext = true
	}
	
	func setupCollectionView() {
		let size = NSCollectionLayoutSize(
			widthDimension: NSCollectionLayoutDimension.fractionalWidth(CollectionViewConfigurationData.itemFractionalWidth),
			heightDimension: NSCollectionLayoutDimension.estimated(CollectionViewConfigurationData.itemEstimatedHeight)
		)
		
		let item = NSCollectionLayoutItem(layoutSize: size)
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
		
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets = CollectionViewConfigurationData.contentInsets
		section.interGroupSpacing = CollectionViewConfigurationData.interGroupSpacing
		
		let layout = UICollectionViewCompositionalLayout(section: section)
		self.collectionView.register(UINib(nibName: MusicListCollectionViewCell.nameOfClass, bundle: nil),
									 forCellWithReuseIdentifier: CollectionViewConfigurationData.cellIdentifier)
		self.collectionView.delegate = self
		self.collectionView.dataSource = self
		self.collectionView.collectionViewLayout = layout
	}
}
