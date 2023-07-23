//
//  MarketDataModel.swift
//  CryptoApp
//
//  Created by Симонов Иван Дмитриевич on 23.07.2023.
//

import Foundation

struct GlobalData: Codable {
	let data: MarketDataModel?
}

struct MarketDataModel: Codable {
	let totalMarketCap, totalvolume, marketCapPercentage: [String: Double]
	let marketCapChangePercentage24HUsd: Double
	
	var marketCap: String {
		if let item = totalMarketCap.first(where: {$0.key == "usd"}) {
			return "\(item.value)"
		} else {
			return ""
		}
	}
	
	var volume: String {
		if let item = totalvolume.first(where: {$0.key == "usd"}) {
			return "\(item.value)"
		} else {
			return ""
		}
	}
	
	var btcDominance: String {
		if let item = marketCapPercentage.first(where: {$0.key == "btc"}) {
			return item.value.asPercentString()
		} else {
			return ""
		}
	}
}
