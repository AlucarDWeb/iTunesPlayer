//
//  NetworkClient.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 20/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

// MARK: - NetworkClientProtocol
protocol NetworkClientProtocol {
	init(session: URLSession)
	
	func perform<T: Decodable>(requestType: NetworkTaskType,
							   completionHandler: @escaping (Result<T, Error>) -> Void)
	func download(from URL: URL,
				  to destinationURL: URL?,
				  completionHandler: @escaping (Result<URL, Error>) -> Void)
}

// MARK: - NetworkClient
final class NetworkClient: NetworkClientProtocol {
	private let session: URLSession
	
	// MARK: Initialization
	init(session: URLSession) {
		self.session = session
	}
	
	// MARK: Protocol functions
	func perform<T: Decodable>(requestType: NetworkTaskType,
							   completionHandler: @escaping (Result<T, Error>) -> Void)  {
		let task = requestType.task()
		let baseURL = task.baseURL
		let method = task.method
		
		guard
			let url = URL(string: baseURL),
			let completeURL = url.appending(queryItems: task.queryItems ?? []) else {
				completionHandler(.failure(NetworkError.malformedURL))
				return
		}
		
		var request = URLRequest(url: completeURL)
		request.httpMethod = method.rawValue
		
		let dataTask = session.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(.failure(error))
				return
			}
			
			guard let httpResponse = response as? HTTPURLResponse else {
				completionHandler(.failure(NetworkError.invalidResponse))
				return
			}
			
			guard let data = data else {
				completionHandler(.failure(NetworkError.invalidData(statusCode: httpResponse.statusCode)))
				return
			}
			
			do {
				let codableData: T = try CodableParser().decode(data)
				completionHandler(.success(codableData))
			} catch let error {
				completionHandler(.failure(error))
			}
		}
		
		dataTask.resume()
	}
	
	func download(from URL: URL,
				  to destinationURL: URL?,
				  completionHandler: @escaping (Result<URL, Error>) -> Void) {
	
		guard let destinationURL = destinationURL else { return }

		let downloadTask = session.downloadTask(with: URL,completionHandler: { (data, response, error) -> Void in
			if let error = error {
				completionHandler(.failure(error))
				return
			}
			
			guard let httpResponse = response as? HTTPURLResponse else {
				completionHandler(.failure(NetworkError.invalidResponse))
				return
			}
			
			guard let data = data else {
				completionHandler(.failure(NetworkError.invalidData(statusCode: httpResponse.statusCode)))
				return
			}
			
			do {
				if FileManager.default.fileExists(atPath: destinationURL.path) {
					try FileManager.default.removeItem(at: destinationURL)
					try FileManager.default.copyItem(at: data, to: destinationURL)
					completionHandler(.success(destinationURL))
				} else {
					try FileManager.default.copyItem(at: data, to: destinationURL)
					completionHandler(.success(destinationURL))
				}
			} catch let error {
				completionHandler(.failure(error))
			}
		})
		
		downloadTask.resume()
	}
}
