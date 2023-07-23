//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 23.07.2023.
//

import Foundation
import Combine

class MarketDataService {
	@Published var marketData: MarketDataModel? = nil
	
	var marketDataSubscription: AnyCancellable?
	
	init() {
		getCoins()
	}
	
	private func getCoins() {
		var components = URLComponents()
		components.scheme = "https"
		components.host = "api.coingecko.com"
		components.path = "/api/v3/global"
		guard let url = components.url else { return }
		
		marketDataSubscription = NetworkingManager.download(url: url)
			.decode(type: GlobalData.self, decoder: NetworkingManager.decoder)
			.sink(receiveCompletion: NetworkingManager.handleCompetion, receiveValue: { [weak self] returnedData in
				self?.marketData = returnedData.data
				self?.marketDataSubscription?.cancel()
			})
	}
}
