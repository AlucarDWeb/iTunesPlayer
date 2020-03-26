//
//  SongDetailViewController.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 24/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import UIKit
import SDWebImage
import AVFoundation

protocol SongPreviewViewControllerDelegate: class {
	func songPreviewViewController(_ controller: UIViewController, share items: [Any])
}

// MARK: - SongPreviewViewController
final class SongPreviewViewController: UIViewController, BaseView {
	
	private let viewModel: SongPreviewViewModelProtocol
	private var audioPlayer: AVAudioPlayer?
	
	weak var delegate: SongPreviewViewControllerDelegate?
	
	@IBOutlet private weak var genreLabel: UILabel!
	@IBOutlet private weak var artistNameLabel: UILabel!
	@IBOutlet private weak var albumNameLabel: UILabel!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var playPauseButton: UIButton!
	@IBOutlet private weak var coverImageVIew: UIImageView!
	
	required init(with viewModel: SongPreviewViewModelProtocol) {
		self.viewModel = viewModel
		
		super.init(nibName: Self.nameOfClass, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: ViewImages.shareImage,
															style: .plain,
															target: self,
															action: #selector(share(sender:)))
		setupViews(with: viewModel.selectedSong)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationController?.navigationBar.prefersLargeTitles = false
	}
	
	@IBAction private func previousSong(_ sender: Any) {
		viewModel.switchSong(status: .backward)
	}
	
	@IBAction private func playOrPause(_ sender: Any) {
		if let audioplayer = audioPlayer {
			guard audioplayer.isPlaying else {
				viewModel.play(newSong: false)
				return
			}
			
			viewModel.pause()
			return
		}
		
		viewModel.play(newSong: true)
	}
	
	@IBAction private func nextSong(_ sender: Any) {
		viewModel.switchSong(status: .forward)
	}
	
	@objc func share(sender: UIView) {
		let textToShare = "\(viewModel.selectedSong.trackName ?? "") from \(viewModel.selectedSong.artistName)"
		guard let previewURL = viewModel.selectedSong.previewUrl else { return }
		
		delegate?.songPreviewViewController(self, share: [textToShare, previewURL])
	}
}

private extension SongPreviewViewController {
	func setupViews(with selectedSong: Song) {
		titleLabel.text = selectedSong.trackName
		albumNameLabel.text = selectedSong.collectionName
		artistNameLabel.text = selectedSong.artistName
		genreLabel.text = selectedSong.genre
		coverImageVIew.sd_setImage(with: selectedSong.coverDetail, completed: nil)
	}
	
	func setPlayButtonImage(image: UIImage?) {
		DispatchQueue.main.async {
			self.playPauseButton.setImage(image, for: .normal)
		}
	}
	
	struct ViewImages {
		static let shareImage = UIImage(systemName: "square.and.arrow.up")
		static let playImage = UIImage(systemName: "play.fill")
		static let pauseImage = UIImage(systemName: "pause.fill")
	}
}

extension SongPreviewViewController: SongPreviewViewModelDelegate {
	func songPreviewViewModel(updatedSong: Song) {
		audioPlayer = nil
		setupViews(with: updatedSong)
		setPlayButtonImage(image: ViewImages.playImage)
	}
	
	func songPreviewViewModel(willPausePlaying: Bool) {
		guard willPausePlaying else { return }
		
		setPlayButtonImage(image: ViewImages.playImage)
		audioPlayer?.pause()
	}
	
	func songPreviewViewModel(preview URL: URL) {
		setPlayButtonImage(image: ViewImages.pauseImage)
		
		do {
			audioPlayer = try AVAudioPlayer(contentsOf: URL)
			audioPlayer?.prepareToPlay()
			audioPlayer?.play()
		} catch let error {
			print(error.localizedDescription)
		}
	}
	
	func songPreviewViewModel(willShow error: Error?) {
		DispatchQueue.main.async {
			guard let error = error else { return }
			
			self.showErrorPopup(with: error)
		}
	}
}

