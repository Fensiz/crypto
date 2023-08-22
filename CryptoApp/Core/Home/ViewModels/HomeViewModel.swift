//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 01.07.2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
	
	@Published var statistics: [StatisticModel] = []
	@Published var allCoins: [CoinModel] = []
	@Published var portfolioCoins: [CoinModel] = []
	
	@Published var searchText: String = ""
	
	private let coinDataService = CoinDataService()
	private let marketDataService = MarketDataService()
	private var cancellables = Set<AnyCancellable>()
	
	init() {
		addSubscriber()
	}
	
	private func addSubscriber() {
		
		$searchText
			.debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
			.combineLatest(coinDataService.$allCoins)
			.map(filterCoins)
			.sink { [weak self ]coins in
				self?.allCoins = coins
			}
			.store(in: &cancellables)
		
		marketDataService.$marketData
			.map(mapGlobalMarketData)
			.sink { [weak self] returnedStatistics in
				self?.statistics = returnedStatistics
			}
			.store(in: &cancellables)
	}
	
	private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
		guard !text.isEmpty else {
			return coins
		}
		let lowercasedText = text.lowercased()
		return coins.filter { (coin) -> Bool in
			coin.name.lowercased().contains(lowercasedText) ||
			coin.symbol.lowercased().contains(lowercasedText) ||
			coin.id.lowercased().contains(lowercasedText)
		}
	}
	
	private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel] {
			var stats: [StatisticModel] = []
			guard let data = marketDataModel else { return stats }
			
			let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
			let volume = StatisticModel(title: "24h Volume", value: data.volume)
			let btcDominance = StatisticModel(title: "Btc Dominance", value: data.btcDominance)
			let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
			
			stats.append(contentsOf: [
				marketCap,
				volume,
				btcDominance,
				portfolio
			])
			return stats
	}
}
