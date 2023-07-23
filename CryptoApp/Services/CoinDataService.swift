//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 02.07.2023.
//

import Foundation
import Combine

class CoinDataService {
	@Published var allCoins: [CoinModel] = []
	
//	var cancellables = Set<AnyCancellable>()
	var coinSubscription: AnyCancellable?
	
	
	
	init() {
		getCoins()
	}
	
	private func getCoins() {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "api.coingecko.com"
		components.path = "/api/v3/coins/markets"
		components.queryItems = [
				URLQueryItem(name: "vs_currency", 				value: "usd"),
				URLQueryItem(name: "order", 					value: "market_cap_desc"),
				URLQueryItem(name: "per_page", 					value: "250"),
				URLQueryItem(name: "page", 						value: "1"),
				URLQueryItem(name: "sparkline", 				value: "true"),
				URLQueryItem(name: "price_change_percentage", 	value: "24h")
			]
		guard let url = components.url
//				URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
		else { return }
		
		coinSubscription = NetworkingManager.download(url: url)
			.decode(type: [CoinModel].self, decoder: NetworkingManager.decoder)
			.sink(receiveCompletion: NetworkingManager.handleCompetion, receiveValue: { [weak self] returnedCoins in
				self?.allCoins = returnedCoins
				self?.coinSubscription?.cancel()
			})

	}
}
