//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 01.07.2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
	
	@Published var statistics: [StatisticModel] = [
		StatisticModel(title: "Title", value: "Value", percentageChange: 1),
		StatisticModel(title: "Title", value: "Value", percentageChange: 0),
		StatisticModel(title: "Title", value: "Value"),
		StatisticModel(title: "Title", value: "Value", percentageChange: -1)
	]
	@Published var allCoins: [CoinModel] = []
	@Published var portfolioCoins: [CoinModel] = []
	
	@Published var searchText: String = ""
	
	private let coinDataService = CoinDataService()
	private let marketDataService = MarketDataService()
	private var cancellables = Set<AnyCancellable>()
	
	init() {
		addSubscriber()
//		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//			self.allCoins.append(DeveloperPreview.instance.coin)
//			self.portfolioCoins.append(DeveloperPreview.instance.coin)
//		}
	}
	
	private func addSubscriber() {
//		dataService.$allCoins
//			.sink { [weak self] returnedCoins in
//				self?.allCoins = returnedCoins
//			}
//			.store(in: &cancellables)
		
		$searchText
			.debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
			.combineLatest(coinDataService.$allCoins)
			.map(filterCoins)
			.sink { [weak self ]coins in
				self?.allCoins = coins
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
}
