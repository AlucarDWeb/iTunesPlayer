//
//  Parser.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 21/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

// MARK: - Parser
protocol Parser {
	func decode<T: Decodable>(_ data: Data) throws -> T
	func encode<T: Encodable>(_ object: T?) -> Data?
}

// MARK: - CodableParser
final class CodableParser: Parser {
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
