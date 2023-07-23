//
//  CoinModel.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 18.06.2023.
//

import Foundation

/*
 URL
 https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=en
 */

struct CoinModel: Codable, Identifiable {
	let id, symbol, name, image: String
	let currentPrice: Double
	let marketCap, marketCapRank, fullyDilutedValuation, totalVolume, high24H, low24H: Double?
	let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
	let circulatingSupply, totalSupply, maxSupply, ath, athChangePercentage: Double?
	let athDate: String?
	let atl, atlChangePercentage: Double?
	let atlDate: String?
	let roi: Roi?
	let lastUpdated: String?
	let sparklineIn7D: SparklineIn7D?
	let priceChangePercentage24HInCurrency: Double?
	let currentHoldings: Double?
	
//	enum CodingKeys: String, CodingKey {
//		case id, symbol, name, image
//		case currentPrice = "current_price"
//		...
//	}
	
	func updateHoldings(amount: Double) -> CoinModel {
		return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: ath, atlChangePercentage: atlChangePercentage, atlDate: atlDate, roi: roi, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
	}
	
	var currentHoldingsValue: Double {
		(currentHoldings ?? 0) * currentPrice
	}
	
	var rank: Int {
		Int(marketCapRank ?? 0)
	}
}

struct SparklineIn7D: Codable {
	let price: [Double]
}

struct Roi: Codable {
	let times: Double
	let currency: String
	let percentage: Double
}
