//
//  NetworkClientTests.swift
//  iTunesPlayerTests
//
//  Created by Ferdinando Furci on 27/03/2020.
//  Copyright © 2020 Ferdinando Furci. All rights reserved.
//

import XCTest
@testable import iTunesPlayer

final class NetworkClientTests: XCTestCase {
	private lazy var mocksProvider: MocksProvider = MocksProvider()
	private var networkClient: NetworkClient!
	
	override func setUp() {
		let configuration = URLSessionConfiguration.default
		configuration.protocolClasses = [MockedURLProtocol.self]
		let urlSession = URLSession.init(configuration: configuration)
		networkClient = NetworkClient(session: urlSession)
	}
	
	override func tearDown() {
		 networkClient = nil
    }
	
	func testGetMusicSuccess() {
		let apiURL = URL(string: "https://itunes.apple.com/search?")!
		let expectation = self.expectation(description: "Successfully fetched music")
		let jsonString = """
                              {\n \"resultCount\":1,\n \"results\": [\n{\"wrapperType\":\"track\", \"kind\":\"song\", \"artistId\":909253, \"collectionId\":1440857781, \"trackId\":1440857786, \"artistName\":\"Jack Johnson\", \"collectionName\":\"In Between Dreams (Bonus Track Version)\", \"trackName\":\"Better Together\", \"collectionCensoredName\":\"In Between Dreams (Bonus Track Version)\", \"trackCensoredName\":\"Better Together\", \"artistViewUrl\":\"https://music.apple.com/us/artist/jack-johnson/909253?uo=4\", \"collectionViewUrl\":\"https://music.apple.com/us/album/better-together/1440857781?i=1440857786&uo=4", \"trackViewUrl\":\"https://music.apple.com/us/album/better-together/1440857781?i=1440857786&uo=4", \n\"previewUrl\":\"https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview118/v4/94/25/9c/94259c23-84ee-129d-709c-577186cbe211/mzaf_5653537699505456197.plus.aac.p.m4a\", \"artworkUrl30\":\"https://is2-ssl.mzstatic.com/image/thumb/Music118/v4/24/46/97/24469731-f56f-29f6-67bd-53438f59ebcb/source/30x30bb.jpg\", \"artworkUrl60\":\"https://is2-ssl.mzstatic.com/image/thumb/Music118/v4/24/46/97/24469731-f56f-29f6-67bd-53438f59ebcb/source/60x60bb.jpg\", \"artworkUrl100\":\"https://is2-ssl.mzstatic.com/image/thumb/Music118/v4/24/46/97/24469731-f56f-29f6-67bd-53438f59ebcb/source/100x100bb.jpg\", \"collectionPrice\":6.99, \"trackPrice\":1.29, \"releaseDate\":\"2005-03-01T12:00:00Z\", \"collectionExplicitness\":\"notExplicit\", \"trackExplicitness\":\"notExplicit\", \"discCount\":1, \"discNumber\":1, \"trackCount\":15, \"trackNumber\":1, \"trackTimeMillis\":207679, \"country\":\"USA\", \"currency\":\"USD\", \"primaryGenreName\":\"Rock\", \"isStreamable\":true}]\n}
                              """
		let data = jsonString.data(using: .utf8)
		MockedURLProtocol.requestHandler = { request in
			let response = HTTPURLResponse(url: apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
			return (response, data)
		}
		
		networkClient.perform(requestType: .getMusic(parameters: "")) { (result: Result<Songlist, Error>) in
			switch result {
			case .success(_):
				expectation.fulfill()
			case .failure(_):
				XCTFail("Failure was not expected")
			}
		}
		wait(for: [expectation], timeout: 5.0)
	}
	
	func testGetMusicFailure() {
		let apiURL = URL(string: "https://itunes.apple.com/search?")!
		let expectation = self.expectation(description: "Failed to fetch music")
		MockedURLProtocol.requestHandler = { request in
			let response = HTTPURLResponse(url: apiURL, statusCode: 401, httpVersion: nil, headerFields: nil)!
			return (response, nil)
		}
		
		networkClient.perform(requestType: .getMusic(parameters: "")) { (result: Result<Songlist, Error>) in
			switch result {
			case .success(_):
				XCTFail("success was not expected")
			case .failure(_):
				expectation.fulfill()
			}
		}
		wait(for: [expectation], timeout: 5.0)
	}
	
	func testDownloadFileSuccess() {
		let url = URL(string: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview118/v4/94/25/9c/94259c23-84ee-129d-709c-577186cbe211/mzaf_5653537699505456197.plus.aac.p.m4a")!
		let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
		let destinationURL = documentsURL.appendingPathComponent("testSong.m4a")
		let expectation = self.expectation(description: "Successfully downloaded song file")
		MockedURLProtocol.requestHandler = { request in
			let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
			return (response, nil)
		}
		
		networkClient.download(from: url, to: destinationURL) { (result: Result<URL, Error>) in
			switch result {
			case .success(_):
				guard FileManager.default.fileExists(atPath: destinationURL.path) else {
					XCTFail("file has not been downloaded")
					return
				}
				
				expectation.fulfill()
				try! FileManager.default.removeItem(at: destinationURL)
			case .failure(_):
				XCTFail("failure was not expected")
			}
		}
		
		wait(for: [expectation], timeout: 5.0)
	}
}
