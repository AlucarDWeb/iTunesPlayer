//
//  DateFormatterExtension.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 27/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

// MARK: - DateFormatter
extension DateFormatter {
	static let defaultFormatterWithSeconds: DateFormatter = {
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone(identifier: "UTC")
		formatter.locale = Locale(identifier: "en_US")
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
		return formatter
	}()
	
	static func millisecondsConvertionToMinutes(rawMillis: Double) -> String {
		let date = Date(timeIntervalSince1970: rawMillis / 1000)
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone(identifier: "UTC")
		formatter.dateFormat = "HH:mm:ss"
		return formatter.string(from: date)
	}
}
