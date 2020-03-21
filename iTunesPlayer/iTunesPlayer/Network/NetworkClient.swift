//
//  NetworkClient.swift
//  iTunesPlayer
//
//  Created by Ferdinando Furci on 20/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import Foundation

protocol NetworkClientProtocol {
	init(session: URLSession)
	
	func perform<T: Decodable>(requestType: NetworkTaskType,
							   completionHandler: @escaping (Result<T, Error>) -> Void)
}

final class NetworkClient: NetworkClientProtocol {
	
	private let session: URLSession
	
	init(session: URLSession) {
		self.session = session
	}
	
	func perform<T: Decodable>(requestType: NetworkTaskType,
							   completionHandler: @escaping (Result<T, Error>) -> Void)  {
		let task = requestType.task()
		let baseURL = task.baseURL
		let method = task.method
		
		guard
			let url = URL(string: baseURL),
			let completeURL = url.appending(queryItems: task.queryItems) else {
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
				let codableData = try JSONDecoder().decode(T.self, from: data)
				completionHandler(.success(codableData))
			} catch let error {
				completionHandler(.failure(error))
			}
		}
		
		dataTask.resume()
	}
}
