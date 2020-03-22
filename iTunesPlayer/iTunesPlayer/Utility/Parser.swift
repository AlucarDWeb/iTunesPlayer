//
//  Parser.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 21/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation
final class Parser {
	private let encoder = JSONEncoder()
	private let decoder = JSONDecoder()
	
	init() {
		encoder.outputFormatting = .prettyPrinted
		let formatter = DateFormatter.defaultFormatterWithSeconds
		encoder.dateEncodingStrategy = .formatted(formatter)
		decoder.dateDecodingStrategy = .formatted(formatter)
	}
	
	func encode<T: Encodable>(_ object: T?) -> Data? {
		return try? encoder.encode(object)
	}
	
	func decode<T: Decodable>(_ data: Data) throws -> T {
		return try decoder.decode(T.self, from: data)
	}
}

private extension DateFormatter {
	static let defaultFormatterWithSeconds: DateFormatter = {
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone(identifier: "UTC")
		formatter.locale = Locale(identifier: "en_US")
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
		return formatter
	}()
}
