//
//  NSObject.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 20/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

// MARK: - NSObject
extension NSObject {
	class var nameOfClass: String {
		return NSStringFromClass(self).components(separatedBy: ".").last!
	}
}
