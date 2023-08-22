//
//  NetworkManager.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 09.07.2023.
//

import Foundation
import Combine



class NetworkingManager {
	
	enum NetworkingError: LocalizedError {
		case badURLResponse(url: URL)
		case unknown
		
		var errorDescription: String? {
			let date = Date()
			let dateFormatter = DateFormatter()
			 
			dateFormatter.dateFormat = "HH:mm:ss"
			 
			let time = dateFormatter.string(from: date)
			
			switch self {
			case .badURLResponse(url: let url): return "[\(time)]NetworkingManager: Bad response from url: \(url)"
			case .unknown: return "[\(time)]NetworkingManager: Unknown error occured"
			}
		}
	}

	static func download(url: URL) -> AnyPublisher<Data, Error> {
		return URLSession.shared.dataTaskPublisher(for: url)
			.receive(on: DispatchQueue.main)
			.subscribe(on: DispatchQueue.global(qos: .default))
			.tryMap(handleUrlResponse)
			.eraseToAnyPublisher()
	}
	
	static func handleUrlResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
		guard let response = output.response as? HTTPURLResponse,
			  (200...299).contains(response.statusCode) else {
			throw NetworkingError.badURLResponse(url: output.response.url ?? URL(string: "<nil>")!)
		}
		return output.data
	}
	
	static func handleCompetion(completion: Subscribers.Completion<Error>) {
		switch completion {
		case .finished:
			break
		case .failure(let error):
			print("handleCompletions: \(error.localizedDescription)")
		}
	}
	
	static let decoder: JSONDecoder = {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		let formatter = DateFormatter()
		formatter.calendar = Calendar(identifier: .iso8601)
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
		decoder.dateDecodingStrategy = .formatted(formatter)
		return decoder
	}()
}
