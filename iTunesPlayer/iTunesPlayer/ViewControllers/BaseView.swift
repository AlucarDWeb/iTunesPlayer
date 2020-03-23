//
//  BaseView.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 20/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import UIKit

protocol BaseView {}

extension BaseView where Self: UIViewController {
	
	func showLoadingIndicator() {
		hideLoadingIndicator()
		
		let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
		activityIndicator.center = view.center
		activityIndicator.hidesWhenStopped = true
		activityIndicator.startAnimating()
		
		view.addSubview(activityIndicator)
		view.isUserInteractionEnabled = false
	}
	
	func hideLoadingIndicator() {
		view.subviews.forEach {
			if $0 is UIActivityIndicatorView {
				$0.removeFromSuperview()
			}
		}
		view.isUserInteractionEnabled = true
	}
	
	func showErrorPopup(with error: Error) {
		let alert = UIAlertController(title: NSLocalizedString("Whoops...", comment: "Network error title"), message: NSLocalizedString(error.localizedDescription, comment: "Network error message"), preferredStyle: .alert)
		let action = UIAlertAction(title: NSLocalizedString("OK", comment: "Confirm Button"), style: .default, handler: nil)
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
}
