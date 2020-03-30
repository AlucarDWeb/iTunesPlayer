//
//  MusicListCollectionViewCell.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 23/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import UIKit
import SDWebImage

// MARK: - MusicListCollectionViewCell
final class MusicListCollectionViewCell: UICollectionViewCell {
	
	var viewModel: MusicListCellViewModel?
	
	// MARK: IBOutlets
	@IBOutlet private weak var releaseDateLabel: UILabel!
	@IBOutlet private weak var lengthLabel: UILabel!
	@IBOutlet private weak var priceLabel: UILabel!
	@IBOutlet private weak var genreLabel: UILabel!
	@IBOutlet private weak var artistLabel: UILabel!
	@IBOutlet private weak var albumNameLabel: UILabel!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var coverImageView: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
	
	func configure() {
		titleLabel.text = viewModel?.title
		albumNameLabel.text = viewModel?.albumTitle
		artistLabel.text = viewModel?.artist
		genreLabel.text = viewModel?.genre
		priceLabel.text = viewModel?.price
		lengthLabel.text = viewModel?.songLength
		releaseDateLabel.text = viewModel?.releaseDate
		coverImageView.sd_setImage(with: viewModel?.coverImageURL,
								   placeholderImage: UIImage(named: "placeholder.png"),
								   options: SDWebImageOptions.continueInBackground, completed: nil)
	}
}
